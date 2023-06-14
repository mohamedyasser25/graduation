import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gp2023/modules/_applicant/create_cv_layout/create_cv_Education/cubit/states.dart';
import 'package:gp2023/shared/constants/constants.dart';

import '../../../../../shared/caching/cache_helper.dart';
import '../../../../../shared/models/EducationModel.dart';

class CreateCVEducationCubit extends Cubit<CreateCvEducationStates> {
  CreateCVEducationCubit() : super(CreateCvEducationInitialState());

  static CreateCVEducationCubit get(context) => BlocProvider.of(context);

  var formKey = GlobalKey<FormState>();

  var startDateTimeController = TextEditingController();
  var endDateTimeController = TextEditingController();

  var educationLevelsValue = defaultDropDownListValue;
  var facultiesValue = defaultDropDownListValue;
  var universityValue = defaultDropDownListValue;

  void educationCreate(
      {required bool isEditing,
      required String educationLevel,
      required String university,
      required String faculty,
      required String startDate,
      required String endDate,
      required String uId}) {
    EducationModel model = EducationModel(
        educationLevel: educationLevel,
        university: university,
        faculty: faculty,
        startDate: startDate,
        endDate: endDate,
        uId: uId);
    saveEducationData(model, isEditing);
  }

  void saveEducationData(EducationModel M, bool isEditing) async {
    if (isEditing) {
      final userEducation = await FirebaseFirestore.instance
          .collection('Education')
          .where('uId', isEqualTo: CacheHelper.getData(key: "uId"))
          .get();
      print('xxxxxx userExperience for id: ${CacheHelper.getData(key: "uId")}');
      print('xxxxxx userExperience for id: ${userEducation.docs.length}');
      String id = userEducation.docs[0].id;
      print('xxxxxx id: ${id}');

      FirebaseFirestore.instance.collection('Education').doc(id).update(M.toMap()).then((value) {
        CacheHelper.saveData(key: 'eduStartDate', value: startDateTimeController.text);
        CacheHelper.saveData(key: 'eduEndDate', value: endDateTimeController.text);
        CacheHelper.saveData(key: 'eduLevel', value: educationLevelsValue);
        CacheHelper.saveData(key: 'faculty', value: facultiesValue);
        CacheHelper.saveData(key: 'university', value: universityValue);

        emit(CreateCvEducationSuccessState(M.uId));
      }).catchError((error) {
        emit(CreateCvEducationErrorState(error.toString()));
      });
    } else {
      FirebaseFirestore.instance.collection('Education').add(M.toMap()).then((value) {
        CacheHelper.saveData(key: 'eduStartDate', value: startDateTimeController.text);
        CacheHelper.saveData(key: 'eduEndDate', value: endDateTimeController.text);
        CacheHelper.saveData(key: 'eduLevel', value: educationLevelsValue);
        CacheHelper.saveData(key: 'faculty', value: facultiesValue);
        CacheHelper.saveData(key: 'university', value: universityValue);

        emit(CreateCvEducationSuccessState(M.uId));
      }).catchError((error) {
        emit(CreateCvEducationErrorState(error.toString()));
      });
    }
  }

  void changeCityState(String cityOut) {
    universityValue = cityOut;
    emit(CreateCvEducationChangeCityState());
  }

  void changeNationalityState(String nationalityOut) {
    universityValue = nationalityOut;
    emit(CreateCvEducationChangeNationalityState());
  }

  void changeEducationLevelState(String educationLevelValue) {
    educationLevelsValue = educationLevelValue;
    emit(CreateCvEducationChangeeducationLevelState());
  }

  void changeFacultyState(String facultyValue) {
    facultiesValue = facultyValue;
    emit(CreateCvEducationChangeFacultyState());
  }

  setRegisterData() {
    startDateTimeController.text = CacheHelper.getData(key: "eduStartDate") ?? '';
    endDateTimeController.text = CacheHelper.getData(key: "eduEndDate") ?? '';

    educationLevelsValue = CacheHelper.getData(key: "eduLevel") ?? '--Select--';
    facultiesValue = CacheHelper.getData(key: "faculty") ?? '--Select--';
    universityValue = CacheHelper.getData(key: "university") ?? '--Select--';
  }
}