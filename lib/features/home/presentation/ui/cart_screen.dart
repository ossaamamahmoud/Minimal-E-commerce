import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:payment/core/helpers/extensions.dart';
import 'package:payment/core/theming/app_styles.dart';

import '../../../../core/di/dependency_injection.dart';
import '../../../payment/presentation/cubits/payments_cubit/payment_cubit.dart';
import '../../../payment/presentation/ui/payment_methods_screen.dart';
import '../cubits/products_cubit.dart';
import '../cubits/products_state.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductsCubit, ProductsState>(
      builder: (context, state) {
        final cubit = context.read<ProductsCubit>();
        final cart = cubit.cart;
        final total = cubit.total;

        return cart.isEmpty
            ? const Center(child: Text('Your cart is empty'))
            : Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: cart.length,
                      itemBuilder: (context, index) {
                        final product = cart[index];
                        return ListTile(
                          title: Text(
                            product.title ?? '',
                            style: TextStyles.font20SemiBold,
                          ),
                          subtitle: Text(
                            '\$${product.price}',
                            style: TextStyles.font16semiBold,
                          ),
                          trailing: IconButton(
                            icon: const Icon(Icons.clear),
                            onPressed: () => cubit.removeFromCart(product),
                          ),
                        );
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Total: \$${total.toStringAsFixed(2)}',
                          style: TextStyles.font24Bold,
                        ),
                        SizedBox(
                          width: 100,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            onPressed: () {
                              context.navigateTo(
                                BlocProvider(
                                  create: (context) => getIt<PaymentsCubit>(),
                                  child: PaymentMethodsScreen(
                                    amount: double.parse(
                                      total.toStringAsFixed(
                                        2,
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                            child: Text(
                              'Pay',
                              style: TextStyles.font20SemiBold
                                  .copyWith(color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              );
      },
    );
  }
}
