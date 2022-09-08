import 'package:flutter/material.dart';
import 'package:shop/models/product.dart';

class ProductItem extends StatelessWidget {
  final Product produto;
  const ProductItem({Key? key, required this.produto}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: NetworkImage(produto.imageUrl),
      ),
      title: Text(produto.name),
      trailing: SizedBox(
        width: 100,
        child: Row(children: [
          IconButton(
            icon: Icon(Icons.edit, color: Theme.of(context).colorScheme.primary,),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.delete, color: Colors.red,),
            onPressed: () {},
          ),
        ]),
      ),
    );
  }
}
