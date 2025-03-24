import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:shopywell/data/repository/product_repo/product_repository.dart';
import 'package:shopywell/domain/models/product/product_detail_model.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ProductRepository productRepository;
  ProductBloc(this.productRepository) : super(ProductInitial()) {
    on<FetchProducts>(_fetchProducts);
    on<AddProductToFirestore>(_addProductToFirestore);
    // on<FetchProductFromFirestore>(_fetchProductFromFirestore);
    on<ToggleFavorite>(_toggleFavorite);
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

  Future<void> _addProductToFirestore(
      AddProductToFirestore event, Emitter<ProductState> emit) async {}

  Future<void> _toggleFavorite(
      ToggleFavorite event, Emitter<ProductState> emit) async {
    final List<ProductDetailModel> updatedProducts =
        (state as ProductLoaded).products.map((product) {
      if (product.id == event.productId) {
        return product.copyWith(selectedToWish: !product.selectedToWish);
      }
      return product;
    }).toList();
    emit(ProductLoaded(products: updatedProducts));
  }
}
