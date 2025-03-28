import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:payment/core/theming/app_styles.dart';
import 'package:payment/features/home/presentation/cubits/products_cubit.dart';
import 'package:payment/features/home/presentation/ui/products_screen.dart';

import 'cart_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  final List<Widget> _pages = const [
    ProductsScreen(),
    CartScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final cubit = context.watch<ProductsCubit>();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          cubit.currentIndex == 0 ? "Products" : "Cart",
          style: TextStyles.font24Bold.copyWith(
            color: Colors.blue,
          ),
        ),
        centerTitle: true,
      ),
      body: IndexedStack(
        index: cubit.currentIndex,
        children: _pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: cubit.currentIndex,
        onTap: cubit.toggleBottomNavigationBar,
        items: [
          const BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(
              icon: Stack(
                children: [
                  const Icon(Icons.shopping_cart_outlined),
                  if (cubit.cart.isNotEmpty)
                    Positioned(
                      right: 0,
                      top: 0,
                      child: Container(
                        padding: const EdgeInsets.all(2),
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        constraints:
                            const BoxConstraints(minWidth: 12, minHeight: 12),
                        child: Text(
                          '${cubit.cart.length}',
                          style:
                              const TextStyle(color: Colors.white, fontSize: 8),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                ],
              ),
              label: "Cart"),
        ],
      ),
    );
  }
}
