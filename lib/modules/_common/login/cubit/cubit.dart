import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gp2023/shared/constants/constants.dart';

import '../../../../main.dart';
import '../../../../shared/caching/cache_helper.dart';
import '../../../_hr/company_regiseter/cubit/cubit.dart';
import 'states.dart';

class WorkableLoginCubit extends Cubit<WorkableLoginStates> {
  WorkableLoginCubit() : super(WorkableLoginInitialState());

  static WorkableLoginCubit get(context) => BlocProvider.of(context);

  void userLogin(
    context, {
    required String email,
    required String password,
  }) {
    emit(WorkableLoginLoadingState());

    FirebaseAuth.instance
        .signInWithEmailAndPassword(
      email: email,
      password: password,
    )
        .then((value1) {
      uId = value1.user!.uid;
      FirebaseFirestore.instance.collection('Applicant').doc(value1.user!.uid).get().then((value2) {
        IS_APPLICANT = value2.data()!['isApplicant'];
        CacheHelper.saveData(key: 'isApplicant', value: IS_APPLICANT);
        CacheHelper.saveData(key: 'name', value: value2.data()!['name']);
        CacheHelper.saveData(key: 'email', value: value2.data()!['email']);
        CacheHelper.saveData(key: 'phone', value: value2.data()!['phone']);
        CacheHelper.saveData(key: 'isMale', value: value2.data()!['isMale']);
        if (!IS_APPLICANT) {
          FirebaseFirestore.instance
              .collection('company')
              .where('hrID', isEqualTo: value1.user!.uid)
              .get()
              .then((value3) {
            if (value3.docs.isNotEmpty) {
              CacheHelper.saveData(key: 'companyName', value: value3.docs.first.data()['name']);
              CacheHelper.saveData(key: 'companyId', value: value3.docs.first.id);
              CacheHelper.saveData(key: 'compName', value: value3.docs.first.data()['name']);
              CacheHelper.saveData(key: 'compEmail', value: value3.docs.first.data()['email']);
              CacheHelper.saveData(
                  key: 'compCode', value: value3.docs.first.data()['taxNumber'].toString());
              CacheHelper.saveData(key: 'compPhone', value: value3.docs.first.data()['phone']);
              CacheHelper.saveData(
                  key: 'compDescription', value: value3.docs.first.data()['description']);
              CacheHelper.saveData(key: 'compCity', value: value3.docs.first.data()['city']);
              CacheHelper.saveData(key: 'compCountry', value: value3.docs.first.data()['country']);
              HrRegisterCubit.get(context).setRegisterData();
            } else {
              CacheHelper.saveData(key: 'companyName', value: "NONE");
            }
            emit(WorkableLoginSuccessState(value1.user!.uid));
          });
        } else {
          emit(WorkableLoginSuccessState(value1.user!.uid));
        }
      }).catchError((error) {
        print(error.toString());
        emit(WorkableLoginErrorState(error.toString()));
      });
      emit(WorkableLoginSuccessState(value1.user!.uid));
    }).catchError((error) {
      emit(WorkableLoginErrorState(error.toString()));
    });
  }

  IconData suffix = Icons.visibility_outlined;
  bool isPassword = true;

  void changePasswordVisibility() {
    isPassword = !isPassword;
    suffix = isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;

    emit(WorkableChangePasswordVisibilityState());
  }
}