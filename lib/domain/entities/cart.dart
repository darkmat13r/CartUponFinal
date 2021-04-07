import 'package:coupon_app/app/components/cart_item.dart';
import 'package:coupon_app/domain/mapper/cart_item_mapper.dart';

class Cart{
  List<CartItemView> cartItems;
  int quantity;
  double price;
  double total;
  double tax;

  Cart({this.cartItems, this.quantity, this.price, this.total, this.tax});
}