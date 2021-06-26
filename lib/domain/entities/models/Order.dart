import 'package:coupon_app/domain/entities/models/Address.dart';
import 'package:coupon_app/domain/entities/models/OrderDetail.dart';

class Order {
    Address billing_address;
    String created_at;
    int id;
    List<OrderDetail> order_details;
    String order_no;
    String pay_mode;
    String pay_status;
    String payment_id;
    String ref;
    Address shipping_address;
    String shipping_total;
    String status;
    String total;
    String track_id;
    String tran_id;
    String updated_at;
    int user_id;

    Order({this.billing_address, this.created_at, this.id, this.order_details, this.order_no, this.pay_mode, this.pay_status, this.payment_id, this.ref, this.shipping_address, this.shipping_total, this.status, this.total, this.track_id, this.tran_id, this.updated_at, this.user_id});

    factory Order.fromJson(Map<String, dynamic> json) {
        return Order(
            billing_address: json['billing_address'] != null && json['billing_address'] is Map? Address.fromJson(json['billing_address']) : null,
            created_at: json['created_at'], 
            id: json['id'], 
            order_details: json['order_details'] != null ? (json['order_details'] as List).map((i) => OrderDetail.fromJson(i)).toList() : null, 
            order_no: json['order_no'], 
            pay_mode: json['pay_mode'], 
            pay_status: json['pay_status'], 
            payment_id: json['payment_id'] != null ? json['payment_id'] : null,
            ref: json['ref'] != null ? json['ref'] : null,
            shipping_address: json['shipping_address'] != null  && json['billing_address'] is Map ? Address.fromJson(json['shipping_address']) : null,
            shipping_total: json['shipping_total'], 
            status: json['status'], 
            total: json['total'], 
            track_id: json['track_id'] != null ? json['track_id'] : null,
            tran_id: json['tran_id'] != null ? json['track_id'] : null,
            updated_at: json['updated_at'], 
            user_id: json['user_id'], 
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['created_at'] = this.created_at;
        data['id'] = this.id;
        data['order_no'] = this.order_no;
        data['pay_mode'] = this.pay_mode;
        data['pay_status'] = this.pay_status;
        data['shipping_total'] = this.shipping_total;
        data['status'] = this.status;
        data['total'] = this.total;
        data['updated_at'] = this.updated_at;
        data['user_id'] = this.user_id;
        if (this.billing_address != null) {
            data['billing_address'] = this.billing_address.toJson();
        }
        if (this.order_details != null) {
            data['order_details'] = this.order_details.map((v) => v.toJson()).toList();
        }
        if (this.payment_id != null) {
            data['payment_id'] = this.payment_id;
        }
        if (this.ref != null) {
            data['ref'] = this.ref;
        }
        if (this.shipping_address != null) {
            data['shipping_address'] = this.shipping_address.toJson();
        }
        if (this.track_id != null) {
            data['track_id'] = this.track_id;
        }
        if (this.tran_id != null) {
            data['tran_id'] = this.tran_id;
        }
        return data;
    }
}