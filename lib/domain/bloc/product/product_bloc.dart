import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:shopywell/data/repository/fire_store_repo/fire_store_repository.dart';
import 'package:shopywell/data/repository/product_repo/product_repository.dart';
import 'package:shopywell/domain/models/product/product_detail_model.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ProductRepository productRepository;
  final FireStoreRepository fireStoreRepository;
  ProductBloc(
    this.productRepository,
    this.fireStoreRepository,
  ) : super(ProductInitial()) {
    on<FetchProducts>(_fetchProducts);
    on<AddProductToCart>(_addProductToCart);
    on<FetchCartProducts>(_fetchCartProducts);
  }

  Future<void> _fetchProducts(
      FetchProducts event, Emitter<ProductState> emit) async {
    try {
      emit(ProductLoading());
      final products = await productRepository.fetchProducts();
      emit(ProductLoaded(products: products));
    } catch (e) {
      emit(ProductError(errorMessage: e.toString()));
    }
  }

  Future<void> _addProductToCart(
      AddProductToCart event, Emitter<ProductState> emit) async {
    await fireStoreRepository.addToCart(event.product);
  }

  Future<void> _fetchCartProducts(
      FetchCartProducts event, Emitter<ProductState> emit) async {
    final cartProducts = await fireStoreRepository.getCartProductList();
    if (cartProducts.isNotEmpty) {
      emit(CartProductLoaded(cartProducts: cartProducts));
    } else {
      emit(CartListEmpty());
    }
  }
}
