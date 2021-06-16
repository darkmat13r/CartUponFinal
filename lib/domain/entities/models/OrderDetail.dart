import 'package:coupon_app/domain/entities/models/Product.dart';
import 'package:coupon_app/domain/entities/models/ProductVariantValue.dart';

class OrderDetail {
    String detail_status;
    String discount;
    int id;
    int order_id;
    String price;
    Product product_id;
    int qty;
    ProductVariantValue variant_value_id;

    OrderDetail({this.detail_status, this.discount, this.id, this.order_id, this.price, this.product_id, this.qty, this.variant_value_id});

    factory OrderDetail.fromJson(Map<String, dynamic> json) {
        return OrderDetail(
            detail_status: json['detail_status'], 
            discount: json['discount'], 
            id: json['id'], 
            order_id: json['order_id'], 
            price: json['price'], 
            product_id: json['product_id'] != null ? Product.fromJson(json['product_id']) : null,
            qty: json['qty'], 
            variant_value_id: json['variant_value_id'] != null ? ProductVariantValue.fromJson(json['variant_value_id']) : null,
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['detail_status'] = this.detail_status;
        data['discount'] = this.discount;
        data['id'] = this.id;
        data['order_id'] = this.order_id;
        data['price'] = this.price;
        data['qty'] = this.qty;
        if (this.product_id != null) {
            data['product_id'] = this.product_id.toJson();
        }
        if (this.variant_value_id != null) {
            data['variant_value_id'] = this.variant_value_id.toJson();
        }
        return data;
    }
}