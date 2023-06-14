import 'package:flutter/material.dart';
import 'package:gp2023/modules/_applicant/create_cv_layout/create_cv_personal_info/create_cv_personal_info_screen.dart';
import 'package:gp2023/shared/models/JobApplicationModel.dart';
import 'package:gp2023/shared/models/job_model.dart';
import 'package:intl/intl.dart';

import '../../../shared/caching/cache_helper.dart';
import '../../../shared/components/components.dart';
import '../../../shared/widgets/date_picker.dart';
import '../../_common/job_details/job_details_screen.dart';
import 'cubit/cubit.dart';

class ReviewApplicationScreen extends StatelessWidget {
  static const id = 'ReviewApplicationScreen';

  final JobApplicationModel application;
  final bool showBtns;
  final JobModel? job;

  ReviewApplicationScreen({Key? key, required this.application, this.showBtns = false, this.job})
      : super(key: key);

  TextEditingController ctrlFeedback = TextEditingController();
  TextEditingController ctrlInterviewDate = TextEditingController();
  TextEditingController ctrlInterviewTime = TextEditingController();
  String selectedInterviewDate = '';
  String selectedInterviewTime = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: showBtns == true
          ? null
          : FloatingActionButton(
              onPressed: () {
                navigateTo(context, CreateCVPersonalInfoScreen());
              },
              backgroundColor: Colors.blue,
              mini: true,
              child: Icon(Icons.edit),
            ),
      appBar: AppBar(
        title: const Text(
          'CV',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const SizedBox(height: 20),
                      FutureBuilder(
                        future: JobApplicationsCubit.get(context).getApplicantProfile(application),
                        builder: (_, AsyncSnapshot<dynamic> snapshot) {
                          print('xxxxxxx ${snapshot.data}');
                          // cv personal info
                          CacheHelper.saveData(key: 'name', value: snapshot.data?['name']);
                          CacheHelper.saveData(key: 'email', value: snapshot.data?['email']);
                          CacheHelper.saveData(key: 'phone', value: snapshot.data?['phone']);
                          CacheHelper.saveData(key: 'gender', value: snapshot.data?['gender']);
                          CacheHelper.saveData(key: 'jobTitle', value: snapshot.data?['jobTitle']);
                          CacheHelper.saveData(key: 'city', value: snapshot.data?['city']);
                          CacheHelper.saveData(
                              key: 'nationality', value: snapshot.data?['nationality']);
                          CacheHelper.saveData(key: 'dob', value: snapshot.data?['dob']);
                          CacheHelper.saveData(key: 'city', value: snapshot.data?['city']);

                          return Card(
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                            elevation: 5,
                            child: Padding(
                              padding: EdgeInsets.all(12),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(Icons.account_circle, size: 80, color: Colors.blue),
                                  SizedBox(height: 8),
                                  Text(
                                    '${snapshot.data?['name']}',
                                    style: TextStyle(
                                      color: Colors.black87,
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(height: 8),
                                  Text(
                                    '${snapshot.data?['jobTitle']}',
                                    style: TextStyle(
                                      color: Colors.black87,
                                      fontSize: 18,
                                    ),
                                  ),
                                  Divider(height: 20, color: Colors.blue),
                                  SizedBox(height: 10),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: MyDataItem(
                                            Icons.mail_outline, '${snapshot.data?['email']}'),
                                      ),
                                      Expanded(
                                        child: MyDataItem(Icons.call, '${snapshot.data?['phone']}'),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: MyDataItem(
                                            Icons.language, '${snapshot.data?['nationality']}'),
                                      ),
                                      Expanded(
                                        child: MyDataItem(Icons.location_on_outlined,
                                            '${snapshot.data?['city']}'),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                        child:
                                            MyDataItem(Icons.male, '${snapshot.data?['gender']}'),
                                      ),
                                      // Expanded(
                                      //   child: MyDataItem(Icons.file_copy_outlined,
                                      //       '${snapshot.data?['degree']}'),
                                      // ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: 30),
                      const Text(
                        'Education',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20, color: Colors.blue),
                      ),
                      const SizedBox(height: 10),
                      FutureBuilder(
                        future:
                            JobApplicationsCubit.get(context).getApplicantEducation(application),
                        builder: (_, AsyncSnapshot<dynamic> snapshot) {
                          CacheHelper.saveData(
                              key: 'eduStartDate', value: snapshot.data?['startDate']);
                          CacheHelper.saveData(key: 'eduEndDate', value: snapshot.data?['endDate']);
                          CacheHelper.saveData(
                              key: 'eduLevel', value: snapshot.data?['educationLevel']);
                          CacheHelper.saveData(key: 'faculty', value: snapshot.data?['faculty']);
                          CacheHelper.saveData(
                              key: 'university', value: snapshot.data?['university']);

                          return Card(
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                            elevation: 5,
                            child: Padding(
                              padding: EdgeInsets.all(16),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  MyDataItem(Icons.account_balance_outlined,
                                      '${snapshot.data?['educationLevel']} in Faculty of ${snapshot.data?['faculty']}\n[${snapshot.data?['university']}]'),
                                  MyDataItem(Icons.date_range,
                                      '${snapshot.data?['startDate']} - ${snapshot.data?['endDate']}'),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: 30),
                      const Text(
                        'Experience',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20, color: Colors.blue),
                      ),
                      const SizedBox(height: 10),
                      FutureBuilder(
                        future:
                            JobApplicationsCubit.get(context).getApplicantExperience(application),
                        builder: (_, AsyncSnapshot<dynamic> snapshot) {
                          CacheHelper.saveData(
                              key: 'exprCompany', value: snapshot.data?['companyName']);
                          CacheHelper.saveData(
                              key: 'exprPosition', value: snapshot.data?['position']);

                          CacheHelper.saveData(
                              key: 'exprStartDate', value: snapshot.data?['startDate']);
                          CacheHelper.saveData(
                              key: 'exprEndDate', value: snapshot.data?['endDate']);

                          return Card(
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                            elevation: 5,
                            child: Padding(
                              padding: EdgeInsets.all(16),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Icon(Icons.circle, size: 15),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        '${snapshot.data?['position']}',
                                        style: TextStyle(fontWeight: FontWeight.bold),
                                      ),
                                      Text('  at  '),
                                      Text(
                                        '${snapshot.data?['companyName']}',
                                        style: TextStyle(fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                  Text(
                                    '        [ ${snapshot.data?['startDate']} - ${snapshot.data?['endDate']} ]',
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        'Skills',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20, color: Colors.blue),
                      ),
                      FutureBuilder(
                        future: JobApplicationsCubit.get(context).getApplicantSkills(application),
                        builder: (_, AsyncSnapshot<dynamic> snapshot) {
                          List skillsList =
                              CacheHelper.getData(key: 'skills') ?? []; // list of strings
                          skillsList.addAll(snapshot.data);
                          CacheHelper.saveData(key: 'skills', value: skillsList);

                          return Text(
                            '${snapshot.data?.toString()}',
                            style: const TextStyle(fontSize: 16),
                          );
                        },
                      ),
                      const SizedBox(height: 20),
                      if (showBtns)
                        defaultButton(
                            function: () => _showSendInterViewSheet(context, application),
                            text: 'Accept'),
                      const SizedBox(height: 20),
                      if (showBtns)
                        Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.blue, width: 1),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: TextButton(
                            onPressed: () {
                              _showSendFeedbackSheet(context, application);
                            },
                            child: Text('Reject'),
                          ),
                        ),
                      if (showBtns && job != null) const SizedBox(height: 20),
                      if (showBtns && job != null)
                        Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.blue, width: 1),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => JobDetailsScreen(
                                    job: job!,
                                  ),
                                ),
                              );
                            },
                            child: Text('Show Job Details'),
                          ),
                        )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _showSendInterViewSheet(context, application) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (_) {
        return Padding(
          padding: EdgeInsets.only(top: 20),
          child: Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.blue,
              title: Text(
                'Send Feedback',
                style: TextStyle(color: Colors.white),
              ),
            ),
            body: SizedBox(
              height: double.infinity,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      children: const [
                        Text(
                          'Interview Date & Time',
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    DatePicker(
                      datePickerController: ctrlInterviewDate,
                      onSelectDate: (val) {
                        selectedInterviewDate = DateFormat.yMMMd().format(val).toString();
                        ctrlInterviewDate.text = DateFormat.yMMMd().format(val).toString();
                      },
                      hintText: 'Interview date',
                      trailingIcon: const Icon(Icons.date_range, size: 20),
                      border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        borderSide: BorderSide(
                          color: Colors.grey,
                          width: 0.5,
                        ),
                      ),
                      textStyle: const TextStyle(color: Colors.grey),
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    defaultTimePicker(ctrlInterviewTime, context, (TimeOfDay val) {
                      selectedInterviewTime = '${val.hour}:${val.minute}';
                      ctrlInterviewTime.text = '${val.hour}:${val.minute}';
                    }, "select time"),
                    const SizedBox(
                      height: 50,
                    ),
                    defaultButton(
                      text: 'done',
                      function: () {
                        if (selectedInterviewDate.isNotEmpty && selectedInterviewTime.isNotEmpty) {
                          JobApplicationsCubit.get(context).sendInterviewToApplicant(
                              application, '$selectedInterviewDate  at $selectedInterviewTime');
                          Navigator.pop(context);
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  _showSendFeedbackSheet(context, application) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(top: 20),
          child: Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.blue,
              title: Text(
                'Send Feedback',
                style: TextStyle(color: Colors.white),
              ),
            ),
            body: SingleChildScrollView(
              child: Container(
                height: MediaQuery.of(context).size.height,
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          Text(
                            'Feedback',
                            style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 50,
                      ),
                      defaultFormField(
                        controller: ctrlFeedback,
                        maxLine: 12,
                        label: 'write your feedback',
                      ),
                      const SizedBox(height: 50),
                      defaultButton(
                        text: 'done',
                        function: () {
                          JobApplicationsCubit.get(context)
                              .sendFeedbackToApplicant(application, ctrlFeedback.text);
                          Navigator.pop(context);
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class MyDataItem extends StatelessWidget {
  IconData? icon;
  String? text;

  MyDataItem(this.icon, this.text, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          icon != null
              ? Icon(
                  icon!,
                  color: Colors.black54,
                  size: 17,
                )
              : SizedBox(),
          SizedBox(width: 14),
          Text('$text'),
        ],
      ),
    );
  }
}