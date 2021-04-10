import 'package:coupon_app/app/utils/locale_keys.dart';
import 'package:coupon_app/domain/entities/models/CartItem.dart';

class Utility{

  static String currencyFormat(dynamic price){
    if(price is String)
    return NumberFormat.compactCurrency(symbol: "KD").format(double.tryParse(price));
    return NumberFormat.compactCurrency(symbol: "KD").format(price);
  }

  static getCartItemPrice(CartItem cartItem){
    double price = 0;
    if(cartItem != null){
      if(cartItem.variant_value_id != null){
        price = double.tryParse(cartItem.variant_value_id.price);
      }else{
        price = double.tryParse(cartItem.product_id.sale_price);
      }

    }
    return Utility.currencyFormat(price);
  }
}