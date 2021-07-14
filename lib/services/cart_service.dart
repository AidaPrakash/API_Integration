import 'package:pon/core/models/Price.dart';
import 'package:pon/core/models/cart.dart';
import 'package:pon/core/models/product.dart';
import 'package:pon/core/models/products.dart';
import 'package:fluttertoast/fluttertoast.dart';

class CartService {
  List<Cart> _cart = new List();

  List<Cart> get cart => _cart;

  int intpackQty;

  updateToCart(Products product, int quantity, double pprice, String packQty,
      String prodnamesize) {
    print("CART DATA ${product.toJson()} | $quantity");
    intpackQty = int.parse(packQty);
    var dataIndex = _cart.indexWhere(
        (element) => element.product.prodname == product.prodname, -1);

    if (dataIndex != -1) {
      _cart.removeAt(dataIndex);

      if (quantity != 0) {
        _cart.insert(
            dataIndex,
            Cart(product, quantity, pprice, product.size, product.colour,
                product.pack, intpackQty, product.prodnamesize));
      }
    } else {
      _cart.add(Cart(product, quantity, pprice, product.size, product.colour,
          product.pack, intpackQty, product.prodnamesize));
    }

    print("CART LENGTH ${_cart.length}");
  }

  refreshCart() {
    _cart.clear();
    _cart = new List();
  }

  int getProductCartQty(Products product) {
    var data = _cart.firstWhere(
        (element) => element.prodnamesize == product.prodnamesize,
        orElse: () => null);
    if (data == null) {
      return 0;
    }
    return data.quantity;
  }

  int cartCount() {
    return _cart.length;
  }

  updateCartList(List<Cart> cart) {
    _cart = cart;
  }
}
