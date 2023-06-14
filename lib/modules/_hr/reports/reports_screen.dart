import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gp2023/shared/caching/cache_helper.dart';
import 'package:gp2023/shared/models/JobApplicationModel.dart';
import 'package:gp2023/shared/models/job_model.dart';

class ReportsScreen extends StatelessWidget {
  const ReportsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Reports'), iconTheme: IconThemeData(color: Colors.black)),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20),
              Text(
                'Your cmopany\'s Reports',
                style: TextStyle(
                  fontSize: 25,
                  color: Colors.blue,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Jobs Report',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 12),
              FutureBuilder(
                future: _getCompanyJobsReport(),
                builder: (_, AsyncSnapshot<dynamic> snapshot) {
                  return snapshot.hasData == false
                      ? Center(child: CircularProgressIndicator())
                      : Table(
                          border: TableBorder.all(
                            color: Colors.black54,
                            width: 0.5,
                          ),
                          columnWidths: const {
                            0: FlexColumnWidth(2),
                            1: FlexColumnWidth(3),
                          },
                          children: [
                            TableRow(
                                decoration: BoxDecoration(
                                  color: Colors.blue.withOpacity(0.3),
                                ),
                                children: [
                                  TableCell(
                                      child: Padding(
                                    padding: EdgeInsets.symmetric(vertical: 8),
                                    child: Text('  Field'),
                                  )),
                                  TableCell(
                                      child: Padding(
                                          padding: EdgeInsets.symmetric(vertical: 8),
                                          child: Text('  Number Of Jobs'))),
                                ]),
                            TableRow(children: [
                              TableCell(
                                  child: Padding(
                                      padding: EdgeInsets.symmetric(vertical: 8),
                                      child: Text('  IT'))),
                              TableCell(
                                  child: Padding(
                                      padding: EdgeInsets.symmetric(vertical: 8),
                                      child: Text('  ${snapshot.data['it']}'))),
                            ]),
                            TableRow(children: [
                              TableCell(
                                  child: Padding(
                                      padding: EdgeInsets.symmetric(vertical: 8),
                                      child: Text('  Finance'))),
                              TableCell(
                                  child: Padding(
                                      padding: EdgeInsets.symmetric(vertical: 8),
                                      child: Text('  ${snapshot.data['finance']}'))),
                            ]),
                            TableRow(children: [
                              TableCell(
                                  child: Padding(
                                      padding: EdgeInsets.symmetric(vertical: 8),
                                      child: Text('  Medicine'))),
                              TableCell(
                                  child: Padding(
                                      padding: EdgeInsets.symmetric(vertical: 8),
                                      child: Text('  ${snapshot.data['medicine']}'))),
                            ]),
                            TableRow(children: [
                              TableCell(
                                  child: Padding(
                                      padding: EdgeInsets.symmetric(vertical: 8),
                                      child: Text('  Other'))),
                              TableCell(
                                  child: Padding(
                                      padding: EdgeInsets.symmetric(vertical: 8),
                                      child: Text('  ${snapshot.data['other']}'))),
                            ]),
                          ],
                        );
                },
              ),
              SizedBox(height: 50),
              Text(
                'Applications Report',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 12),
              FutureBuilder(
                future: _getCompanyApplicationsReport(),
                builder: (_, AsyncSnapshot<dynamic> snapshot) {
                  return snapshot.hasData == false
                      ? Center(child: CircularProgressIndicator())
                      : Table(
                          border: TableBorder.all(
                            color: Colors.black54,
                            width: 0.5,
                          ),
                          columnWidths: const {
                            0: FlexColumnWidth(2),
                            1: FlexColumnWidth(3),
                          },
                          children: [
                            TableRow(
                                decoration: BoxDecoration(
                                  color: Colors.blue.withOpacity(0.3),
                                ),
                                children: [
                                  TableCell(
                                      child: Padding(
                                          padding: EdgeInsets.symmetric(vertical: 8),
                                          child: Text('  Field'))),
                                  TableCell(
                                      child: Padding(
                                          padding: EdgeInsets.symmetric(vertical: 8),
                                          child: Text('  Number Of Applications'))),
                                ]),
                            TableRow(children: [
                              TableCell(
                                  child: Padding(
                                      padding: EdgeInsets.symmetric(vertical: 8),
                                      child: Text('  IT'))),
                              TableCell(
                                  child: Padding(
                                      padding: EdgeInsets.symmetric(vertical: 8),
                                      child: Text('  ${snapshot.data['it']}'))),
                            ]),
                            TableRow(children: [
                              TableCell(
                                  child: Padding(
                                      padding: EdgeInsets.symmetric(vertical: 8),
                                      child: Text('  Finance'))),
                              TableCell(
                                  child: Padding(
                                      padding: EdgeInsets.symmetric(vertical: 8),
                                      child: Text('  ${snapshot.data['finance']}'))),
                            ]),
                            TableRow(children: [
                              TableCell(
                                  child: Padding(
                                      padding: EdgeInsets.symmetric(vertical: 8),
                                      child: Text('  Medicine'))),
                              TableCell(
                                  child: Padding(
                                      padding: EdgeInsets.symmetric(vertical: 8),
                                      child: Text('  ${snapshot.data['medicine']}'))),
                            ]),
                            TableRow(children: [
                              TableCell(
                                  child: Padding(
                                      padding: EdgeInsets.symmetric(vertical: 8),
                                      child: Text('  Other'))),
                              TableCell(
                                  child: Padding(
                                      padding: EdgeInsets.symmetric(vertical: 8),
                                      child: Text('  ${snapshot.data['other']}'))),
                            ]),
                          ],
                        );
                },
              ),
              SizedBox(height: 30),
              Container(
                width: double.infinity,
                height: 8,
                color: Colors.grey.withOpacity(0.2),
              ),
              SizedBox(height: 50),
              Text(
                'General Reports',
                style: TextStyle(
                  fontSize: 25,
                  color: Colors.blue,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Jobs Report',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 12),
              FutureBuilder(
                future: _getGeneralJobsReport(),
                builder: (_, AsyncSnapshot<dynamic> snapshot) {
                  return snapshot.hasData == false
                      ? Center(child: CircularProgressIndicator())
                      : Table(
                          border: TableBorder.all(
                            color: Colors.black54,
                            width: 0.5,
                          ),
                          columnWidths: const {
                            0: FlexColumnWidth(2),
                            1: FlexColumnWidth(3),
                          },
                          children: [
                            TableRow(
                                decoration: BoxDecoration(
                                  color: Colors.blue.withOpacity(0.3),
                                ),
                                children: [
                                  TableCell(
                                      child: Padding(
                                    padding: EdgeInsets.symmetric(vertical: 8),
                                    child: Text('  Field'),
                                  )),
                                  TableCell(
                                      child: Padding(
                                          padding: EdgeInsets.symmetric(vertical: 8),
                                          child: Text('  Number Of Jobs'))),
                                ]),
                            TableRow(children: [
                              TableCell(
                                  child: Padding(
                                      padding: EdgeInsets.symmetric(vertical: 8),
                                      child: Text('  IT'))),
                              TableCell(
                                  child: Padding(
                                      padding: EdgeInsets.symmetric(vertical: 8),
                                      child: Text('  ${snapshot.data['it']}'))),
                            ]),
                            TableRow(children: [
                              TableCell(
                                  child: Padding(
                                      padding: EdgeInsets.symmetric(vertical: 8),
                                      child: Text('  Finance'))),
                              TableCell(
                                  child: Padding(
                                      padding: EdgeInsets.symmetric(vertical: 8),
                                      child: Text('  ${snapshot.data['finance']}'))),
                            ]),
                            TableRow(children: [
                              TableCell(
                                  child: Padding(
                                      padding: EdgeInsets.symmetric(vertical: 8),
                                      child: Text('  Medicine'))),
                              TableCell(
                                  child: Padding(
                                      padding: EdgeInsets.symmetric(vertical: 8),
                                      child: Text('  ${snapshot.data['medicine']}'))),
                            ]),
                            TableRow(children: [
                              TableCell(
                                  child: Padding(
                                      padding: EdgeInsets.symmetric(vertical: 8),
                                      child: Text('  Other'))),
                              TableCell(
                                  child: Padding(
                                      padding: EdgeInsets.symmetric(vertical: 8),
                                      child: Text('  ${snapshot.data['other']}'))),
                            ]),
                          ],
                        );
                },
              ),
              SizedBox(height: 50),
              Text(
                'Applications Report',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 12),
              FutureBuilder(
                future: _getGeneralApplicationsReport(),
                builder: (_, AsyncSnapshot<dynamic> snapshot) {
                  return snapshot.hasData == false
                      ? Center(child: CircularProgressIndicator())
                      : Table(
                          border: TableBorder.all(
                            color: Colors.black54,
                            width: 0.5,
                          ),
                          columnWidths: const {
                            0: FlexColumnWidth(2),
                            1: FlexColumnWidth(3),
                          },
                          children: [
                            TableRow(
                                decoration: BoxDecoration(
                                  color: Colors.blue.withOpacity(0.3),
                                ),
                                children: [
                                  TableCell(
                                      child: Padding(
                                          padding: EdgeInsets.symmetric(vertical: 8),
                                          child: Text('  Field'))),
                                  TableCell(
                                      child: Padding(
                                          padding: EdgeInsets.symmetric(vertical: 8),
                                          child: Text('  Number Of Applications'))),
                                ]),
                            TableRow(children: [
                              TableCell(
                                  child: Padding(
                                      padding: EdgeInsets.symmetric(vertical: 8),
                                      child: Text('  IT'))),
                              TableCell(
                                  child: Padding(
                                      padding: EdgeInsets.symmetric(vertical: 8),
                                      child: Text('  ${snapshot.data['it']}'))),
                            ]),
                            TableRow(children: [
                              TableCell(
                                  child: Padding(
                                      padding: EdgeInsets.symmetric(vertical: 8),
                                      child: Text('  Finance'))),
                              TableCell(
                                  child: Padding(
                                      padding: EdgeInsets.symmetric(vertical: 8),
                                      child: Text('  ${snapshot.data['finance']}'))),
                            ]),
                            TableRow(children: [
                              TableCell(
                                  child: Padding(
                                      padding: EdgeInsets.symmetric(vertical: 8),
                                      child: Text('  Medicine'))),
                              TableCell(
                                  child: Padding(
                                      padding: EdgeInsets.symmetric(vertical: 8),
                                      child: Text('  ${snapshot.data['medicine']}'))),
                            ]),
                            TableRow(children: [
                              TableCell(
                                  child: Padding(
                                      padding: EdgeInsets.symmetric(vertical: 8),
                                      child: Text('  Other'))),
                              TableCell(
                                  child: Padding(
                                      padding: EdgeInsets.symmetric(vertical: 8),
                                      child: Text('  ${snapshot.data['other']}'))),
                            ]),
                          ],
                        );
                },
              ),
              SizedBox(height: 30),
              Container(
                width: double.infinity,
                height: 8,
                color: Colors.grey.withOpacity(0.2),
              ),
              SizedBox(height: 30),
              Card(
                elevation: 5,
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: ListTile(
                    title: Text(
                      'HR Signature...',
                      style: TextStyle(
                        fontSize: 12,
                      ),
                    ),
                    subtitle: Text(
                      '_\t\t\t${CacheHelper.getData(key: 'name')}\t\t\t_',
                      style: TextStyle(
                        decoration: TextDecoration.underline,
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future _getCompanyJobsReport() async {
    List<JobModel> jobs = [];
    int itNum = 0;
    int fiNum = 0;
    int medicineNum = 0;
    int otherNum = 0;

    final response = await FirebaseFirestore.instance
        .collection('jobs')
        .where(
          'companyID',
          isEqualTo: CacheHelper.getData(key: 'companyId'),
        )
        .get();

    for (var job in response.docs) {
      JobModel j = JobModel.fromJson(job.data());
      jobs.add(j);

      if (_getJobCat(j).toLowerCase() == 'it') {
        itNum++;
      } else if (_getJobCat(j).toLowerCase() == 'finance') {
        fiNum++;
      } else if (_getJobCat(j).toLowerCase() == 'medicine') {
        medicineNum++;
      } else if (_getJobCat(j).toLowerCase() == 'other') {
        otherNum++;
      }
    }

    return {
      'it': itNum,
      'finance': fiNum,
      'medicine': medicineNum,
      'other': otherNum,
    };
  }

  Future _getCompanyApplicationsReport() async {
    List<JobApplicationModel> apps = [];
    int itNum = 0;
    int fiNum = 0;
    int medicineNum = 0;
    int otherNum = 0;

    try {
      print('zzzzzzz 1');
      final response = await FirebaseFirestore.instance.collection('jobApplication').get();
      print('zzzzzzz 2');
      for (var app in response.docs) {
        JobApplicationModel ja = JobApplicationModel.fromJson(app.data());
        apps.add(ja);
        print('zzzzzzz 3');
        final response2 = await FirebaseFirestore.instance.collection('jobs').doc(ja.jobID).get();
        print('zzzzzzz 4');
        JobModel j = JobModel.fromJson(response2.data()!);
        if (j.companyId == CacheHelper.getData(key: 'companyId')) {
          if (_getJobCat(j).toLowerCase() == 'it') {
            itNum++;
          } else if (_getJobCat(j).toLowerCase() == 'finance') {
            fiNum++;
          } else if (_getJobCat(j).toLowerCase() == 'medicine') {
            medicineNum++;
          } else if (_getJobCat(j).toLowerCase() == 'other') {
            otherNum++;
          }
        }

        print('zzzzzzz 5');
      }

      print('zzzzzzz 6');

      return {
        'it': itNum,
        'finance': fiNum,
        'medicine': medicineNum,
        'other': otherNum,
      };
    } catch (e) {
      return {
        'it': itNum,
        'finance': fiNum,
        'medicine': medicineNum,
        'other': otherNum,
      };
    }
  }

  Future _getGeneralJobsReport() async {
    List<JobModel> jobs = [];
    int itNum = 0;
    int fiNum = 0;
    int medicineNum = 0;
    int otherNum = 0;

    final response = await FirebaseFirestore.instance.collection('jobs').get();

    for (var job in response.docs) {
      JobModel j = JobModel.fromJson(job.data());
      jobs.add(j);

      if (_getJobCat(j).toLowerCase() == 'it') {
        itNum++;
      } else if (_getJobCat(j).toLowerCase() == 'finance') {
        fiNum++;
      } else if (_getJobCat(j).toLowerCase() == 'medicine') {
        medicineNum++;
      } else if (_getJobCat(j).toLowerCase() == 'other') {
        otherNum++;
      }
    }

    return {
      'it': itNum,
      'finance': fiNum,
      'medicine': medicineNum,
      'other': otherNum,
    };
  }

  Future _getGeneralApplicationsReport() async {
    List<JobApplicationModel> apps = [];
    int itNum = 0;
    int fiNum = 0;
    int medicineNum = 0;
    int otherNum = 0;

    try {
      print('zzzzzzz 1');
      final response = await FirebaseFirestore.instance.collection('jobApplication').get();
      print('zzzzzzz 2');
      for (var app in response.docs) {
        JobApplicationModel ja = JobApplicationModel.fromJson(app.data());
        apps.add(ja);
        print('zzzzzzz 3');
        final response2 = await FirebaseFirestore.instance.collection('jobs').doc(ja.jobID).get();
        print('zzzzzzz 4');
        JobModel j = JobModel.fromJson(response2.data()!);
        if (_getJobCat(j).toLowerCase() == 'it') {
          itNum++;
        } else if (_getJobCat(j).toLowerCase() == 'finance') {
          fiNum++;
        } else if (_getJobCat(j).toLowerCase() == 'medicine') {
          medicineNum++;
        } else if (_getJobCat(j).toLowerCase() == 'other') {
          otherNum++;
        }

        print('zzzzzzz 5');
      }

      print('zzzzzzz 6');

      return {
        'it': itNum,
        'finance': fiNum,
        'medicine': medicineNum,
        'other': otherNum,
      };
    } catch (e) {
      return {
        'it': itNum,
        'finance': fiNum,
        'medicine': medicineNum,
        'other': otherNum,
      };
    }
  }

  String _getJobCat(JobModel job) {
    if (job.jobTitle != null) {
      if (job.jobTitle! == 'front end web Developer' ||
          job.jobTitle! == 'Web Developer' ||
          job.jobTitle! == 'Integration' ||
          job.jobTitle! == 'IT Application Integration Technology Technical Manager' ||
          job.jobTitle! == 'full stack intern' ||
          job.jobTitle! == 'Embedded Software Engineer' ||
          job.jobTitle! == 'SaaS AI invoicing & estimate platform - Contractors' ||
          job.jobTitle! == 'Azure Synape Microsoft Arthitect/Engineer' ||
          job.jobTitle! == 'Core-java-tutor' ||
          job.jobTitle! == 'UI/UX designer') {
        return 'it';
      } else if (job.jobTitle! == 'Business Systems Analyst' ||
          job.jobTitle! == 'Permanent Part-Time Sales Assistant' ||
          job.jobTitle! == 'Sales Assistant' ||
          job.jobTitle! == 'Finance Assistance' ||
          job.jobTitle! == 'Sales Consultant at Liberty' ||
          job.jobTitle! == 'accountant' ||
          job.jobTitle! == 'Internal Sales' ||
          job.jobTitle! == 'Client Services Store Co-ordinator' ||
          job.jobTitle! == 'Group Marketing Manager') {
        return 'finance';
      } else if (job.jobTitle! == 'medical senior officer' ||
          job.jobTitle! == 'Quayside Superintendent' ||
          job.jobTitle! == 'patient safety specialist' ||
          job.jobTitle! == 'medical representative') {
        return 'medicine';
      } else if (job.jobTitle! == 'Recruitment Specialist' ||
          job.jobTitle! == 'Driver' ||
          job.jobTitle! == 'receptionist' ||
          job.jobTitle! == 'Customer Service Consultant' ||
          job.jobTitle! == 'Vessel Manager x 2' ||
          job.jobTitle! == 'college management system' ||
          job.jobTitle! == 'social media moderator' ||
          job.jobTitle! == 'Head of Pre School in London UK') {
        return 'other';
      } else {
        return 'other';
      }
    } else {
      return 'other';
    }
  }
}