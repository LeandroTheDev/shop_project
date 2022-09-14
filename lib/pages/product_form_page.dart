import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/models/product_list.dart';
import '../models/product.dart';

class ProductFormPage extends StatefulWidget {
  const ProductFormPage({Key? key}) : super(key: key);

  @override
  State<ProductFormPage> createState() => _ProductFormPageState();
}

class _ProductFormPageState extends State<ProductFormPage> {
  final _priceFocus = FocusNode();
  final _descriptionFocus = FocusNode();
  final _imageUrlFocus = FocusNode();
  final _imageUrlController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  final _formData = Map<String, Object>();

  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _imageUrlFocus.addListener(updateImage);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (_formData.isEmpty) {
      final arg = ModalRoute.of(context)?.settings.arguments;

      if (arg != null) {
        final product = arg as Product;
        _formData['id'] = product.id;
        _formData['name'] = product.name;
        _formData['price'] = product.price;
        _formData['description'] = product.description;
        _formData['imageUrl'] = product.imageUrl;

        _imageUrlController.text = product.imageUrl;
      }
    }
  }

  @override
  void dispose() {
    super.dispose();
    _priceFocus.dispose();
    _descriptionFocus.dispose();

    _imageUrlFocus.removeListener(updateImage);
    _imageUrlFocus.dispose();
  }

  void updateImage() {
    setState(() {});
  }

  bool isValidImage(String url) {
    bool isValidUrl = Uri.tryParse(url)?.hasAbsolutePath ?? false;
    bool endsWithFile = url.toLowerCase().endsWith('.png') ||
        url.toLowerCase().endsWith('.jpg') ||
        url.toLowerCase().endsWith('.jpeg');
    return isValidUrl && endsWithFile;
  }

  void submitForm() {
    final isValid = _formKey.currentState?.validate() ?? false;

    if (!isValid) {
      return;
    }

    _formKey.currentState?.save();

    setState(() {
      _isLoading = true;
    });

    Provider.of<ProductList>(
      context,
      listen: false,
    ).saveProduct(_formData).catchError((erro) {
      return showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text("Ocorreu um Erro"),
          content: const Text("Ocorreu um erro ao salvar o produto"),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text("Ok"),
            )
          ],
        ),
      );
    }).then(
      (value) {
        setState(() => _isLoading = false);
        Navigator.of(context).pop();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
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
      body: _isLoading
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text(
                    'Enviando...',
                    style: TextStyle(fontSize: 70, color: Colors.purple),
                  ),
                  SizedBox(
                    height: 100,
                  ),
                  SizedBox(
                    height: 400,
                    width: 400,
                    child: CircularProgressIndicator(),
                  ),
                ],
              ),
            )
          : Padding(
              padding: const EdgeInsets.all(15.0),
              child: Form(
                key: _formKey,
                child: ListView(
                  children: [
                    TextFormField(
                      initialValue: _formData['name']?.toString(),
                      decoration: const InputDecoration(
                        labelText: 'Nome',
                      ),
                      textInputAction: TextInputAction.next,
                      onFieldSubmitted: (_) {
                        FocusScope.of(context).requestFocus(_priceFocus);
                      },
                      onSaved: (name) => _formData['name'] = name ?? '-',
                      validator: (_name) {
                        final name = _name ?? '';
                        if (name.trim().isEmpty) {
                          return 'Precisa ter um Nome';
                        }
                        if (name.trim().length < 3) {
                          return 'Precisa ter mais de 3 letras';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                        initialValue: _formData['price']?.toString(),
                        decoration: const InputDecoration(labelText: 'Preço'),
                        textInputAction: TextInputAction.next,
                        focusNode: _priceFocus,
                        keyboardType: const TextInputType.numberWithOptions(
                            decimal: true),
                        onFieldSubmitted: (_) {
                          FocusScope.of(context)
                              .requestFocus(_descriptionFocus);
                        },
                        validator: (_price) {
                          final priceString = _price ?? '';
                          final price = double.tryParse(priceString) ?? -1;

                          if (price <= 0) {
                            return 'Informe um preço válido.';
                          }

                          return null;
                        },
                        onSaved: (price) =>
                            _formData['price'] = double.parse(price ?? '0')),
                    TextFormField(
                        initialValue: _formData['description']?.toString(),
                        decoration:
                            const InputDecoration(labelText: 'Descrição'),
                        focusNode: _descriptionFocus,
                        keyboardType: TextInputType.multiline,
                        maxLines: 3,
                        onFieldSubmitted: (_) {
                          FocusScope.of(context).requestFocus(_imageUrlFocus);
                        },
                        validator: (_description) {
                          final description = _description ?? '';
                          if (description.trim().isEmpty) {
                            return 'Precisa ter um Nome';
                          }
                          if (description.trim().length < 10) {
                            return 'Precisa ter mais de 10 letras';
                          }
                          return null;
                        },
                        onSaved: (description) =>
                            _formData['description'] = description ?? '-'),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Expanded(
                          child: TextFormField(
                              decoration: const InputDecoration(
                                  labelText: 'URL da Imagem'),
                              textInputAction: TextInputAction.done,
                              focusNode: _imageUrlFocus,
                              keyboardType: TextInputType.url,
                              controller: _imageUrlController,
                              onFieldSubmitted: (_) => submitForm(),
                              onSaved: (imageURL) =>
                                  _formData['imageUrl'] = imageURL ?? '-',
                              validator: (_imageURL) {
                                final imageURL = _imageURL ?? '';
                                if (isValidImage(imageURL)) {
                                  return null;
                                }
                                return 'Informe uma URL válida';
                              }),
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
                          child: _imageUrlController.text.isEmpty
                              ? const Text('Informe a URL')
                              : Image.network(_imageUrlController.text),
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
