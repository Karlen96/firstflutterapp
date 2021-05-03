import 'package:flutter/cupertino.dart';

class CartProvider extends ChangeNotifier {
  List cart = [];

  get getCart => cart;
  get getCartLength => cart.length;

  //add item to cart
  void addItemToCart(dynamic item, int countProduct) {
    bool findItem = false;
    for (int i = 0; i < cart.length; i++) {
      if (cart[i]['ident'] == item['ident']) {
        cart[i]['count'] += countProduct;
        findItem = true;
      }
    }
    if (!findItem) {
      item['count'] = countProduct;
      cart.add(item);
    }
    notifyListeners();
  }

  //change count item from cart plus
  void updateItemCartPlusCount(int ident) {
    for (int i = 0; i < cart.length; i++) {
      if (cart[i]['ident'] == ident) {
        cart[i]['count']++;
      }
    }
    notifyListeners();
  }

  //change count item from cart minus
  void updateItemCartMinusCount(int ident) {
    for (int i = 0; i < cart.length; i++) {
      if (cart[i]['ident'] == ident) {
        if (cart[i]['count'] > 1) {
          cart[i]['count']--;
        }
      }
    }
    notifyListeners();
  }

  //remove item to cart
  void deleteItemTocart(int ident) {
    for (int i = 0; i < cart.length; i++) {
      if (cart[i]['ident'] == ident) {
        cart.remove(cart[i]);
      }
    }
    notifyListeners();
  }
}
