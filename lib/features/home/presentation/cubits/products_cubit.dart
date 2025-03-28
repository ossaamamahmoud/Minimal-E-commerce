import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:payment/features/home/data/models/products_model.dart';
import 'package:payment/features/home/data/repos/home_repo.dart';
import 'package:payment/features/home/presentation/cubits/products_state.dart';

class ProductsCubit extends Cubit<ProductsState> {
  final HomeRepo homeRepo;

  int currentIndex = 0;

  List<Products> productsCache = [];

  List<Products> cart = [];

  ProductsCubit({required this.homeRepo}) : super(ProductsInitial());

  Future<void> getProducts() async {
    if (productsCache.isNotEmpty) {
      emit(ProductsLoaded(products: productsCache));
      return;
    }

    emit(ProductsLoading());
    final result = await homeRepo.getProducts();
    result.fold(
      ifLeft: (error) => emit(ProductsError(errorMessage: error.errorMessage)),
      ifRight: (products) {
        productsCache = products;
        emit(ProductsLoaded(products: products));
      },
    );
  }

  void addToCart(Products product) {
    if (!cart.contains(product)) {
      cart.add(product);
      emit(CartItemAdded());
      emit(ProductsLoaded(products: productsCache)); // Re-emit product state
    } else {
      removeFromCart(product);
    }
  }

  void removeFromCart(Products product) {
    if (cart.contains(product)) {
      cart.remove(product);
      emit(CartItemRemoved());
      emit(ProductsLoaded(products: productsCache)); // Re-emit product state
    }
  }

  void toggleBottomNavigationBar(int index) {
    currentIndex = index;
    if (index == 0) {
      getProducts(); // Ensure products are loaded when returning
    } else {
      emit(BottomNavigationToggledState());
    }
  }

  bool isInCart(Products product) => cart.contains(product);

  double get total {
    return cart.fold(
      0,
      (sum, item) => sum + (item.price ?? 0),
    );
  }
}
