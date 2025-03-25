part of 'user_profile_bloc.dart';

@immutable
sealed class UserProfileState {}

final class UserProfileInitial extends UserProfileState {}

final class UserDetailsFetched extends UserProfileState {
  final User user;

  UserDetailsFetched({required this.user});
}

final class UserDetailsLoading extends UserProfileState {}

final class UserProfileAddedSuccess extends UserProfileState {}

final class UserProfileAddingFailure extends UserProfileState {
  final String errorMessage;

  UserProfileAddingFailure({required this.errorMessage});
}

final class UserProfileLoadedSuccess extends UserProfileState {
  final UserDetailsModel userProfile;

  UserProfileLoadedSuccess({required this.userProfile});
}

final class NoUserProfileFound extends UserProfileState {}
