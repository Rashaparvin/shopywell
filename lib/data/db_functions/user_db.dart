import 'package:firebase_auth/firebase_auth.dart';
import 'package:hive/hive.dart';
import 'package:shopywell/domain/models/user_model/user_model.dart';

class UserDb {
  Future<void> insertUserToDb({required User user}) async {
    final box = Hive.box('userDb');
    await box.clear();
    UserModel userModel = UserModel.fromFirebaseUser(user);
    box.put('userData', userModel);
    await getUser();
  }

  Future<UserModel?> getUser() async {
    final box = Hive.box('userDb');
    UserModel user = box.get('userData');
    if (user.uid != '') {
      return user;
    } else {
      return null;
    }
  }
}
