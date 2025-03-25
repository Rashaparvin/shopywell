import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';
import 'package:shopywell/data/repository/fire_store_repo/userdata_repository.dart';
import 'package:shopywell/data/repository/login_repo/login_repository.dart';
import 'package:shopywell/domain/models/user_model/user_details_modl.dart';

part 'user_profile_event.dart';
part 'user_profile_state.dart';

class UserProfileBloc extends Bloc<UserProfileEvent, UserProfileState> {
  final LoginRepo loginRepo;
  final UserdataRepository userdataRepository;
  UserProfileBloc(this.loginRepo, this.userdataRepository)
      : super(UserProfileInitial()) {
    on<FetchUserDetails>(_fetchUserDetails);
    on<AddUserProfile>(_addUserProfile);
    on<FetchUserProfileDetails>(_fetchUserProfileDetails);
  }

  Future<void> _fetchUserDetails(
      FetchUserDetails event, Emitter<UserProfileState> emit) async {
    emit(UserDetailsLoading());
    final user = loginRepo.getCurrentUser();
    if (user!.email != '') {
      emit(UserDetailsFetched(user: user));
    }
  }

  Future<void> _addUserProfile(
      AddUserProfile event, Emitter<UserProfileState> emit) async {
    try {
      final userProfileData = event.userData;
      await userdataRepository.addUserProfile(userProfileData);
      emit(UserProfileAddedSuccess());
    } catch (e) {
      print(e);
      emit(UserProfileAddingFailure(errorMessage: e.toString()));
    }
  }

  Future<void> _fetchUserProfileDetails(
      FetchUserProfileDetails event, Emitter<UserProfileState> emit) async {
    try {
      final email = event.email;
      UserDetailsModel? user = await userdataRepository.getUserProfile(email);
      if (user != null) {}
    } catch (e) {
      print(e);
    }
  }
}
