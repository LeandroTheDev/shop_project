import 'package:flutter/material.dart';
import 'package:shop/models/cart_item.dart';

class CartItemWidget extends StatelessWidget {
  final CartItem cartItem;
  const CartItemWidget({
    Key? key,
    required this.cartItem,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 4),
      child: ListTile(
        
        title: Text(cartItem.title),
        subtitle: Text("Total R\$ ${cartItem.price * cartItem.quantity}"),
        trailing: Text("${cartItem.quantity}x"),
      ),
    );
  }
}
