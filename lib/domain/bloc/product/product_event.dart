part of 'product_bloc.dart';

@immutable
sealed class ProductEvent {}

final class FetchProducts extends ProductEvent {}

final class ToggleFavorite extends ProductEvent {
  final int productId;

  ToggleFavorite({required this.productId});
}

final class AddProductToFirestore extends ProductEvent {
  final ProductDetailModel productDetailModel;

  AddProductToFirestore({required this.productDetailModel});
}

final class FetchProductFromFirestore extends ProductEvent {}
