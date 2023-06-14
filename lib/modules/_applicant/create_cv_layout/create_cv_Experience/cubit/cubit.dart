import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gp2023/modules/_applicant/create_cv_layout/create_cv_Experience/cubit/states.dart';
import 'package:gp2023/shared/constants/constants.dart';

import '../../../../../shared/caching/cache_helper.dart';
import '../../../../../shared/models/ExperienceModel.dart';

class CreateCVExperienceCubit extends Cubit<CreateCVExperienceStates> {
  var positionsValue = defaultDropDownListValue;

  CreateCVExperienceCubit() : super(CreateCVExperienceInitialState());

  static CreateCVExperienceCubit get(context) => BlocProvider.of(context);

  var formKey = GlobalKey<FormState>();
  var companyNameController = TextEditingController();

  var startDateTimeController = TextEditingController();
  var endDateTimeController = TextEditingController();

  void experienceCreate(
      {required String companyName,
      required String position,
      required String startDate,
      required String endDate,
      required String uId}) {
    ExperienceModel model = ExperienceModel(
        companyName: companyName,
        position: position,
        startDate: startDate,
        endDate: endDate,
        uId: uId);
    saveExperienceData(model);
  }

  void saveExperienceData(ExperienceModel M) async {
    bool isEditing = CacheHelper.getData(key: 'exprPosition') != null;
    if (isEditing) {
      final userExperience = await FirebaseFirestore.instance
          .collection('Experience')
          .where('uId', isEqualTo: CacheHelper.getData(key: "uId"))
          .get();
      print('xxxxxx userExperience for id: ${CacheHelper.getData(key: "uId")}');
      print('xxxxxx userExperience for id: ${userExperience.docs.length}');
      String id = userExperience.docs[0].id;
      print('xxxxxx id: ${id}');

      FirebaseFirestore.instance.collection('Experience').doc(id).update(M.toMap()).then((value) {
        CacheHelper.saveData(key: 'exprCompany', value: companyNameController.text);
        CacheHelper.saveData(key: 'exprPosition', value: positionsValue);
        CacheHelper.saveData(key: 'exprStartDate', value: startDateTimeController.text);
        CacheHelper.saveData(key: 'exprEndDate', value: endDateTimeController.text);

        emit(CreateCVExperienceSuccessState(M.uId));
      }).catchError((error) {
        emit(CreateCVExperienceErrorState(error.toString()));
      });
    } else {
      FirebaseFirestore.instance.collection('Experience').add(M.toMap()).then((value) {
        CacheHelper.saveData(key: 'exprCompany', value: companyNameController.text);
        CacheHelper.saveData(key: 'exprPosition', value: positionsValue);
        CacheHelper.saveData(key: 'exprStartDate', value: startDateTimeController.text);
        CacheHelper.saveData(key: 'exprEndDate', value: endDateTimeController.text);

        emit(CreateCVExperienceSuccessState(M.uId));
      }).catchError((error) {
        emit(CreateCVExperienceErrorState(error.toString()));
      });
    }
  }

  void changePositionState(String positionValue) {
    positionsValue = positionValue;
    emit(CreateCVExperienceChangePositionState());
  }

  setRegisterData() {
    startDateTimeController.text = CacheHelper.getData(key: "exprStartDate") ?? '';
    endDateTimeController.text = CacheHelper.getData(key: "exprEndDate") ?? '';
    companyNameController.text = CacheHelper.getData(key: "exprCompany") ?? '';
    positionsValue = CacheHelper.getData(key: "exprPosition") ?? '--Select--';
  }
}