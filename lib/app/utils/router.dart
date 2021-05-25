import 'package:coupon_app/app/pages/account/address/add/add_address_view.dart';
import 'package:coupon_app/app/pages/account/address/addresses_view.dart';
import 'package:coupon_app/app/pages/account/change_password/change_password_view.dart';
import 'package:coupon_app/app/pages/cart/cart_view.dart';
import 'package:coupon_app/app/pages/cart/checkout.dart';
import 'package:coupon_app/app/pages/filters/filter_view.dart';
import 'package:coupon_app/app/pages/forgot_password/forgot_password_view.dart';
import 'package:coupon_app/app/pages/home/home_view.dart';
import 'package:coupon_app/app/pages/main/main_view.dart';
import 'package:coupon_app/app/pages/order/order_view.dart';
import 'package:coupon_app/app/pages/orders/orders_view.dart';
import 'package:coupon_app/app/pages/product/product_view.dart';
import 'package:coupon_app/app/pages/profile/profile_view.dart';
import 'package:coupon_app/app/pages/register/register_view.dart';
import 'package:coupon_app/app/pages/reviews/create/create_review_view.dart';
import 'package:coupon_app/app/pages/reviews/reviews_view.dart';
import 'package:coupon_app/app/pages/search/search_view.dart';
import 'package:coupon_app/app/pages/setting/settings_view.dart';
import 'package:coupon_app/app/pages/welcome/welcome_view.dart';
import 'package:coupon_app/app/pages/whishlist/whishlist_view.dart';
import 'package:coupon_app/domain/entities/models/Address.dart';
import 'package:coupon_app/domain/entities/models/CategoryType.dart';
import 'package:coupon_app/domain/entities/models/ProductDetail.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:coupon_app/app/pages/login/login_view.dart';
import 'package:coupon_app/app/pages/pages.dart';

class AppRouter {
  final RouteObserver<PageRoute> routeObserver;

  AppRouter() : routeObserver = RouteObserver<PageRoute>();

  Route<dynamic> getRoute(RouteSettings settings) {
    switch (settings.name) {
      case Pages.login:
        return _buildRoute(settings, LoginPage());
      case Pages.forgotPassword:
        return _buildRoute(settings, ForgotPasswordPage());
      case Pages.register:
        return _buildRoute(settings, RegisterPage());
      case Pages.home:
        return _buildRoute(settings, HomePage());
      case Pages.whishlist:
        return _buildRoute(settings, WhishlistPage());

      case Pages.main:
        return _buildRoute(settings, MainPage());
      case Pages.profile:
        return _buildRoute(settings, ProfilePage());
      case Pages.orders:
        return _buildRoute(settings, OrdersPage());
      case Pages.order:
        return _buildRoute(settings, OrderPage());
      case Pages.reviews:
        return _buildRoute(settings, ReviewsPage());
      case Pages.createReview:
        return _buildRoute(settings, CreateReviewPage());
      case Pages.search:
        return _buildRoute(settings, SearchPage());
      case Pages.filter:
        return _buildRoute(settings, FilterPage());
      case Pages.changePassword:
        return _buildRoute(settings, ChangePasswordPage());
      case Pages.addresses:
        return _buildRoute(settings, AddressesPage());
      case Pages.addAddress:
        return _buildRoute(settings, AddAddressPage());
      case Pages.cart:
        return _buildRoute(settings, CheckoutPage());
      case Pages.welcome:
        return _buildRoute(settings, WelcomePage());
      case Pages.checkout:
        return _buildRoute(settings, CheckoutPage());
      case Pages.settings :
        return _buildRoute(settings, SettingsPage());
    }
  }

  productDetails(BuildContext context, ProductDetail product) {
    Navigator.of(context)
        .push(_buildRoute(RouteSettings(), ProductPage(product.id)));
  }
  productDetailsById(BuildContext context, int productId) {
    Navigator.of(context)
        .push(_buildRoute(RouteSettings(), ProductPage(productId)));
  }
  categorySearch(BuildContext context, CategoryType category) {
    Navigator.of(context).push(_buildRoute(
        RouteSettings(),
        SearchPage(
          category: category,
        )));
  }
  querySearch(BuildContext context, String query) {
    Navigator.of(context).push(_buildRoute(
        RouteSettings(),
        SearchPage(
          query: query,
        )));
  }
  editAddress(BuildContext context, Address address) {
    Navigator.of(context).push(_buildRoute(
        RouteSettings(),
        AddAddressPage(
          address: address,
        )));
  }
  categorySearchById(BuildContext context, String categoryId) {
    Navigator.of(context).push(_buildRoute(
        RouteSettings(),
        SearchPage(
          categoryId: categoryId,
        )));
  }

  MaterialPageRoute _buildRoute(RouteSettings settings, Widget builder) {
    return new MaterialPageRoute(settings: settings, builder: (ctx) => builder);
  }
}
