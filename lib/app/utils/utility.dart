import 'package:coupon_app/app/utils/locale_keys.dart';
import 'package:coupon_app/domain/entities/models/Address.dart';
import 'package:coupon_app/domain/entities/models/CartItem.dart';
import 'package:coupon_app/domain/entities/models/OrderDetail.dart';

class Utility {
  static String currencyFormat(dynamic price) {
    if(price == null){
      return "";
    }
    if (price is String)
      return NumberFormat.currency(symbol: "KD").format(double.tryParse(price));
    return NumberFormat.currency(symbol: "KD").format(price);
  }


  static getCartItemPrice(CartItem cartItem) {
    double price = 0;
    if (cartItem != null) {
      if (cartItem.variant_value_id != null) {
        price = double.tryParse(cartItem.variant_value_id.price);
      } else {
        price = double.tryParse(cartItem.product_id.sale_price);
      }
    }
    return Utility.currencyFormat(price);
  }

  static getOrderItemPrice(OrderDetail orderDetail) {
    double price = 0;
    if (orderDetail != null) {
      if (orderDetail.variant_value_id != null) {
        price = double.tryParse(orderDetail.variant_value_id.price);
      } else {
        price = double.tryParse(orderDetail.product_id.sale_price);
      }
    }
    return Utility.currencyFormat(price);
  }

  static addressFormatter(defaultAddress) {
    if (defaultAddress is Address)
      return "${defaultAddress.floor_flat}," +
          "${defaultAddress.building}, ${defaultAddress.address}";
    return "";
  }

  static String capitalize(String string) {
    if (string.isEmpty) {
      return string;
    }

    return string[0].toUpperCase() + string.substring(1);
  }
}
