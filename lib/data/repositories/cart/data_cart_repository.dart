import 'package:coupon_app/app/components/cart_item.dart';
import 'package:coupon_app/app/utils/config.dart';
import 'package:coupon_app/data/utils/constants.dart';
import 'package:coupon_app/data/utils/database_helper.dart';
import 'package:coupon_app/data/utils/http_helper.dart';
import 'package:coupon_app/domain/entities/Cart.dart';
import 'package:coupon_app/domain/entities/models/CartItem.dart';
import 'package:coupon_app/domain/entities/models/ProductDetail.dart';
import 'package:coupon_app/domain/entities/models/ProductVariantValue.dart';
import 'package:coupon_app/domain/entities/models/Token.dart';
import 'package:coupon_app/domain/mapper/cart_item_mapper.dart';
import 'package:coupon_app/domain/repositories/cart/cart_repository.dart';
import 'package:coupon_app/domain/utils/session_helper.dart';
import 'package:sqflite/sqflite.dart';
import 'package:logging/logging.dart';

class DataCartRepository extends CartRepository {
  static DataCartRepository _instance = DataCartRepository._internal();

  Logger _logger;

  DataCartRepository._internal() {
    _logger = Logger("DataCartRepository");
  }

  factory DataCartRepository() => _instance;

  @override
  Future<CartItem> updateQuantity(int cartId, int qty) async {
    try {
      print("----------qty ${qty}");
      Map<String, dynamic> cart = await HttpHelper.invokeHttp(
          "${Constants.cartRoute}${cartId}/", RequestType.patch,
          body: {
            "qty": (qty ?? 1).toString(),
            "lang" : Config().getLanguageId().toString()
          });
      CartItem cartItem = CartItem.fromJson(cart);
      return cartItem;
    } catch (e) {
      _logger.finest(e);
      rethrow;
    }
  }

  @override
  Future<CartItem> addToCart(String productId, String variantValueId,
      {int qty}) async {
    try {
      String userId = await SessionHelper().getUserId();
      Map<String, dynamic> cart = await HttpHelper.invokeHttp(
          Constants.cartRoute, RequestType.post,
          body: {
            "user_id": userId,
            "product_id": productId,
            "qty": (qty ?? 1).toString(),
            "variant_value_id": variantValueId
          });
      CartItem cartItem = CartItem.fromJson(cart);
      return cartItem;
    } catch (e) {
      _logger.finest(e);
      rethrow;
    }
  }

  @override
  Future<Cart> getCart() async {
    try {
      String userId = await SessionHelper().getUserId();
      var url = Constants.createUriWithParams(
          Constants.cartGetRoute, {"user_id": userId,
        "lang" : Config().getLanguageId().toString()});
      dynamic items = await HttpHelper.invokeHttp(url, RequestType.get);
      var cart = Cart.fromJson(items);
      return cart;
    } catch (e) {
      _logger.finest(e);
      rethrow;
    }
  }

  @override
  Future<void> remove(CartItem cartItem) async {
    try {
     await HttpHelper.invokeHttp(
          "${Constants.cartRoute}${cartItem.id}/", RequestType.delete);
    } catch (e) {
      _logger.finest(e);
      rethrow;
    }
  }

  @override
  Future<CartItem> findItem(int id, String type) async {
    final Database db = await DatabaseHelper().getDatabase();
    List<Map<String, dynamic>> cartItems = await db
        .query("cart_items", where: "id=? AND type=?", whereArgs: [id, type]);
    if (cartItems.length == 0) {
      return null;
    }
    return cartItems.map((e) => CartItemMapper.createFromMap(e)).first;
  }

  @override
  Future<int> getQuantity() async {
    final Database db = await DatabaseHelper().getDatabase();
    return Sqflite.firstIntValue(
        await db.rawQuery('SELECT SUM(quantity) as quantity FROM cart_items'));
  }
}
