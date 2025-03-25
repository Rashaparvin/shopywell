import 'package:cloud_firestore/cloud_firestore.dart';
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
    await _firestore
        .collection('wishlist')
        .doc(product.id.toString())
        .set(product.toMap());
  }

  // Remove product on wishlist
  Future<void> removeFromWishlist(int productId) async {
    await _firestore.collection('wishlist').doc(productId.toString()).delete();
  }

  // Fetch product from wishlist
  Stream<List<ProductDetailModel>> getWishlist() {
    return _firestore.collection('wishlist').snapshots().map((snapshot) {
      return snapshot.docs
          .map((doc) => ProductDetailModel.fromMap(doc.data()))
          .toList();
    });
  }

  // Add product to cartlist
  Future<void> addToCart(ProductDetailModel product) async {
    await _firestore
        .collection('cartlist')
        .doc(product.id.toString())
        .set(product.toMap());
  }

  // Fetch product from wishlist
  Future<List<ProductDetailModel>> getCartProductList() async {
    try {
      QuerySnapshot snapshot = await _firestore.collection('cartlist').get();

      return snapshot.docs
          .map((doc) =>
              ProductDetailModel.fromMap(doc.data() as Map<String, dynamic>))
          .toList();
    } catch (e) {
      print("Error fetching cart list: $e");
      return [];
    }
  }
}
