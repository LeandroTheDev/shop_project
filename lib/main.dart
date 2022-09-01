import 'package:flutter/material.dart';
import 'package:shop/pages/product_detail_page.dart';
import 'package:shop/utils/app_routes.dart';
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
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: const Color.fromARGB(255, 126, 47, 179),
          secondary: Color.fromARGB(255, 233, 113, 0),
        ),
        fontFamily: "Lato",
      ),
      routes: {
        AppRoutes.PRODUCT_DETAIL: (ctx) => ProductDetailPage()
      },
    );
  }
}
