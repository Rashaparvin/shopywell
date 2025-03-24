import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shopywell/domain/models/product/product_detail_model.dart';

class WishlistRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> addToWishlist(ProductDetailModel product) async {
    await _firestore
        .collection('wishlist')
        .doc(product.id.toString())
        .set(product.toMap());
  }

  Future<void> removeFromWishlist(int productId) async {
    await _firestore.collection('wishlist').doc(productId.toString()).delete();
  }

  Stream<List<ProductDetailModel>> getWishlist() {
    return _firestore.collection('wishlist').snapshots().map((snapshot) {
      return snapshot.docs
          .map((doc) => ProductDetailModel.fromMap(doc.data()))
          .toList();
    });
  }
}
