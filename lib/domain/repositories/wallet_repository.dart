import 'package:coupon_app/domain/entities/models/PaymentOrder.dart';
import 'package:coupon_app/domain/entities/models/WalletHistoryResponse.dart';
import 'package:coupon_app/domain/entities/models/WalletTransaction.dart';

abstract class WalletRepository{
  Future<PlaceOrderResponse> addMoneyToWallet(String amount);
  Future<WalletHistoryResponse> walletHistory();
}