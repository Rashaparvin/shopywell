part of 'wishlist_bloc.dart';

@immutable
sealed class WishlistEvent {}

final class AddToWishlist extends WishlistEvent {
  final ProductDetailModel product;

  AddToWishlist({required this.product});
}

final class RemoveFromWishlist extends WishlistEvent {
  final int productId;

  RemoveFromWishlist({required this.productId});
}

final class FetchWishlistProducts extends WishlistEvent {}
