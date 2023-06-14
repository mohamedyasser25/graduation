import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gp2023/modules/_hr/company_regiseter/cubit/states.dart';
import 'package:gp2023/shared/caching/cache_helper.dart';
import 'package:gp2023/shared/constants/constants.dart';

import '../../../../shared/models/companyModel.dart';

class HrRegisterCubit extends Cubit<HrRegisterStates> {
  HrRegisterCubit() : super(HrRegisterInitialState());

  static HrRegisterCubit get(context) => BlocProvider.of(context);

  var formKey = GlobalKey<FormState>();
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var companyCodeController = TextEditingController();
  var cityValue = defaultDropDownListValue;
  var countriesValue = defaultDropDownListValue;
  var phoneController = TextEditingController();
  var descriptionController = TextEditingController();

  void changeCityState(String cityOut) {
    cityValue = cityOut;
    emit(HrDataChangeCityState());
  }

  void changeCountryState(String countryValue) {
    countriesValue = countryValue;
    emit(HrDataChangeCountryState());
  }

  void companyCreate({
    required String companyName,
    required String companyEmail,
    required String cityValue,
    required String countriesValue,
    required int companyCode,
    required String phone,
    required String description,
  }) {
    CompanyModel model = CompanyModel(
        name: companyName,
        email: companyEmail,
        city: cityValue,
        country: countriesValue,
        taxNumber: companyCode,
        phone: phone,
        description: description);

    FirebaseFirestore.instance.collection('company').add(model.toMap()).then((value) {
      CacheHelper.saveData(key: 'companyId', value: value.id);
      CacheHelper.saveData(key: 'companyName', value: companyName);
      CacheHelper.saveData(key: 'compName', value: companyName);
      CacheHelper.saveData(key: 'compEmail', value: companyEmail);
      CacheHelper.saveData(key: 'compCode', value: companyCode);
      CacheHelper.saveData(key: 'compPhone', value: phone);
      CacheHelper.saveData(key: 'compDescription', value: description);
      CacheHelper.saveData(key: 'compCity', value: cityValue);
      CacheHelper.saveData(key: 'compCountry', value: countriesValue);

      emit(HrRegisterSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(HrRegisterErrorState(error.toString()));
    });
  }

  setRegisterData() {
    print('hiiiiiiii 1.1 ${CacheHelper.getData(key: 'companyName')}');
    print('hiiiiiiii 1.1 ${CacheHelper.getData(key: 'companyId')}');
    print('hiiiiiiii 1.1 ${CacheHelper.getData(key: 'compPhone')}');
    print('hiiiiiiii 1.1 ${CacheHelper.getData(key: 'compCity')}');
    print('hiiiiiiii 1.1 ${CacheHelper.getData(key: 'compDescription')}');

    nameController.text = CacheHelper.getData(key: "compName") ?? '';
    print('hiii ${nameController.text}');
    emailController.text = CacheHelper.getData(key: "compEmail") ?? '';
    print('hiii ${emailController.text}');
    companyCodeController.text = '${CacheHelper.getData(key: "compCode") ?? ''}';
    print('hiii ${companyCodeController.text}');
    phoneController.text = CacheHelper.getData(key: "compPhone") ?? '';
    print('hiii ${phoneController.text}');
    descriptionController.text = CacheHelper.getData(key: "compDescription") ?? '';
    print('hiii ${descriptionController.text}');
    cityValue = CacheHelper.getData(key: "compCity") ?? defaultDropDownListValue;
    print('hiii ${cityValue}');
    countriesValue = CacheHelper.getData(key: "compCountry") ?? defaultDropDownListValue;
    print('hiii ${countriesValue}');
    emit(HrRegisterSuccessState());
  }

  void companyUpdate({
    required String companyName,
    required String companyEmail,
    required String cityValue,
    required String countriesValue,
    required int companyCode,
    required String phone,
    required String description,
  }) {
    CompanyModel model = CompanyModel(
        name: companyName,
        email: companyEmail,
        city: cityValue,
        country: countriesValue,
        taxNumber: companyCode,
        phone: phone,
        description: description);

    FirebaseFirestore.instance
        .collection('company')
        .doc(CacheHelper.getData(key: 'companyId'))
        .update(model.toMap())
        .then((value) {
      CacheHelper.saveData(key: 'companyName', value: companyName);
      CacheHelper.saveData(key: 'compName', value: companyName);
      CacheHelper.saveData(key: 'compEmail', value: companyEmail);
      CacheHelper.saveData(key: 'compCode', value: companyCode);
      CacheHelper.saveData(key: 'compPhone', value: phone);
      CacheHelper.saveData(key: 'compDescription', value: description);
      CacheHelper.saveData(key: 'compCity', value: cityValue);
      CacheHelper.saveData(key: 'compCountry', value: countriesValue);

      emit(HrRegisterSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(HrRegisterErrorState(error.toString()));
    });
  }
}