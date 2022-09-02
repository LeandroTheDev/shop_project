import 'package:flutter/cupertino.dart';
import 'package:shop/data/dummy_data.dart';
import 'package:shop/models/product.dart';

class ProductList with ChangeNotifier {
  List<Product> _items = dummyProducts;
  bool _showFavorite = false;

  List<Product> get items {
   if(_showFavorite){
    return _items.where((prod) => prod.isFavorite).toList();
   } 

    return [..._items];
  }

  showFavorite() {
    _showFavorite = true;
    notifyListeners();
  }

  showAll(){
    _showFavorite = false;
    notifyListeners();
  }

  void addProduct(Product product){
    _items.add(product);
    notifyListeners();
  }
}