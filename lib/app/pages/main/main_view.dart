import 'package:coupon_app/app/pages/account/account_view.dart';
import 'package:coupon_app/app/pages/cart/cart_view.dart';
import 'package:coupon_app/app/pages/explore/explore_view.dart';
import 'package:coupon_app/app/pages/home/home_view.dart';
import 'package:coupon_app/app/pages/main/main_controller.dart';
import 'package:coupon_app/app/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:easy_localization/easy_localization.dart';

class MainPage extends View {
  @override
  State<StatefulWidget> createState() => MainPageView();
}

class MainPageView extends ViewState<MainPage, MainController> {
  MainPageView() : super(MainController());
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  List<Widget> _widgetOptions = <Widget>[
    HomePage(),
    ExplorePage(),
    AccountPage(),
    CartPage(),
    CartPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  get _appBar => AppBar(
    title: SizedBox(
      width: 120,
      child: Image.asset(Resources.toolbarLogo, fit: BoxFit.fitHeight,),
    ),
    actions: [
      IconButton(
        icon: Icon(MaterialIcons.search), onPressed: () {  },
      ),
      IconButton(
        icon: Icon(MaterialIcons.shopping_cart), onPressed: () {  },
      )
    ],
  );

  @override
  Widget get view => Scaffold(
        appBar: _appBar,
        key: globalKey,
        body: _body,
        bottomNavigationBar: _bottomNavigation,
      );

  get _bottomNavigation => Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: AppColors.neutralGray,
            ),
          ],
        ),
        child: BottomNavigationBar(
          backgroundColor: Colors.white,
          elevation: 0,
          showUnselectedLabels: true,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(MaterialIcons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
                icon: Icon(MaterialIcons.dashboard),
                label: 'Categories',
                backgroundColor: Colors.white),
            BottomNavigationBarItem(
              icon: Stack(
                children: [
                  Icon(MaterialIcons.account_circle),
                ],
              ),
              label: 'Profile',
            ),
            BottomNavigationBarItem(
              icon: Icon(MaterialCommunityIcons.gift),
              label: 'Wishlist',
            ),
            BottomNavigationBarItem(
              icon: Icon(MaterialCommunityIcons.cart),
              label: 'Cart',
            ),
          ],
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
        ),
      );

  get _body => Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      );
}
