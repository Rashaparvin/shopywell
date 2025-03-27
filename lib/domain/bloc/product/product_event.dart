part of 'product_bloc.dart';

@immutable
sealed class ProductEvent {}

final class FetchProducts extends ProductEvent {}

final class AddProductToCart extends ProductEvent {
  final ProductDetailModel product;

  AddProductToCart({required this.product});
}

final class FetchCartProducts extends ProductEvent {}

final class RemoveFromCart extends ProductEvent {
  final int productId;

  RemoveFromCart({required this.productId});
}
