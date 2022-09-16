import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/models/product.dart';
import 'package:shop/models/product_list.dart';
import 'package:shop/utils/app_routes.dart';

import '../exceptions/http_exceptions.dart';

class ProductItem extends StatelessWidget {
  final Product produto;
  const ProductItem({Key? key, required this.produto}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final msg = ScaffoldMessenger.of(context);
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: NetworkImage(produto.imageUrl),
      ),
      title: Text(produto.name),
      trailing: SizedBox(
        width: 100,
        child: Row(children: [
          IconButton(
            icon: Icon(
              Icons.edit,
              color: Theme.of(context).colorScheme.primary,
            ),
            onPressed: () {
              Navigator.of(context)
                  .pushNamed(AppRoutes.productsForm, arguments: produto);
            },
          ),
          IconButton(
            icon: const Icon(
              Icons.delete,
              color: Colors.red,
            ),
            onPressed: () {
              showDialog(
                context: context,
                builder: (ctx) => AlertDialog(
                  title: const Text('Excluir Produto'),
                  content: const Text('Tem certeza?'),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(false),
                      child: const Text('Não'),
                    ),
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(true),
                      child: const Text('Sim'),
                    ),
                  ],
                ),
              ).then((value) async {
                if (value ?? false) {
                  try {
                    await Provider.of<ProductList>(
                      context,
                      listen: false,
                    ).removeProduct(produto);
                  } on HttpException catch (error) {
                    msg.showSnackBar(
                      SnackBar(
                        content: Text(error.toString()),
                      ),
                    );
                  }
                }
              });
            },
          ),
        ]),
      ),
    );
  }
}
