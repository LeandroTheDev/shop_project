import 'package:flutter/material.dart';
import 'package:shop/components/app_drawer.dart';

class OrdersPages extends StatelessWidget {
  const OrdersPages({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Meus Pedidos")),
      drawer: AppDrawer(),
    );
  }
}