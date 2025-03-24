import 'package:firebase_auth/firebase_auth.dart';
import 'package:hive/hive.dart';

part 'user_model.g.dart';

@HiveType(typeId: 0, adapterName: 'UserModelAdapter')
class UserModel extends HiveObject {
  @HiveField(0)
  String uid;

  @HiveField(1)
  String? email;

  @HiveField(2)
  String? displayName;

  @HiveField(3)
  String? photoURL;

  UserModel({
    required this.uid,
    this.email,
    this.displayName,
    this.photoURL,
  });

  factory UserModel.fromFirebaseUser(User user) {
    return UserModel(
      uid: user.uid,
      email: user.email,
      displayName: user.displayName,
      photoURL: user.photoURL,
    );
  }
}
