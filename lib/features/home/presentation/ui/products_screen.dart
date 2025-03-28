import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:payment/features/home/presentation/ui/widgets/products_grid_view.dart';

import '../cubits/products_cubit.dart';
import '../cubits/products_state.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({super.key});

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  @override
  void initState() {
    super.initState();
    context.read<ProductsCubit>().getProducts();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductsCubit, ProductsState>(
      builder: (context, state) {
        final cubit = context.watch<ProductsCubit>();

        if (state is ProductsLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is ProductsLoaded) {
          return ProductsGridView(
            products: cubit.productsCache,
          );
        } else if (state is ProductsError) {
          return Center(
            child: Center(
              child: Text(
                state.errorMessage,
              ),
            ),
          );
        }
        return const SizedBox();
      },
    );
  }
}
