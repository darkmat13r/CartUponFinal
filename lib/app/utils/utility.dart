import 'package:coupon_app/app/utils/config.dart';
import 'package:coupon_app/app/utils/locale_keys.dart';
import 'package:coupon_app/domain/entities/models/Address.dart';
import 'package:coupon_app/domain/entities/models/CartItem.dart';
import 'package:coupon_app/domain/entities/models/Country.dart';
import 'package:coupon_app/domain/entities/models/OrderDetail.dart';
import 'package:coupon_app/domain/entities/models/Product.dart';
import 'package:coupon_app/domain/entities/models/ProductDetail.dart';
import 'package:coupon_app/domain/entities/models/ProductVariantValue.dart';
import 'package:logger/logger.dart';

class Utility {
  static String currencyFormat(dynamic price) {
    if(price == null){
      return "";
    }
    String symbol = "KD";
    try{
      Country selectedCountry = Config().selectedCountry;
      if(selectedCountry != null){
        symbol = selectedCountry.country_currency_symbol ?? "KD";
      }
    }catch(e){

    }
    try{
      if (price is String){
        var convertedPrice = double.tryParse(price);
        return NumberFormat.currency(symbol: symbol).format(convertedPrice);
      }
      return NumberFormat.currency(symbol: symbol).format(price);
    }catch(e){
      Logger().e("NumberFormatException ${price} ${e}");
    }
    return NumberFormat.currency(symbol: symbol).format(0);
  }



  static getOrderItemPrice(Product product, ProductVariantValue variantValue) {
    double price = 0;
    if (product != null) {
      if (variantValue != null) {
        price = double.tryParse(variantValue.price);
      } else {
        price = double.tryParse(product.price);
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

  static bool checkOfferPrice(Product product, bool showTimer,{ ProductVariantValue variantValue}) {
    var originalPrice = double.parse(product.price ?? "0.0");
    var salePrice = product.sale_price != null ?  double.parse(product.sale_price ?? "0.0") : 0;
    var offerPrice = product.offer_price != null ? double.parse(product.offer_price) :  0.00;
    double price = 0;
    var variantOffer =  double.tryParse(product.getOfferPriceByVariant(variantValue));
    return product != null && product.price != null &&
        originalPrice > (showTimer && offerPrice > 0 ? variantOffer : salePrice);
  }
}
