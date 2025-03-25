part of 'user_profile_bloc.dart';

@immutable
sealed class UserProfileEvent {}

final class FetchUserDetails extends UserProfileEvent {}

final class AddUserProfile extends UserProfileEvent {
  final UserDetailsModel userData;

  AddUserProfile({required this.userData});
}

final class FetchUserProfileDetails extends UserProfileEvent {
  final String email;

  FetchUserProfileDetails({required this.email});
}
