part of 'wishlist_bloc.dart';

@immutable
sealed class WishlistState {}

final class WishlistInitial extends WishlistState {}

final class WishlistError extends WishlistState {
  final String errorMessage;

  WishlistError({required this.errorMessage});
}

final class WishlistLoaded extends WishlistState {
  final List<ProductDetailModel> wishlist;

  WishlistLoaded({required this.wishlist});
}

final class WishlistEmpty extends WishlistState {}
