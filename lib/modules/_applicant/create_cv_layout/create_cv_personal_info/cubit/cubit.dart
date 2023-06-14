import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gp2023/modules/_applicant/create_cv_layout/create_cv_personal_info/cubit/states.dart';
import 'package:gp2023/shared/caching/cache_helper.dart';
import 'package:gp2023/shared/constants/constants.dart';

import '../../../../../shared/models/CVModel.dart';

class CreateCVPersonalInfoCubit extends Cubit<CreateCVPersonalInfoStates> {
  var formKey = GlobalKey<FormState>();
  var dateTime = DateTime.now();
  var dateTimeController = TextEditingController();
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();
  var genderController = TextEditingController();

  var cityValue = defaultDropDownListValue;
  var countriesValue = defaultDropDownListValue;
  var nationalitiesValue = defaultDropDownListValue;
  var jopTitleValue = defaultDropDownListValue;
  var genderValue = defaultDropDownListValue;
  var gradeValue = defaultDropDownListValue;

  CreateCVPersonalInfoCubit() : super(CreateCVPersonalInfoInitialState());

  static CreateCVPersonalInfoCubit get(context) => BlocProvider.of(context);

  void cvCreate(
      {required bool isEditing,
      required String name,
      required String phone,
      required String email,
      required String gender,
      required String jobTitle,
      required String degree,
      required String city,
      required String nationality,
      required String dateOfBirth,
      required String uId}) {
    CVModel model = CVModel(
        city: city,
        name: name,
        phone: phone,
        email: email,
        degree: degree,
        gender: gender,
        nationality: nationality,
        dateOfBirth: dateOfBirth,
        jobTitle: jobTitle,
        uId: uId);
    saveCVData(model, isEditing);
  }

  final List<CVModel> cvDataList = [];

  void setRegisterData() async {
    nameController.text = CacheHelper.getData(key: "name") ?? '';
    phoneController.text = CacheHelper.getData(key: "phone") ?? '';
    emailController.text = CacheHelper.getData(key: "email") ?? '';
    bool isMale = CacheHelper.getData(key: 'isMale') ?? true;
    genderValue = isMale ? "Male" : "Female";
    dateTimeController.text = CacheHelper.getData(key: "dob") ?? '';
    cityValue = CacheHelper.getData(key: "city") ?? '--Select--';
    nationalitiesValue = CacheHelper.getData(key: "nationality") ?? '--Select--';
    jopTitleValue = CacheHelper.getData(key: "jopTitle") ?? '--Select--';

    await FirebaseFirestore.instance.collection('cv').get().then(((value) {
      for (var element in value.docs) {
        if (element.data()['uId'] == uId) {
          CVModel model;
          model = CVModel.fromJson(element.data());
          cvDataList.add(model);
        }
      }
      jopTitleValue = cvDataList[0].jobTitle.toString() ?? '';
      cityValue = cvDataList[0].city.toString() ?? '';
      nationalitiesValue = cvDataList[0].nationality.toString() ?? '';
      dateTimeController.text = cvDataList[0].dateOfBirth.toString() ?? '';
      emit(CreateCVPersonalInfoGetCvDataState());
    }));
  }

  void saveCVData(CVModel M, bool isEditing) async {
    // try {
    if (isEditing) {
      final userCV = await FirebaseFirestore.instance
          .collection('cv')
          .where('uId', isEqualTo: CacheHelper.getData(key: "uId"))
          .get();
      print('xxxxxx editting cv for id: ${CacheHelper.getData(key: "uId")}');
      print('xxxxxx editting cv for id: ${userCV.docs.length}');
      String id = userCV.docs[0].id;
      print('xxxxxx id: ${id}');
      await FirebaseFirestore.instance.collection('cv').doc(id).update(M.toMap());
    } else {
      await FirebaseFirestore.instance.collection('cv').add(M.toMap());
    }
    CacheHelper.saveData(key: 'name', value: nameController.text);
    CacheHelper.saveData(key: 'email', value: emailController.text);
    CacheHelper.saveData(key: 'phone', value: phoneController.text);
    CacheHelper.saveData(key: 'gender', value: genderValue);
    CacheHelper.saveData(key: 'jobTitle', value: jopTitleValue);
    CacheHelper.saveData(key: 'city', value: cityValue);
    CacheHelper.saveData(key: 'nationality', value: nationalitiesValue);
    CacheHelper.saveData(key: 'dob', value: dateTimeController.text);
    CacheHelper.saveData(key: 'city', value: cityValue);

    emit(CreateCVPersonalInfoSuccessState(M.uId));
    // } catch (error) {
    //   emit(CreateCVPersonalInfoErrorState(error.toString()));
    // }
  }

  void changeCityState(String cityOut) {
    cityValue = cityOut;
    emit(CreateCVPersonalInfoChangeCityState());
  }

  void changeCountryState(String countryValue) {
    countriesValue = countryValue;
    emit(CreateCVPersonalInfoChangeCountryState());
  }

  void changeNationalityState(String nationalityValue) {
    nationalitiesValue = nationalityValue;
    emit(CreateCVPersonalInfoChangeNationalityState());
  }

  void changeJopTitleState(String JopTitleValue) {
    jopTitleValue = JopTitleValue;
    emit(CreateCVPersonalInfoChangeJopTitleState());
  }

  void changeGenderState(String GenderValue) {
    genderValue = GenderValue;
    emit(CreateCVPersonalInfoChangeGenderState());
  }

  void changeGradeState(String GradeValue) {
    gradeValue = GradeValue;
    emit(CreateCVPersonalInfoChangeGradeState());
  }
}