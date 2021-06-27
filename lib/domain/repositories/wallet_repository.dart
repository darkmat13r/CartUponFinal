import 'package:coupon_app/domain/entities/models/PaymentOrder.dart';

abstract class WalletRepository{
  Future<PlaceOrderResponse> addMoneyToWallet(String amount);
}