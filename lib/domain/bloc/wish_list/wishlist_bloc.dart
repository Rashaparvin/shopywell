import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:shopywell/data/repository/fire_store_repo/fire_store_repository.dart';
import 'package:shopywell/domain/models/product/product_detail_model.dart';

part 'wishlist_event.dart';
part 'wishlist_state.dart';

class WishlistBloc extends Bloc<WishlistEvent, WishlistState> {
  final FireStoreRepository fireStoreRepository;
  WishlistBloc(this.fireStoreRepository) : super(WishlistInitial()) {
    on<FetchWishlistProducts>(_fetchWishListProducts);
    on<AddToWishlist>(_addToWishlist);
    on<RemoveFromWishlist>(_removeFromWishlist);
  }

  Future<void> _fetchWishListProducts(
      FetchWishlistProducts event, Emitter<WishlistState> emit) async {
    try {
      await emit.onEach(
        fireStoreRepository.getWishlist(),
        onData: (wishlist) {
          if (wishlist.isEmpty) {
            emit(WishlistEmpty());
          } else {
            emit(WishlistLoaded(wishlist: wishlist));
          }
        },
      );
    } catch (e) {
      emit(WishlistError(errorMessage: e.toString()));
    }
  }

  Future<void> _addToWishlist(
      AddToWishlist event, Emitter<WishlistState> emit) async {
    await fireStoreRepository.addToWishlist(event.product);
  }

  Future<void> _removeFromWishlist(
      RemoveFromWishlist event, Emitter<WishlistState> emit) async {
    await fireStoreRepository.removeFromWishlist(event.productId);
  }
}
