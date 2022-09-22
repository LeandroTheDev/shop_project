import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/pages/auth_page.dart';
import 'package:shop/pages/products_overview_page.dart';

import '../models/auth.dart';

class AuthHomePage extends StatelessWidget {
  const AuthHomePage({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Auth auth = Provider.of(context);
    return auth.isAuth ? const ProductsOverviewPage() : const AuthPage();
  }
}