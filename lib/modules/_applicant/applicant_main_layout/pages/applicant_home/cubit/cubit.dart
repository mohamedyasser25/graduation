import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gp2023/modules/_applicant/applicant_main_layout/pages/applicant_home/cubit/states.dart';

import '../../../../../../shared/models/job_model.dart';

class ApplicantRegisterCubit extends Cubit<ApplicantRegisterStates> {
  ApplicantRegisterCubit() : super(ApplicantHomeInitialState());

  int jobsCount = 0;
  List<JobModel> searchList = [];
  List<JobModel> listOfJobs = [];
  List<JobModel> listOfJobsMaster = [];

  static ApplicantRegisterCubit get(context) => BlocProvider.of(context);

  void getApplicantRegisterString() {
    emit(ApplicantUserStringState());
  }

  getAllJobs() async {
    FirebaseFirestore.instance.collection('jobs').snapshots().listen((event) {
      // listOfJobsMaster =
      // event.docs.map((x) => job_model.fromJson(x.data()["id"])).toList();
      listOfJobsMaster = event.docs.map((x) {
        var data = x.data();
        data["id"] = x.id;
        return JobModel.fromJson(data);
      }).toList();

      listOfJobs =
          listOfJobsMaster.where((element) => element.endDate!.isAfter(DateTime.now())).toList();

      emit(ApplicantHomeSearchState());
    });
  }

  void updateJobList(BuildContext context) {}

  void changeListSearch(String search, BuildContext context) {
    if (search.isEmpty) {
      listOfJobs = listOfJobsMaster;
    } else {
      if (search.toLowerCase() == 'it') {
        listOfJobs = listOfJobsMaster
            .where((element) => (element.jobTitle! == 'front end web Developer' ||
                element.jobTitle! == 'Web Developer' ||
                element.jobTitle! == 'Integration' ||
                element.jobTitle! == 'IT Application Integration Technology Technical Manager' ||
                element.jobTitle! == 'full stack intern' ||
                element.jobTitle! == 'Embedded Software Engineer' ||
                element.jobTitle! == 'SaaS AI invoicing & estimate platform - Contractors' ||
                element.jobTitle! == 'Azure Synape Microsoft Arthitect/Engineer' ||
                element.jobTitle! == 'Core-java-tutor' ||
                element.jobTitle! == 'UI/UX designer'))
            .toList();
        emit(ApplicantHomeSearchState());
      } else if (search == 'finance') {
        listOfJobs = listOfJobsMaster
            .where((element) => (element.jobTitle! == 'Business Systems Analyst' ||
                element.jobTitle! == 'Permanent Part-Time Sales Assistant' ||
                element.jobTitle! == 'Sales Assistant' ||
                element.jobTitle! == 'Finance Assistance' ||
                element.jobTitle! == 'Sales Consultant at Liberty' ||
                element.jobTitle! == 'accountant' ||
                element.jobTitle! == 'Internal Sales' ||
                element.jobTitle! == 'Client Services Store Co-ordinator' ||
                element.jobTitle! == 'Group Marketing Manager'))
            .toList();
        emit(ApplicantHomeSearchState());
      } else if (search == 'medicine') {
        listOfJobs = listOfJobsMaster
            .where((element) => (element.jobTitle! == 'medical senior officer' ||
                element.jobTitle! == 'Quayside Superintendent' ||
                element.jobTitle! == 'patient safety specialist' ||
                element.jobTitle! == 'medical representative'))
            .toList();
        emit(ApplicantHomeSearchState());
      } else if (search == 'other') {
        listOfJobs = listOfJobsMaster
            .where((element) => (element.jobTitle! == 'Recruitment Specialist' ||
                element.jobTitle! == 'Driver' ||
                element.jobTitle! == 'receptionist' ||
                element.jobTitle! == 'Customer Service Consultant' ||
                element.jobTitle! == 'Vessel Manager x 2' ||
                element.jobTitle! == 'college management system' ||
                element.jobTitle! == 'social media moderator' ||
                element.jobTitle! == 'Head of Pre School in London UK'))
            .toList();
        emit(ApplicantHomeSearchState());
      } else {
        listOfJobs = listOfJobsMaster
            .where((element) => (element.jobDescription! +
                    element.jobTitle! +
                    element.salary.toString() +
                    element.jobType!)
                .toLowerCase()
                .contains(search.toLowerCase()))
            .toList();
        emit(ApplicantHomeSearchState());
      }
    }
  }

  void changeListFromFilter(
    BuildContext context, {
    // String? jobTitle,
    String? jobCat,
    String? jobType,
    String? city,
    String? country,
    double? salary,
    String? fromDate,
    String? jopType,
    String? toDate,
  }) {
    DateTime now = DateTime.now();

    if (jobCat?.toLowerCase() == 'it') {
      listOfJobs = listOfJobsMaster
          .where((element) => ((element.jobTitle! == 'front end web Developer' ||
                  element.jobTitle! == 'Web Developer' ||
                  element.jobTitle! == 'Integration' ||
                  element.jobTitle! == 'IT Application Integration Technology Technical Manager' ||
                  element.jobTitle! == 'full stack intern' ||
                  element.jobTitle! == 'Embedded Software Engineer' ||
                  element.jobTitle! == 'SaaS AI invoicing & estimate platform - Contractors' ||
                  element.jobTitle! == 'Azure Synape Microsoft Arthitect/Engineer' ||
                  element.jobTitle! == 'Core-java-tutor' ||
                  element.jobTitle! == 'UI/UX designer') &&
              salary != null &&
              element.salary!.compareTo(salary) >= 0 &&
              (element.endDate as DateTime).isAfter(DateTime.now()) &&
              jobType!.contains(element.jobType!)))
          .toList();
      emit(ApplicantHomeSearchState());
    } else if (jobCat == 'finance') {
      listOfJobs = listOfJobsMaster
          .where((element) => ((element.jobTitle! == 'Business Systems Analyst' ||
                  element.jobTitle! == 'Permanent Part-Time Sales Assistant' ||
                  element.jobTitle! == 'Sales Assistant' ||
                  element.jobTitle! == 'Finance Assistance' ||
                  element.jobTitle! == 'Sales Consultant at Liberty' ||
                  element.jobTitle! == 'accountant' ||
                  element.jobTitle! == 'Internal Sales' ||
                  element.jobTitle! == 'Client Services Store Co-ordinator' ||
                  element.jobTitle! == 'Group Marketing Manager') &&
              salary != null &&
              (element.endDate as DateTime).isAfter(DateTime.now()) &&
              element.salary!.compareTo(salary) >= 0 &&
              jobType!.contains(element.jobType!)))
          .toList();
      emit(ApplicantHomeSearchState());
    } else if (jobCat == 'medicine') {
      listOfJobs = listOfJobsMaster
          .where((element) => ((element.jobTitle! == 'medical senior officer' ||
                  element.jobTitle! == 'Quayside Superintendent' ||
                  element.jobTitle! == 'patient safety specialist' ||
                  element.jobTitle! == 'medical representative') &&
              salary != null &&
              (element.endDate as DateTime).isAfter(DateTime.now()) &&
              element.salary!.compareTo(salary) >= 0 &&
              jobType!.contains(element.jobType!)))
          .toList();
      emit(ApplicantHomeSearchState());
    } else if (jobCat == 'other') {
      listOfJobs = listOfJobsMaster
          .where((element) => ((element.jobTitle! == 'Recruitment Specialist' ||
                  element.jobTitle! == 'Driver' ||
                  element.jobTitle! == 'receptionist' ||
                  element.jobTitle! == 'Customer Service Consultant' ||
                  element.jobTitle! == 'Vessel Manager x 2' ||
                  element.jobTitle! == 'college management system' ||
                  element.jobTitle! == 'social media moderator' ||
                  element.jobTitle! == 'Head of Pre School in London UK') &&
              salary != null &&
              element.salary!.compareTo(salary) >= 0 &&
              (element.endDate as DateTime).isAfter(DateTime.now()) &&
              jobType!.contains(element.jobType!)))
          .toList();
      emit(ApplicantHomeSearchState());
    }

    // listOfJobs = listOfJobsMaster
    //     .where((element) =>
    //             element.jobTitle?.toLowerCase() == jobTitle?.toLowerCase() &&
    //             salary != null &&
    //             element.salary!.compareTo(salary) >= 0 &&
    //             jobType!.contains(element.jobType!)
    //         // &&
    //         // element.startDate.isAfter(startDate)
    //         // &&
    //         // element.endDate.isBefore(endDate)
    //
    //         )
    //     .toList();

    emit(ApplicantHomeSearchState());
    // }
  }

  void restListFromFilter() {
    // if (search.isEmpty) {
    //   listOfJobs = listOfJobsMaster;
    // } else {
    listOfJobs = listOfJobsMaster
        .where((element) => (element.endDate as DateTime).isAfter(DateTime.now()))
        .toList();
    emit(ApplicantHomeSearchState());
    // }
  }

// void changeListSearch(String search, BuildContext context) {
//   if (search.isEmpty) {
//     listofJobs = JobSearch().streamBuilder('', 'JobTitle');
//   } else {
//     listofJobs = JobSearch().streamBuilder(search, 'JobTitle');
//     emit(ApplicantHomeSearchState());
//   }
// }
}