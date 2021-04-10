import 'package:coupon_app/domain/entities/models/Product.dart';
import 'package:coupon_app/domain/entities/models/ProductVariantValue.dart';

class WhishlistItem {
  int id;
  int is_type;
  Product product_id;
  int qty;
  int user_id;
  ProductVariantValue variant_value_id;

  WhishlistItem({this.id, this.is_type, this.product_id, this.qty, this.user_id, this.variant_value_id});

  factory WhishlistItem.fromJson(Map<String, dynamic> json) {
    return WhishlistItem(
      id: json['id'],
      is_type: json['is_type'],
      product_id: json['product_id'] is Map ? Product.fromJson(json['product_id']) : null,
      qty: json['qty'],
      user_id: json['user_id'],
      variant_value_id: (json['variant_value_id'] is Map) ? ProductVariantValue.fromJson(json['variant_value_id']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['is_type'] = this.is_type;
    data['product_id'] = this.product_id;
    data['qty'] = this.qty;
    data['user_id'] = this.user_id;
    data['variant_value_id'] = this.variant_value_id;
    return data;
  }
}