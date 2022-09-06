import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/components/app_drawer.dart';
import 'package:shop/components/badge.dart';
import 'package:shop/utils/app_routes.dart';
import '../components/product_grid.dart';
import '../models/cart.dart';
import '../models/product_list.dart';

enum FilterOptions {
  favorites,
  all,
}

class ProductsOverviewPage extends StatefulWidget {
  const ProductsOverviewPage({Key? key}) : super(key: key);

  @override
  State<ProductsOverviewPage> createState() => _ProductsOverviewPageState();
}

class _ProductsOverviewPageState extends State<ProductsOverviewPage> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProductList>(context);
    return Scaffold(
      appBar: AppBar(
          actions: [
            PopupMenuButton(
              itemBuilder: (_) => [
                const PopupMenuItem(
                  child: Text("Somente Favoritos"),
                  value: FilterOptions.favorites,
                ),
                const PopupMenuItem(
                  child: Text("Todos"),
                  value: FilterOptions.all,
                ),
              ],
              onSelected: (FilterOptions selectedValue) {
                setState(() {
                  if (selectedValue == FilterOptions.favorites) {
                    provider.showFavorite();
                  } else {
                    provider.showAll();
                  }
                });
              },
            ),
            Consumer<Cart>(
              child: IconButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(AppRoutes.CART);
                },
                icon: const Icon(Icons.shopping_cart),
              ),
              builder: (ctx, cart, child) => Badge(
                value: cart.itemsCount.toString(),
                child: child!,
              ),
            ),
          ],
          title: const Text(
            'Minha Loja',
          )),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ProductGrid(),
      ),
      drawer: AppDrawer(),
    );
  }
}
