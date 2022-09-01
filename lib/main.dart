import 'package:flutter/material.dart';
import 'pages/products_overview_page.dart';

void main() {
  runApp(const MyShop());
}

class MyShop extends StatelessWidget {
  const MyShop({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context){

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ProductsOverviewPage(),
    );
  }
}
