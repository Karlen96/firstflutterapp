import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:myapp/helpers/config.dart';
import 'package:myapp/providers/cartProvider.dart';
import 'package:provider/provider.dart';
import 'package:easy_localization/easy_localization.dart';

class CartPage extends StatelessWidget {
  const CartPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CartProvider cart = context.watch<CartProvider>();
    List cartItems = cart.getCart;
    return Scaffold(
      appBar: AppBar(
        title: Text('cart'.tr().toString()),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: cartItems.length,
        itemBuilder: (context, index) {
          return cartItem(cartItems[index], cart);
        },
      ),
    );
  }

  void getLaunguage(BuildContext context) {
    print(EasyLocalization.of(context).locale);
  }

  Widget cartItem(item, cart) {
    String imageUrl = item['linkfoto'] != null
        ? Config.imageUrl + item['linkfoto']
        : 'http://placehold.it/100x100';
    return Container(
      height: 90,
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Image.network(imageUrl),
            flex: 1,
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(item['name']),
                  Text(item['price'].toString() + ' դր'),
                ],
              ),
            ),
            flex: 3,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  child: InkWell(
                    child: Container(
                      padding: EdgeInsets.all(10),
                      child: Icon(
                        Icons.delete,
                        size: 18,
                      ),
                    ),
                    onTap: () {
                      cart.deleteItemTocart(item['ident']);
                    },
                  ),
                ),
                Container(
                  child: Row(
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
                          cart.updateItemCartMinusCount(item['ident']);
                        },
                      ),
                      Text(item['count'].toString()),
                      InkWell(
                        child: Container(
                          padding: EdgeInsets.all(10),
                          child: FaIcon(
                            FontAwesomeIcons.plus,
                            size: 12,
                          ),
                        ),
                        onTap: () {
                          cart.updateItemCartPlusCount(item['ident']);
                        },
                      ),
                    ],
                  ),
                )
              ],
            ),
            flex: 1,
          ),
        ],
      ),
    );
  }
}
