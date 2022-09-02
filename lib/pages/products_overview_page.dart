import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../components/product_grid.dart';
import '../models/product_list.dart';

enum FilterOptions {
  Favorites,
  All,
}

class ProductsOverviewPage extends StatelessWidget {
  ProductsOverviewPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProductList>(context);
    return Scaffold(
      appBar: AppBar(
          actions: [
            PopupMenuButton(
              itemBuilder: (_) => [
                PopupMenuItem(
                  child: Text("Somente Favoritos"),
                  value: FilterOptions.Favorites,
                ),
                PopupMenuItem(
                  child: Text("Todos"),
                  value: FilterOptions.All,
                ),
              ],
              onSelected: (FilterOptions selectedValue){
                if(selectedValue == FilterOptions.Favorites) {
                  provider.showFavorite();
                } else {
                  provider.showAll();
                }
              },
            ),
          ],
          title: Text(
            'Minha Loja',
          )),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ProductGrid(),
      ),
    );
  }
}
