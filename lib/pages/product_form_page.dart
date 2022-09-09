import 'dart:ffi';
import 'dart:math';

import 'package:flutter/material.dart';

import '../models/product.dart';

class ProductFormPage extends StatefulWidget {
  const ProductFormPage({Key? key}) : super(key: key);

  @override
  State<ProductFormPage> createState() => _ProductFormPageState();
}

class _ProductFormPageState extends State<ProductFormPage> {
  @override
  Widget build(BuildContext context) {
    final _priceFocus = FocusNode();
    final _descriptionFocus = FocusNode();
    final _imageURLFocus = FocusNode();
    final _imageURLController = TextEditingController();

    final _formKey = GlobalKey<FormState>();
    final _formData = Map<String, Object>();

    void submitForm() {
      _formKey.currentState?.save();
      final newProduct = Product(
        id: Random().nextDouble().toString(),
        name: _formData['name'] as String,
        description: _formData['description'] as String,
        price: _formData['price'] as double,
        imageUrl:  _formData['imageURL'] as String,
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Formulario"),
        actions: [
          IconButton(
            onPressed: () => submitForm(),
            icon: const Icon(Icons.save),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                decoration: const InputDecoration(labelText: 'Nome'),
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_priceFocus);
                },
                onSaved: (name) => _formData['name'] = name ?? '-',
              ),
              TextFormField(
                  decoration: const InputDecoration(labelText: 'Preço'),
                  textInputAction: TextInputAction.next,
                  focusNode: _priceFocus,
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                  onFieldSubmitted: (_) {
                    FocusScope.of(context).requestFocus(_descriptionFocus);
                  },
                  onSaved: (price) =>
                      _formData['price'] = double.parse(price ?? '0')),
              TextFormField(
                  decoration: const InputDecoration(labelText: 'Descrição'),
                  focusNode: _descriptionFocus,
                  keyboardType: TextInputType.multiline,
                  maxLines: 3,
                  onFieldSubmitted: (_) {
                    FocusScope.of(context).requestFocus(_imageURLFocus);
                  },
                  onSaved: (description) => _formData['description'] = description ?? '-'),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    child: TextFormField(
                      decoration:
                          const InputDecoration(labelText: 'URL da Imagem'),
                      textInputAction: TextInputAction.done,
                      focusNode: _imageURLFocus,
                      keyboardType: TextInputType.url,
                      controller: _imageURLController,
                      onFieldSubmitted: (_) => submitForm(),
                      onSaved: (imageURL) => _formData['imageURL'] = imageURL ?? '-',
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    width: 100,
                    height: 100,
                    margin: const EdgeInsets.only(
                      top: 10,
                      left: 10,
                    ),
                    decoration: BoxDecoration(
                        border: Border.all(
                      color: Colors.grey,
                      width: 2,
                    )),
                    child: _imageURLController.text.isEmpty
                        ? const Text('Informe a URL')
                        : FittedBox(
                            child: Image.network(_imageURLController.text),
                            fit: BoxFit.cover,
                          ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
