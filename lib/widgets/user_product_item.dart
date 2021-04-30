import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/products.dart';

// Route
import 'package:shop_app/screens/edit_product_screen.dart'; // EditProductScreen

class UserProductItem extends StatelessWidget {
  final String id;
  final String title;
  final String imageUrl;

  // Constructor
  UserProductItem(
    this.id,
    this.title,
    this.imageUrl,
  );

  // build
  @override
  Widget build(BuildContext context) {
    // return
    return ListTile(
      title: Text(title),
      leading: CircleAvatar(
        backgroundImage: NetworkImage(imageUrl),
      ),
      trailing: FittedBox(
        child: Row(
          children: [
            IconButton(
              icon: Icon(Icons.edit),
              color: Theme.of(context).primaryColor,
              onPressed: () {
                Navigator.of(context).pushNamed(
                  EditProductScreen.routeName,
                  arguments: id,
                );
              },
            ),
            IconButton(
              icon: Icon(Icons.delete),
              color: Theme.of(context).errorColor,
              onPressed: () {
                Provider.of<Products>(context, listen: false).deleteProduct(id);
              },
            ),
          ],
        ),
      ),
    );
  }
}