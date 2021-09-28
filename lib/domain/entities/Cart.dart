import 'package:coupon_app/domain/entities/models/CartItem.dart';

class Cart {
    List<CartItem> cart;
    double net_total;
    int total_qty;

    Cart({this.cart, this.net_total, this.total_qty});

    factory Cart.fromJson(Map<String, dynamic> json) {
        return Cart(
            cart: json['cart'] != null ? (json['cart'] as List).map((i) => CartItem.fromJson(i)).toList() : null,
            net_total: double.tryParse(json['net_total'].toString()),
            total_qty: json['total_qty'], 
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['net_total'] = this.net_total;
        data['total_qty'] = this.total_qty;
        if (this.cart != null) {
            data['cart'] = this.cart.map((v) => v.toJson()).toList();
        }
        return data;
    }
}