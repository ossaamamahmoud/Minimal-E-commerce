import 'package:flutter/material.dart';
import 'package:payment/core/helpers/extensions.dart';

import '../../../data/models/products_model.dart';
import 'product_item.dart';

class ProductsGridView extends StatelessWidget {
  final List<Products> products;

  const ProductsGridView({super.key, required this.products});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: context.withFormFactor(
          onMobile: 2,
          onTablet: 4,
          onDesktop: 6,
        ),
        childAspectRatio: 0.75,
      ),
      itemCount: products.length,
      itemBuilder: (context, index) => ProductItem(model: products[index]),
    );
  }
}