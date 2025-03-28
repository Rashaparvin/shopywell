part of 'product_bloc.dart';

@immutable
sealed class ProductState {}

final class ProductInitial extends ProductState {}

final class ProductLoading extends ProductState {}

final class ProductLoaded extends ProductState {
  final List<ProductDetailModel> products;

  ProductLoaded({required this.products});
}

final class ProductError extends ProductState {
  final String errorMessage;

  ProductError({required this.errorMessage});
}

final class CartProductLoaded extends ProductState {
  final List<ProductDetailModel> cartProducts;

  CartProductLoaded({required this.cartProducts});
}

final class CartListEmpty extends ProductState {}
