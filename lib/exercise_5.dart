import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

const primarySwatch = Colors.purple;

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: primarySwatch,
      ),
      home: const YourProducts(),
    );
  }
}

class Product {
  int id;
  String title;
  double? price;
  String description;
  String imageUrl;

  Product({
    this.id = -1,
    this.title = '',
    this.price,
    this.description = '',
    this.imageUrl = '',
  });
}

List<Product> products = [
  Product(
    id: 1,
    title: 'Demo',
    price: 100,
    description: 'Demo',
    imageUrl:
        'https://dongphuccaocap.vn/wp-content/uploads/2017/05/ao-thun-qua-tang-1.jpg',
  ),
  Product(
    id: 2,
    title: 'product 2',
    price: 80,
    description: '',
    imageUrl:
        'https://dongphuccaocap.vn/wp-content/uploads/2017/10/ao-thun-co-co-1.jpg',
  ),
  Product(
    id: 3,
    title: 'Ao thun',
    price: 50,
    description: 'Ao thun',
    imageUrl:
        'https://dongphuccaocap.vn/wp-content/uploads/2018/08/dong-phuc-cong-so-may-do-1.jpg',
  ),
];

class YourProducts extends StatefulWidget {
  const YourProducts({Key? key}) : super(key: key);

  @override
  State<YourProducts> createState() => _YourProductsState();
}

class _YourProductsState extends State<YourProducts> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Products'),
        leading: const Icon(Icons.menu),
        actions: [
          IconButton(
            onPressed: () async {
              final result = await Navigator.push<bool>(
                context,
                MaterialPageRoute(
                  builder: (context) => EditProduct(product: Product()),
                ),
              );
              if (result == true) {
                setState(() {});
              }
            },
            icon: const Icon(Icons.add),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListView.separated(
          itemBuilder: (ctx, idx) {
            return Padding(
              padding: const EdgeInsets.only(left: 15.0, right: 15.0),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 15.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(25),
                      child: Image.network(
                        products[idx].imageUrl,
                        width: 50,
                        height: 50,
                        fit: BoxFit.fill,
                        errorBuilder: (ctx, obj, trace) => Container(
                          color: Colors.grey,
                          width: 50,
                          height: 50,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      products[idx].title,
                      style: const TextStyle(fontSize: 18),
                    ),
                  ),
                  IconButton(
                    onPressed: () async {
                      final result = await Navigator.push<bool>(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              EditProduct(product: products[idx]),
                        ),
                      );
                      if (result == true) {
                        setState(() {});
                      }
                    },
                    icon: const Icon(Icons.edit, color: primarySwatch),
                  ),
                  IconButton(
                    onPressed: () {
                      setState(() => products.removeAt(idx));
                    },
                    icon: const Icon(Icons.delete, color: Colors.red),
                  ),
                ],
              ),
            );
          },
          separatorBuilder: (ctx, idx) {
            return const Divider();
          },
          itemCount: products.length,
        ),
      ),
    );
  }
}

class EditProduct extends StatefulWidget {
  final Product product;
  const EditProduct({
    Key? key,
    required this.product,
  }) : super(key: key);

  @override
  State<EditProduct> createState() => _EditProductState();
}

class _EditProductState extends State<EditProduct> {
  final formKey = GlobalKey<FormState>();
  final titleController = TextEditingController();
  final priceController = TextEditingController();
  final descriptionController = TextEditingController();
  final imageUrlController = TextEditingController();

  @override
  void initState() {
    super.initState();

    titleController.text = widget.product.title;
    priceController.text = widget.product.price?.toString() ?? '';
    descriptionController.text = widget.product.description;
    imageUrlController.text = widget.product.imageUrl;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Product'),
        actions: [
          IconButton(
            onPressed: () {
              if (formKey.currentState?.validate() != true) {
                return;
              }

              _updateModel();

              if (widget.product.id < 0) {
                int maxId = -1;
                for (var product in products) {
                  if (product.id > maxId) maxId = product.id;
                }
                widget.product.id = maxId + 1;
                products.add(widget.product);
              }

              Navigator.pop(context, true);
            },
            icon: const Icon(Icons.save),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              TextFormField(
                controller: titleController,
                decoration: const InputDecoration(
                  hintText: 'Title',
                ),
                validator: (text) {
                  if (text == null || text.isEmpty) {
                    return 'Please provide a value.';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: priceController,
                decoration: const InputDecoration(
                  hintText: 'Price',
                ),
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*$')),
                ],
                validator: (text) {
                  if (text == null || text.isEmpty) {
                    return 'Please enter a price.';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: descriptionController,
                decoration: const InputDecoration(
                  hintText: 'Description',
                ),
                validator: (text) {
                  if (text == null || text.isEmpty) {
                    return 'Please enter a description.';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 5),
              LayoutBuilder(
                builder: (ctx, constraints) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Container(
                        width: 100,
                        height: 100,
                        margin: const EdgeInsets.only(right: 10),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.black12,
                            width: 2,
                          ),
                        ),
                        child: Image.network(
                          imageUrlController.text,
                          fit: BoxFit.fill,
                          errorBuilder: (ctx, obj, trace) =>
                              const Text('Enter a URL'),
                        ),
                      ),
                      Expanded(
                        child: TextFormField(
                          controller: imageUrlController,
                          decoration: const InputDecoration(
                            hintText: 'Image URL',
                          ),
                          validator: (text) {
                            if (text == null || text.isEmpty) {
                              return 'Please enter an image URL.';
                            }
                            return null;
                          },
                          onChanged: (text) => _updateModel(),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _updateModel() {
    setState(() {
      widget.product.title = titleController.text;
      widget.product.price = double.tryParse(priceController.text);
      widget.product.description = descriptionController.text;
      widget.product.imageUrl = imageUrlController.text;
    });
  }
}
