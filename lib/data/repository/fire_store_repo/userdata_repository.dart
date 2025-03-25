import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shopywell/domain/models/user_model/user_details_modl.dart';

class UserdataRepository {
  final CollectionReference usersCollection =
      FirebaseFirestore.instance.collection('users_profile');

  // Add user data
  Future<void> addUserProfile(UserDetailsModel user) async {
    await usersCollection.doc(user.email).set(user.toMap());
  }

  // Get user data
  Future<UserDetailsModel?> getUserProfile(String email) async {
    try {
      DocumentSnapshot doc = await usersCollection.doc(email).get();
      if (doc.exists) {
        return UserDetailsModel.fromMap(doc.data() as Map<String, dynamic>);
      }
    } catch (e) {
      print('Error fetching user: $e');
    }
    return null;
  }
}
