import 'package:cart_data/cart_data.dart';
import 'package:cart_domain/cart_domain.dart';
import 'package:cart_presentation/cart_presentation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:product_data/product_data.dart';
import 'package:product_domain/product_domain.dart';
import 'package:product_presentation/product_presentation.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<ProductRepository>(
          create: (_) => const ProductRepositoryImpl(),
        ),
        RepositoryProvider<CartRepository>(
          create: (_) => CartRepositoryImpl(),
        ),
      ],
      child: BlocProvider(
        create: (context) => CartBloc(
          repository: context.read<CartRepository>(),
        )..add(CartStarted()),
        child: MaterialApp(
          title: 'Flutist Shop',
          theme: ThemeData(
            useMaterial3: true,
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          ),
          home: const _ShopShell(),
        ),
      ),
    );
  }
}

class _ShopShell extends StatefulWidget {
  const _ShopShell();

  @override
  State<_ShopShell> createState() => _ShopShellState();
}

class _ShopShellState extends State<_ShopShell> {
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _index,
        children: [
          ProductListPage(
            onAddToCart: (product) => context.read<CartBloc>().add(
                  CartItemAdded(
                    CartItem(
                      productId: product.id,
                      name: product.name,
                      price: product.price,
                      quantity: 1,
                    ),
                  ),
                ),
          ),
          const CartPage(),
        ],
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _index,
        onDestinationSelected: (i) => setState(() => _index = i),
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.store),
            label: 'Products',
          ),
          NavigationDestination(
            icon: Icon(Icons.shopping_cart),
            label: 'Cart',
          ),
        ],
      ),
    );
  }
}
