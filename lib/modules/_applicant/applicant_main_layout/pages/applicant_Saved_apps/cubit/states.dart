import '../../../../../../shared/models/job_model.dart';

abstract class ApplicantFavsStates {}

class InitialFavsState extends ApplicantFavsStates {}

class LoadingFavsState extends ApplicantFavsStates {}

class LoadingFavsSuccessState extends ApplicantFavsStates {
  List<JobModel> myFavedJobs;

  LoadingFavsSuccessState(this.myFavedJobs);
}

class LoadingFavsErrorState extends ApplicantFavsStates {}