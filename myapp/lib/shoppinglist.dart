import 'package:flutter/material.dart';
import 'shoppinglistitem.dart';

class ShoppingList extends StatefulWidget {
  final List<Product> products;
  ShoppingList({ Key key, this.products }): super(key: key);
  // ShoppingList({ Key key, this.products }) : super(key: key) {
  //   print('==============');
  //   print(key);
  //   print('==============');
  // }

  @override
  _ShoppingListState createState() => new _ShoppingListState();
}

class _ShoppingListState extends State<ShoppingList> {
  Set<Product> _shoppingCart = new Set<Product>();

  void _handleCartChanged(Product product, bool inCart) {
    setState(() {
      if (inCart)
        _shoppingCart.add(product);
      else
        _shoppingCart.remove(product);
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Shopping List')
      ),
      body: new MaterialList(
        type: MaterialListType.oneLineWithAvatar,
        children: config.products.map((Product product) {
          return new ShoppingListItem(
            product: product,
            inCart: _shoppingCart.contains(product),
            onCartChanged: _handleCartChanged
          );
        })
      )
    );
  }
}

final List<Product> _kProducts = <Product>[
  new Product(name: 'Eggs'),
  new Product(name: 'Flour'),
  new Product(name: 'Chocolate chips')
];

void main() {
  runApp(
    new MaterialApp(
      title: 'Shooping List',
      home: new ShoppingList(products: _kProducts)
    )
  );
}
