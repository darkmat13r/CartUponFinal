import 'package:coupon_app/app/utils/config.dart';
import 'package:coupon_app/app/utils/locale_keys.dart';
import 'package:coupon_app/data/utils/constants.dart';
import 'package:coupon_app/data/utils/http_helper.dart';
import 'package:coupon_app/domain/entities/models/Product.dart';
import 'package:coupon_app/domain/entities/models/ProductDetail.dart';
import 'package:coupon_app/domain/entities/models/ProductWithRelated.dart';
import 'package:coupon_app/domain/repositories/product_repository.dart';
import 'package:coupon_app/domain/utils/session_helper.dart';
import 'package:logger/logger.dart';

class DataProductRepository extends ProductRepository {
  Logger _logger;

  static DataProductRepository _instance = DataProductRepository._internal();

  DataProductRepository._internal() {
    _logger = Logger();
  }

  factory DataProductRepository() => _instance;

  @override
  Future<List<ProductDetail>> getProducts(
      {String categoryId, String type, String filterBy}) async {
    try {
      var params = {
        'lang': Config().getLanguageId().toString(),
        'country': (await SessionHelper().getSelectedCountryId()).toString()
      };
      if (filterBy != null) {
        params['sort'] = filterBy;
      }
      if (categoryId != null) {
        params['category_id'] = categoryId;
      }
      if (type != null) {
        params['category_type'] = type;
      }
      var uri = Constants.createUriWithParams(Constants.productsRoute, params);
      List<dynamic> data = await HttpHelper.invokeHttp(uri, RequestType.get);
      dynamic response = data.map((e) => ProductDetail.fromJson(e)).toList();
      return response;
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  @override
  Future<ProductDetail> getById(String productId) async {
    try {
      Map<String, dynamic> data = await HttpHelper.invokeHttp(
          "${Constants.productsRoute}$productId", RequestType.get);
      ProductDetail product = ProductDetail.fromJson(data);
      return product;
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  @override
  Future<List<ProductDetail>> search({String query, String filterBy}) async {
    try {
      var params = {
        'lang': Config().getLanguageId().toString(),
        'status' : 'true',
        'active' : 'true',
        'country': (await SessionHelper().getSelectedCountryId()).toString()
      };
      if (query != null) {
        params['search'] = query;
      }
      if (filterBy != null) {
        params['sort'] = filterBy;
      }
      var uri = Constants.createUriWithParams(Constants.searchRoute, params);
      List<dynamic> data = await HttpHelper.invokeHttp(uri, RequestType.get);
      dynamic response = data.map((e) => ProductDetail.fromJson(e)).toList();
      return response;
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  @override
  Future<ProductWithRelated> getProductWithRelated(String slug) async {
    try {
      var params = {
        'lang': Config().getLanguageId().toString(),
        'country': (await SessionHelper().getSelectedCountryId()).toString()
      };
      var id = int.tryParse(slug);
      if (id != null) {
        params['id'] = slug;
      } else {
        params['slug'] = slug;
      }
      var uri = Constants.createUriWithParams(
          "${Constants.productDetailRoute}", params);
      Map<String, dynamic> data =
          await HttpHelper.invokeHttp(uri, RequestType.get);
      dynamic response = ProductWithRelated.fromJson(data);
      return response;
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  @override
  Future postReview({int orderId, int rating, String review}) async {
    try {
      var params = {
        'orderdetail': orderId.toString(),
        'rating': (rating ?? 1).toString(),
        'review': review.toString()
      };
      dynamic data = await HttpHelper.invokeHttp(
          Constants.ratingRoute, RequestType.post,
          body: params);

      return data;
    } catch (e) {
      print(e);
      rethrow;
    }
  }
}
