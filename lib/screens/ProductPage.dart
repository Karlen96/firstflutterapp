import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:myapp/helpers/config.dart';
import 'package:myapp/providers/cartProvider.dart';
import 'package:myapp/providers/categoryProvider.dart';
import 'package:provider/provider.dart';

class ProductPage extends StatefulWidget {
  final item;
  const ProductPage({Key key, this.item}) : super(key: key);

  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  int countProduct = 1;
  @override
  Widget build(BuildContext context) {
    CategoryProvider categoryProvider = context.watch<CategoryProvider>();
    CartProvider cartProvider = context.watch<CartProvider>();
    String imageUrl = widget.item['linkfoto'] != null
        ? Config.imageUrl + '/' + widget.item['linkfoto']
        : 'http://placehold.it/100x100';
    String price = widget.item['price'].toString() + ' դր․';
    return SafeArea(
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              child: Expanded(
                flex: 1,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        icon: Icon(
                          Icons.keyboard_backspace,
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                      IconButton(
                        icon: Icon(
                          (widget.item['favorit'])
                              ? Icons.favorite
                              : Icons.favorite_border,
                          color: Colors.red,
                        ),
                        onPressed: () {
                          categoryProvider
                              .changeStatusFavorit(widget.item['ident']);
                        },
                      )
                    ],
                  ),
                ),
              ),
            ),
            Container(
              child: Expanded(
                flex: 4,
                child: Container(
                  alignment: Alignment.center,
                  child: Image.network(
                    imageUrl,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Container(
              child: Expanded(
                flex: 6,
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.all(5),
                      width: double.infinity,
                      child: Text(
                        widget.item['name'],
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(5),
                      width: double.infinity,
                      child: Text(
                        price,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(5),
                      width: double.infinity,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          InkWell(
                            child: Container(
                              padding: EdgeInsets.all(10),
                              child: FaIcon(
                                FontAwesomeIcons.minus,
                                size: 12,
                              ),
                            ),
                            onTap: () {
                              if (countProduct > 1) {
                                setState(() {
                                  countProduct--;
                                });
                              }
                            },
                          ),
                          Text('$countProduct'),
                          InkWell(
                            child: Container(
                              padding: EdgeInsets.all(10),
                              child: FaIcon(
                                FontAwesomeIcons.plus,
                                size: 12,
                              ),
                            ),
                            onTap: () {
                              setState(() {
                                countProduct++;
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 15),
                      child: Text(
                        widget.item['description'],
                        textAlign: TextAlign.center,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            cartProvider.addItemToCart(widget.item, countProduct);
          },
          child: const Icon(Icons.shopping_cart),
          backgroundColor: Colors.green,
        ),
      ),
    );
  }
}
