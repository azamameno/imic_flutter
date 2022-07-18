import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:imic_flutter/models/product.dart';
import 'package:imic_flutter/providers/cart_provider.dart';
import 'package:imic_flutter/providers/favorite_provider.dart';
import 'package:imic_flutter/providers/product_provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

const primarySwatch = Colors.purple;

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: ProductProvider()),
        ChangeNotifierProvider.value(value: CartProvider()),
        ChangeNotifierProvider.value(value: FavoriteProvider()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: primarySwatch,
        ),
        home: const Products(),
      ),
    );
  }
}

class Products extends StatefulWidget {
  const Products({Key? key}) : super(key: key);

  @override
  State<Products> createState() => _ProductsState();
}

class _ProductsState extends State<Products> {
  @override
  Widget build(BuildContext context) {
    var products = Provider.of<ProductProvider>(context).getProducts;
    var cartCount = Provider.of<CartProvider>(context).count;

    return Scaffold(
      appBar: AppBar(
        title: const Text('MyShow'),
        leading: const Icon(Icons.menu),
        actions: [
          IconButton(
            onPressed: () {},
            padding: EdgeInsets.zero,
            splashRadius: 1.0,
            icon: const Icon(Icons.more_vert),
          ),
          Badge(
            position: BadgePosition.topEnd(top: 5, end: 5),
            badgeColor: Theme.of(context).primaryColor,
            badgeContent: Text(
              '$cartCount',
              style: const TextStyle(color: Colors.white, fontSize: 10),
            ),
            child: IconButton(
              onPressed: () {},
              padding: EdgeInsets.zero,
              splashRadius: 1.0,
              icon: const Icon(Icons.shopping_cart),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.count(
          crossAxisCount: 2,
          childAspectRatio: 4 / 3,
          mainAxisSpacing: 8,
          crossAxisSpacing: 8,
          children: products.map((e) => ProductItem(product: e)).toList(),
        ),
      ),
    );
  }
}

class ProductItem extends StatefulWidget {
  final Product product;
  const ProductItem({
    Key? key,
    required this.product,
  }) : super(key: key);

  @override
  State<ProductItem> createState() => _ProductItemState();
}

class _ProductItemState extends State<ProductItem> {
  @override
  Widget build(BuildContext context) {
    final Color iconColor = Theme.of(context).primaryColor;
    const Radius radius = Radius.circular(10.0);
    final BorderRadius borderRadius = BorderRadius.circular(10.0);

    final favorite =
        Provider.of<FavoriteProvider>(context).has(widget.product.id!);

    return Card(
      shape: RoundedRectangleBorder(borderRadius: borderRadius),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  ProductDetailScreen(product: widget.product),
            ),
          );
        },
        child: Stack(
          alignment: AlignmentDirectional.bottomCenter,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.all(radius),
              child: Image.network(
                widget.product.imageUrl,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(
                vertical: 4.0,
                horizontal: 8.0,
              ),
              decoration: const BoxDecoration(
                color: Colors.black87,
                borderRadius: BorderRadius.only(
                  bottomLeft: radius,
                  bottomRight: radius,
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () {
                      Provider.of<FavoriteProvider>(context, listen: false)
                          .set(widget.product.id!);
                    },
                    padding: EdgeInsets.zero,
                    splashRadius: 1.0,
                    icon: Icon(
                      favorite ? Icons.favorite : Icons.favorite_border,
                      color: iconColor,
                    ),
                  ),
                  Flexible(
                    child: Text(
                      widget.product.title,
                      style: const TextStyle(color: Colors.white),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      Provider.of<CartProvider>(context, listen: false)
                          .setItem(widget.product.id!, 1);
                    },
                    padding: EdgeInsets.zero,
                    splashRadius: 1.0,
                    icon: Icon(Icons.shopping_cart, color: iconColor),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ProductDetailScreen extends StatefulWidget {
  final Product product;
  const ProductDetailScreen({
    Key? key,
    required this.product,
  }) : super(key: key);

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      body: ProductDetail(product: widget.product),
    );
  }
}

class ProductDetail extends StatefulWidget {
  final Product product;
  const ProductDetail({
    Key? key,
    required this.product,
  }) : super(key: key);

  @override
  State<ProductDetail> createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Stack(
          alignment: AlignmentDirectional.bottomStart,
          children: [
            Image.network(
              widget.product.imageUrl,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            Container(
              padding: const EdgeInsets.symmetric(
                vertical: 20.0,
                horizontal: 50.0,
              ),
              child: Text(
                widget.product.title,
                style: const TextStyle(color: Colors.white, fontSize: 25),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8.0),
        Text(
          '\$${widget.product.price}',
          style: const TextStyle(
            color: Colors.grey,
            fontSize: 22,
          ),
        ),
        const SizedBox(height: 8.0),
        Text(
          widget.product.description,
          style: const TextStyle(fontSize: 18),
        ),
      ],
    );
  }
}
