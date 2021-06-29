import 'package:coupon_app/domain/entities/models/Customer.dart';
import 'package:coupon_app/domain/entities/models/Order.dart';
import 'package:coupon_app/domain/entities/models/Token.dart';
import 'package:coupon_app/domain/entities/models/WalletTransaction.dart';

class WalletHistoryResponse {
    Customer customer;
    List<WalletTransaction> walletData;
    List<Order> walletUsed;

    WalletHistoryResponse({this.customer, this.walletData, this.walletUsed});

    factory WalletHistoryResponse.fromJson(Map<String, dynamic> json) {
        return WalletHistoryResponse(
            customer: json['customer'] != null ? Customer.fromJson(json['customer']) : null,
            walletData: json['walletData'] != null ? (json['walletData'] as List).map((i) => WalletTransaction.fromJson(i)).toList() : null,
            walletUsed: json['walletUsed'] != null ? (json['walletUsed'] as List).map((i) => Order.fromJson(i)).toList() : null,
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        if (this.customer != null) {
            data['customer'] = this.customer.toJson();
        }
        if (this.walletData != null) {
            data['walletData'] = this.walletData.map((v) => v.toJson()).toList();
        }
        if (this.walletUsed != null) {
            data['walletUsed'] = this.walletUsed.map((v) => v.toJson()).toList();
        }
        return data;
    }
}