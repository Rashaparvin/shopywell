import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shopywell/domain/models/product/product_detail_model.dart';
import 'package:shopywell/domain/models/user_model/user_details_modl.dart';

class FireStoreRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Add user data
  Future<void> addUserProfile(UserDetailsModel user) async {
    await _firestore
        .collection('users_profile')
        .doc(user.email)
        .set(user.toMap());
  }

  // Get user data
  Future<UserDetailsModel?> getUserProfile(String email) async {
    try {
      DocumentSnapshot doc =
          await _firestore.collection('users_profile').doc(email).get();
      if (doc.exists) {
        return UserDetailsModel.fromMap(doc.data() as Map<String, dynamic>);
      }
    } catch (e) {
      print('Error fetching user: $e');
    }
    return null;
  }

  // Add product to wishlist
  Future<void> addToWishlist(ProductDetailModel product) async {
    String? userId = FirebaseAuth.instance.currentUser?.uid;

    await _firestore
        .collection('users')
        .doc(userId)
        .collection('wishlist')
        .doc(product.id.toString())
        .set(product.toMap());
  }

  // Remove product on wishlist
  Future<void> removeFromWishlist(int productId) async {
    String? userId = FirebaseAuth.instance.currentUser?.uid;

    await _firestore
        .collection('users')
        .doc(userId)
        .collection('wishlist')
        .doc(productId.toString())
        .delete();
  }

  // Fetch product from wishlist
  Stream<List<ProductDetailModel>> getWishlist() {
    String? userId = FirebaseAuth.instance.currentUser?.uid;

    return _firestore
        .collection('users')
        .doc(userId)
        .collection('wishlist')
        .snapshots()
        .map((snapshot) {
      return snapshot.docs
          .map((doc) => ProductDetailModel.fromMap(doc.data()))
          .toList();
    });
  }

  // Add product to cartlist
  Future<void> addToCart(ProductDetailModel product) async {
    String? userId = FirebaseAuth.instance.currentUser?.uid;

    await _firestore
        .collection('users')
        .doc(userId)
        .collection('cart')
        .doc(product.id.toString())
        .set(product.toMap());
  }

  // Fetch product from wishlist
  Future<List<ProductDetailModel>> getCartProductList() async {
    String? userId = FirebaseAuth.instance.currentUser?.uid;

    try {
      QuerySnapshot snapshot = await _firestore
          .collection('users')
          .doc(userId)
          .collection('cart')
          .get();

      return snapshot.docs
          .map((doc) =>
              ProductDetailModel.fromMap(doc.data() as Map<String, dynamic>))
          .toList();
    } catch (e) {
      print("Error fetching cart list: $e");
      return [];
    }
  }

  // Remove product on wishlist
  Future<void> removeFromCart(int productId) async {
    String? userId = FirebaseAuth.instance.currentUser?.uid;

    await _firestore
        .collection('users')
        .doc(userId)
        .collection('cart')
        .doc(productId.toString())
        .delete();
  }
}
