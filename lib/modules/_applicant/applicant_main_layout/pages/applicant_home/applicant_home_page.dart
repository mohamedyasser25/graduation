import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../shared/caching/cache_helper.dart';
import '../../../../../shared/components/components.dart';
import '../../../../../shared/models/job_model.dart';
import '../../../../_common/filter/filterHome.dart';
import '../../../../_common/job_details/job_details_screen.dart';
import '../applicant_Saved_apps/cubit/cubit.dart';
import 'cubit/cubit.dart';
import 'cubit/states.dart';

class ApplicantHomePage extends StatefulWidget {
  const ApplicantHomePage({Key? key}) : super(key: key);

  @override
  State<ApplicantHomePage> createState() => _ApplicantHomePageState();
}

class _ApplicantHomePageState extends State<ApplicantHomePage> {
  var searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ApplicantRegisterCubit.get(context).listOfJobs == null
        ? Center(child: CircularProgressIndicator())
        : CustomScrollView(
            slivers: <Widget>[
              SliverAppBar(
                expandedHeight: 160.0,
                backgroundColor: const Color(0xff1B75BC),
                shape: const ContinuousRectangleBorder(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(50),
                    bottomRight: Radius.circular(50),
                  ),
                ),
                flexibleSpace: FlexibleSpaceBar(
                  centerTitle: true,
                  title: Padding(
                    padding: const EdgeInsets.only(left: 10, right: 5, top: 20, bottom: 10),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text('Hi, ${CacheHelper.getData(key: 'name')} !'),
                      ],
                    ),
                  ),
                ),
              ),
              const SliverPadding(padding: EdgeInsets.only(top: 10)),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: defaultFormField(
                    controller: searchController,
                    type: TextInputType.emailAddress,
                    label: 'Search',
                    prefix: Icons.search,
                    suffix: Icons.sort,
                    suffixPressed: () {
                      navigateTo(context, const FilterHome());
                    },
                    onChange: (value) {
                      ApplicantRegisterCubit.get(context).changeListSearch(value, context);
                    },
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 30),
                  child: Text(
                    'Recommended jobs',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: BlocConsumer<ApplicantRegisterCubit, ApplicantRegisterStates>(
                  builder: (context, state) {
                    var cubit = ApplicantRegisterCubit.get(context);
                    return Column(
                      children: cubit.listOfJobs.map((job) => buildJob(context, job)).toList(),
                    );
                  },
                  listener: (context, state) => {},
                ),
              ),
            ],
          );
  }

  Widget buildJob(context, JobModel job) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context as BuildContext,
          MaterialPageRoute(builder: (context) => JobDetailsScreen(job: job)),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.only(bottom: 15),
        decoration:
            BoxDecoration(borderRadius: BorderRadius.circular(20), color: Colors.white, boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 0,
            blurRadius: 2,
            offset: const Offset(0, 1),
          ),
        ]),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Row(children: [
                    SizedBox(
                        width: 60,
                        height: 60,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Image.asset(job.jobIcon!),
                        )),
                    const SizedBox(width: 10),
                    Flexible(
                      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                        Text(job.jobTitle!,
                            style: const TextStyle(
                                color: Colors.black, fontSize: 15, fontWeight: FontWeight.w500)),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(job.position!, style: TextStyle(color: Colors.grey[500])),
                      ]),
                    )
                  ]),
                ),
                GestureDetector(
                  onTap: () {
                    // setState(() {
                    //   job.isMyFav = !job.isMyFav;
                    // });
                  },
                  child: AnimatedContainer(
                    height: 35,
                    padding: const EdgeInsets.all(5),
                    duration: const Duration(milliseconds: 300),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: ApplicantFavsCubit.get(context).isFavedJob(job.id!)
                              ? Colors.red.shade100
                              : Colors.grey.shade300,
                        )),
                    child: Center(
                      child: ApplicantFavsCubit.get(context).isFavedJob(job.id!)
                          ? GestureDetector(
                              child: const Icon(Icons.favorite, color: Colors.red),
                              onTap: () {
                                ApplicantFavsCubit.get(context).removeFromFavs(job.id!);
                                setState(() {});
                              },
                            )
                          : GestureDetector(
                              child: const Icon(Icons.favorite_outline, color: Colors.red),
                              onTap: () {
                                ApplicantFavsCubit.get(context).addToFavs(job.id!);
                                setState(() {});
                              },
                            ),
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 15),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12), color: Colors.grey.shade200),
                        child: Text(
                          job.jobType!,
                          style: const TextStyle(color: Colors.black),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 15),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: Color(int.parse("0xffff0000")).withAlpha(20)),
                        child: Text(
                          "${job.experienceYears} experience",
                          style: TextStyle(color: Color(int.parse("0xffff0000"))),
                        ),
                      )
                    ],
                  ),
                  Text(
                    "${DateTime.now().difference(job.startDate!).inDays} Days ago",
                    style: TextStyle(color: Colors.grey.shade800, fontSize: 12),
                  )
                ],
              ),
            ),
            //   SizedBox(
            //     height: 20,
            //   ),
            //   Container(
            //     child: defaultButton(
            //         function: () {
            //           Navigator.push(
            //             context as BuildContext,
            //             MaterialPageRoute(
            //                 builder: (context) => HrApplication(job: job)),
            //           );
            //         },
            //         text: "View job details"),
            //   )
          ],
        ),
      ),
    );
  }
}

var icons = [
  'assets/IconsImage/certicraft.png',
  'assets/IconsImage/beanworks.jpeg',
  'assets/IconsImage/mailchimp.jpeg',
  'assets/IconsImage/mozila.png',
  'assets/IconsImage/reddit.jpeg',
];