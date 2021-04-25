import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/screens/cart_screen.dart';

// Widgets
import 'package:shop_app/widgets/badge.dart'; // Badge
import 'package:shop_app/widgets/app_drawer.dart'; // AppDrawer
import 'package:shop_app/widgets/products_grid.dart'; // ProductsGrid

// Provider
import 'package:shop_app/providers/cart.dart'; // Cart

enum FilterOptions {
  Favorites,
  All,
}

// Main
class ProductsOverviewScreen extends StatefulWidget {
  // Contructor
  ProductsOverviewScreen();

  @override
  _ProductsOverviewScreenState createState() => _ProductsOverviewScreenState();
}

class _ProductsOverviewScreenState extends State<ProductsOverviewScreen> {
  var _showOnlyFavorites = false;

  // build
  @override
  Widget build(BuildContext context) {
    // return
    return Scaffold(
      // AppBar
      appBar: AppBar(
        title: Text('My Shop'),
        actions: [
          // ... Icon
          PopupMenuButton(
            onSelected: (FilterOptions selectedValue) {
              setState(() {
                if (selectedValue == FilterOptions.Favorites) {
                  _showOnlyFavorites = true;
                } else {
                  _showOnlyFavorites = false;
                }
              });
            },
            icon: Icon(Icons.more_horiz_rounded),
            itemBuilder: (ctx) => [
              PopupMenuItem(
                child: Text('Only Favorites'),
                value: FilterOptions.Favorites,
              ),
              PopupMenuItem(
                child: Text('Only Favorites'),
                value: FilterOptions.All,
              ),
            ],
          ),
          // Cart Icon
          Consumer<Cart>(
            builder: (ctx, cart, ch) => Badge(
              child: ch,
              value: cart.itemCount.toString(),
              color: Colors.blue,
            ),
            child: IconButton(
              icon: Icon(
                Icons.shopping_cart,
              ),
              // Move to CartScreen
              onPressed: () {
                Navigator.of(context).pushNamed(CartScreen.routeName);
              },
            ),
          ),
        ],
      ),
      
      // drawer
      drawer: AppDrawer(),

      // Body
      body: ProductsGrid(_showOnlyFavorites),
    );
  }
}
