import '../../data/models/products_model.dart';

sealed class ProductsState {}

class ProductsInitial extends ProductsState {}

class ProductsLoading extends ProductsState {}

class ProductsLoaded extends ProductsState {
  final List<Products> products;
  ProductsLoaded({required this.products});
}

class ProductsError extends ProductsState {
  final String errorMessage;
  ProductsError({required this.errorMessage});
}

class BottomNavigationToggledState extends ProductsState {}

class CartItemAdded extends ProductsState {}

class CartItemRemoved extends ProductsState {}
