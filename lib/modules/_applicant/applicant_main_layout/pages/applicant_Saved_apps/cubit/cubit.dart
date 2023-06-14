import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gp2023/modules/_applicant/applicant_main_layout/pages/applicant_Saved_apps/cubit/states.dart';

import '../../../../../../shared/caching/cache_helper.dart';
import '../../../../../../shared/models/job_model.dart';
import '../../applicant_home/cubit/cubit.dart';

class ApplicantFavsCubit extends Cubit<ApplicantFavsStates> {
  ApplicantFavsCubit() : super(InitialFavsState());

  List<JobModel> listOfFavsJobs = [];

  static ApplicantFavsCubit get(context) => BlocProvider.of(context);

  loadFavsJobs(context) async {
    emit(LoadingFavsState());

    List<String> favsIds = getAllFavs();
    List<JobModel> allJobs = ApplicantRegisterCubit.get(context).listOfJobs;
    List<JobModel> myFavedJobs = [];

    for (int i = 0; i < allJobs.length; i++) {
      if (favsIds.contains(allJobs[i].id)) {
        myFavedJobs.add(allJobs[i]);
      }
    }

    listOfFavsJobs = myFavedJobs;

    emit(LoadingFavsSuccessState(listOfFavsJobs));
  }

  addEmailToEmailFavsList(String email) {
    List<String> favsEmails = CacheHelper.sharedPreferences?.getStringList('favsEmails') ?? [];
    if (!favsEmails.contains(email)) {
      favsEmails.add(email);
      CacheHelper.sharedPreferences?.setStringList('favsEmails', favsEmails);
    }
  }

  bool isFavedJob(String jobId) {
    List<String>? favsEmails = CacheHelper.sharedPreferences?.getStringList('favsEmails');
    bool isFaved = false;

    favsEmails?.forEach((element) {
      if (element == CacheHelper.getData(key: 'email')) {
        CacheHelper.sharedPreferences?.getStringList(element + 'favs')?.forEach((element) {
          if (jobId == element) {
            isFaved = true;
          }
        });
      }
    });

    return isFaved;
  }

  addToFavs(String jobId) {
    List<String>? favsEmails = CacheHelper.sharedPreferences?.getStringList('favsEmails');

    favsEmails?.forEach((element) {
      if (element == CacheHelper.getData(key: 'email')) {
        List<String> list = CacheHelper.sharedPreferences?.getStringList(element + 'favs') ?? [];
        list.add(jobId);
        CacheHelper.sharedPreferences?.setStringList(element + 'favs', list);
      }
    });
  }

  removeFromFavs(String jobId) {
    List<String>? favsEmails = CacheHelper.sharedPreferences?.getStringList('favsEmails');

    favsEmails?.forEach((element) {
      if (element == CacheHelper.getData(key: 'email')) {
        List<String>? list = CacheHelper.sharedPreferences?.getStringList(element + 'favs');
        list?.remove(jobId);
        CacheHelper.sharedPreferences?.setStringList(element + 'favs', list!);
      }
    });
  }

  List<String> getAllFavs() {
    List<String>? favsEmails = CacheHelper.sharedPreferences?.getStringList('favsEmails');

    List<String>? list = [];
    favsEmails?.forEach((element) {
      if (element == CacheHelper.getData(key: 'email')) {
        list = CacheHelper.sharedPreferences?.getStringList(element + 'favs');
      }
    });

    return list!;
  }

  void initFavs() {
    List<String>? favsEmails = CacheHelper.sharedPreferences?.getStringList('favsEmails');
    if (favsEmails == null) {
      CacheHelper.sharedPreferences?.setStringList('favsEmails', []);
    }
  }
}