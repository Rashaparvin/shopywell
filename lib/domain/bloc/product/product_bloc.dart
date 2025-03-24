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
}
