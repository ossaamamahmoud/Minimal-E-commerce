import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:payment/core/theming/app_styles.dart';
import 'package:payment/features/home/data/models/products_model.dart';

import '../../cubits/products_cubit.dart';

class ProductItem extends StatelessWidget {
  final Products model;

  const ProductItem({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    final isInCart = context.watch<ProductsCubit>().isInCart(model);

    return Container(
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Center(
              child: Image.network(
                model.images!.first,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Text(model.title ?? '', style: TextStyles.font20SemiBold),
          Text(model.description ?? '',
              maxLines: 1, overflow: TextOverflow.ellipsis),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('\$${model.price}', style: TextStyles.font20SemiBold),
              IconButton(
                onPressed: () => context.read<ProductsCubit>().addToCart(model),
                icon: Icon(isInCart
                    ? Icons.remove_shopping_cart
                    : Icons.add_shopping_cart),
              )
            ],
          ),
        ],
      ),
    );
  }
}
