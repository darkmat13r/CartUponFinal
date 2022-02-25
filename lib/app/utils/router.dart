import 'package:coupon_app/app/pages/account/address/add/add_address_view.dart';
import 'package:coupon_app/app/pages/account/address/addresses_view.dart';
import 'package:coupon_app/app/pages/account/change_password/change_password_view.dart';
import 'package:coupon_app/app/pages/cart/cart_view.dart';
import 'package:coupon_app/app/pages/cart/cart_with_toolbar.dart';
import 'package:coupon_app/app/pages/checkout/checkout_view.dart';
import 'package:coupon_app/app/pages/contact/contact_us_view.dart';
import 'package:coupon_app/app/pages/filters/filter_view.dart';
import 'package:coupon_app/app/pages/forgot_password/forgot_password_view.dart';
import 'package:coupon_app/app/pages/home/home_view.dart';
import 'package:coupon_app/app/pages/main/main_view.dart';
import 'package:coupon_app/app/pages/order/order_view.dart';
import 'package:coupon_app/app/pages/orders/tab/orders_tabbed_view.dart';
import 'package:coupon_app/app/pages/orders/orders_view.dart';
import 'package:coupon_app/app/pages/otp/request/request_otp_view.dart';
import 'package:coupon_app/app/pages/otp/verify/verify_otp_view.dart';
import 'package:coupon_app/app/pages/payment/payment_view.dart';
import 'package:coupon_app/app/pages/product/product_view.dart';
import 'package:coupon_app/app/pages/profile/profile_view.dart';
import 'package:coupon_app/app/pages/register/register_view.dart';
import 'package:coupon_app/app/pages/reviews/create/create_review_view.dart';
import 'package:coupon_app/app/pages/reviews/reviews_view.dart';
import 'package:coupon_app/app/pages/search/search_view.dart';
import 'package:coupon_app/app/pages/setting/settings_view.dart';
import 'package:coupon_app/app/pages/splash/splash_view.dart';
import 'package:coupon_app/app/pages/wallet/add/add_to_wallet_view.dart';
import 'package:coupon_app/app/pages/wallet/wallet_view.dart';
import 'package:coupon_app/app/pages/welcome/welcome_view.dart';
import 'package:coupon_app/app/pages/whishlist/whishlist_view.dart';
import 'package:coupon_app/domain/entities/models/Address.dart';
import 'package:coupon_app/domain/entities/models/CategoryType.dart';
import 'package:coupon_app/domain/entities/models/Order.dart';
import 'package:coupon_app/domain/entities/models/OrderDetail.dart';
import 'package:coupon_app/domain/entities/models/ProductDetail.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:coupon_app/app/pages/login/login_view.dart';
import 'package:coupon_app/app/pages/pages.dart';
import 'package:logger/logger.dart';

class AppRouter {
  final RouteObserver<PageRoute> routeObserver;

  AppRouter() : routeObserver = RouteObserver<PageRoute>();

  Route<dynamic> getRoute(RouteSettings settings) {
    switch (settings.name) {
      case Pages.splash:
        return buildRoute(settings, SplashPage());
      case Pages.login:
        return buildRoute(settings, LoginPage());
      case Pages.forgotPassword:
        return buildRoute(settings, ForgotPasswordPage());
      case Pages.register:
        return buildRoute(settings, RegisterPage());
      case Pages.home:
        return buildRoute(settings, HomePage());
      case Pages.whishlist:
        return buildRoute(settings, WhishlistPage());

      case Pages.main:
        return buildRoute(settings, MainPage());
      case Pages.profile:
        return buildRoute(settings, ProfilePage());
      case Pages.orders:
        return buildRoute(settings, OrdersTabbedPage());
      case Pages.order:
        return buildRoute(settings, OrderPage());
      case Pages.reviews:
        return buildRoute(settings, ReviewsPage());
      case Pages.search:
        return buildRoute(settings, SearchPage());
      case Pages.filter:
        return buildRoute(settings, FilterPage());
      case Pages.changePassword:
        return buildRoute(settings, ChangePasswordPage());
      case Pages.addresses:
        return buildRoute(settings, AddressesPage());
      case Pages.addAddress:
        return buildRoute(settings, AddAddressPage());
      case Pages.cart:
        return buildRoute(settings, CartWithToolbarPage());
      case Pages.welcome:
        return buildRoute(settings, WelcomePage());
      case Pages.checkout:
        return buildRoute(settings, CheckoutPage());
      case Pages.addMoneyToWallet :
        return buildRoute(settings, AddToWalletPage());
      case Pages.wallet :
        return buildRoute(settings, WalletPage());
      case Pages.settings :
        return buildRoute(settings, SettingsPage());
      case Pages.requestOtp :
        return buildRoute(settings, RequestOtpPage());
      case Pages.contactUs :
        return buildRoute(settings, ContactUsPage());

    }
  }
  Future<dynamic> orderDetails(BuildContext context, OrderDetail order) {
    return Navigator.of(context)
        .push(buildRoute(RouteSettings(), OrderPage(order: order,)));
  }
  Future<dynamic> orderDetailsById(BuildContext context, String orderId) {
    return Navigator.of(context)
        .push(buildRoute(RouteSettings(), OrderPage(orderId: orderId,)));
  }
  productDetails(BuildContext context, ProductDetail product) {
    Navigator.of(context)
        .push(buildRoute(RouteSettings(), ProductPage(productId : product.id.toString())));
  }
  productDetailsById(BuildContext context, String productId) {
    Navigator.of(context)
        .push(buildRoute(RouteSettings(), ProductPage(productId : productId)));
  }
  productDetailsBySlug(BuildContext context, String productId) {
    Navigator.of(context)
        .push(buildRoute(RouteSettings(), ProductPage(slug : productId)));
  }
  Future<dynamic> payment(BuildContext context, String paymentUrl, {bool isWallet }) {
    return Navigator.of(context).push(buildRoute(RouteSettings(), PaymentPage(paymentUrl, wallet: isWallet,)));
  }
  categorySearch(BuildContext context, CategoryType category) {
    Navigator.of(context).push(buildRoute(
        RouteSettings(),
        SearchPage(
          category: category,
        )));
  }
  verifyOtp(BuildContext context, String countryCode,int countryId, String mobileNumber,{ bool returnResult}) {
   return Navigator.of(context).push(buildRoute(
        RouteSettings(),
        VerifyOtpPage(
          countryCode,countryId, mobileNumber,returnResult: returnResult,
        )));
  }
  querySearch(BuildContext context, String query) {
    Navigator.of(context).push(buildRoute(
        RouteSettings(),
        SearchPage(
          query: query,
        )));
  }
  editAddress(BuildContext context, Address address) {
    Navigator.of(context).push(buildRoute(
        RouteSettings(),
        AddAddressPage(
          address: address,
        )));
  }
  categorySearchById(BuildContext context, String categoryId) {
    Navigator.of(context).push(buildRoute(
        RouteSettings(),
        SearchPage(
          categoryId: categoryId,
        )));
  }

  MaterialPageRoute buildRoute(RouteSettings settings, Widget builder) {
    return new MaterialPageRoute(settings: settings, builder: (ctx) => builder);
  }

   signup(BuildContext context, String countryCode,int countryId, String mobileNumber,{bool returnResult}) {
   return Navigator.of(context).push(buildRoute(
        RouteSettings(),
        RegisterPage(
          countryCode: countryCode,
          mobileNumber: mobileNumber,
          returnResult: returnResult, countryId: countryId,
        )));
  }
}
