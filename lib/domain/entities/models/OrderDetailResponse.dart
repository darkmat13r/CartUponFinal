import 'package:coupon_app/domain/entities/models/OrderDetail.dart';
import 'package:coupon_app/domain/entities/models/Rating.dart';

class OrderDetailResponse {
    OrderDetail orderDetail;
    Rating rating;

    OrderDetailResponse({this.orderDetail, this.rating});

    factory OrderDetailResponse.fromJson(Map<String, dynamic> json) {
        return OrderDetailResponse(
            orderDetail: json['orderDetail'] != null ? OrderDetail.fromJson(json['orderDetail']) : null,
            rating: json['rating'] != null ? Rating.fromJson(json['rating']) : null,
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        if (this.orderDetail != null) {
            data['orderDetail'] = this.orderDetail.toJson();
        }
        if (this.rating != null) {
            data['rating'] = this.rating.toJson();
        }
        return data;
    }
}