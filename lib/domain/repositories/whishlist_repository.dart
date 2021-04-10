import 'package:coupon_app/domain/entities/models/Product.dart';
import 'package:coupon_app/domain/entities/models/ProductVariantValue.dart';
import 'package:coupon_app/domain/entities/models/WhishlistItem.dart';

abstract class WhishlistRepository{
  Future<List<WhishlistItem>> getWhishlist();
  Future<WhishlistItem> addToWhishlist(Product product);
  Future<void> remove(WhishlistItem item);
}