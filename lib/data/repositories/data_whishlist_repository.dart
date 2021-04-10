import 'package:coupon_app/app/utils/config.dart';
import 'package:coupon_app/data/utils/constants.dart';
import 'package:coupon_app/data/utils/http_helper.dart';
import 'package:coupon_app/domain/entities/models/Product.dart';
import 'package:coupon_app/domain/entities/models/WhishlistItem.dart';
import 'package:coupon_app/domain/repositories/whishlist_repository.dart';
import 'package:coupon_app/domain/utils/session_helper.dart';
import 'package:logging/logging.dart';

class DataWhishlistRepository extends WhishlistRepository {
  static DataWhishlistRepository instance = DataWhishlistRepository._internal();

  Logger _logger;

  DataWhishlistRepository._internal() {
    _logger = Logger("DataWhishlistRepository");
  }

  factory DataWhishlistRepository() => instance;

  @override
  Future<WhishlistItem> addToWhishlist(Product product) async {
    try {

      var token = await SessionHelper().getCurrentUser();
      Map<String, dynamic> response = await HttpHelper.invokeHttp(
          Constants.whishlistRoute, RequestType.post,
          body: {"user": token.user.id.toString(), "product_id": product.id.toString(), "variant_value_id" : ""});
      WhishlistItem item = WhishlistItem.fromJson(response);
      return item;
    } catch (e) {

      _logger.finest("Couldn't add product to whishlist", e);
      rethrow;
    }
  }

  @override
  Future<List<WhishlistItem>> getWhishlist() async {
    try {
      var token = await SessionHelper().getCurrentUser();
      var uri = Constants.createUriWithParams(Constants.whishlistRoute, {
        "user_id": token.user.id.toString(),
        "lang": Config().getLanguageId().toString()
      });
      List<dynamic> response =
          await HttpHelper.invokeHttp(uri, RequestType.get);
      List<WhishlistItem> whishlistItems =
          response.map((e) => WhishlistItem.fromJson(e)).toList();
      return whishlistItems;
    } catch (e) {
      _logger.finest("Couldn't fetch whishlist items", e);
      rethrow;
    }
  }

  @override
  Future<void> remove(WhishlistItem item) async {
    try {
       await HttpHelper.invokeHttp(
          "${Constants.whishlistRoute}${item.id}/", RequestType.delete);
    } catch (e) {
      _logger.finest("Couldn't remove from whishlist", e);
      rethrow;
    }
  }
}
