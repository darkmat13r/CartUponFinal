import 'package:coupon_app/app/main/main_controller.dart';
import 'package:coupon_app/app/pages/cart/cart_view.dart';
import 'package:coupon_app/app/pages/home/home_view.dart';
import 'package:coupon_app/app/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:easy_localization/easy_localization.dart';

class MainPage extends View{
  @override
  State<StatefulWidget> createState() => MainPageView();

}

class MainPageView extends ViewState<MainPage, MainController>{
  MainPageView() : super(MainController());
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
  TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
    List<Widget> _widgetOptions = <Widget>[
    HomePage(),
    Text(
      'Index 1: Business',
      style: optionStyle,
    ),
    CartPage(),
    Text(
      'Index 2: School',
      style: optionStyle,
    ),
    Text(
      'Index 2: School',
      style: optionStyle,
    ),
    Text(
      'Index 2: School',
      style: optionStyle,
    ),
  ];


  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget get view => Scaffold(
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
      unselectedItemColor: AppColors.neutralGray,

      items:  <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Feather.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Feather.search),
          label: 'Explore',
          backgroundColor: Colors.white
        ),
        BottomNavigationBarItem(
          icon: Stack(children: [
            Icon(Feather.shopping_cart),
            new Positioned(  // draw a red marble
              top: -1.0,
              right: -1.0,
              child: new Icon(Icons.brightness_1, size: 12.0,
                  color: AppColors.error),
            )
          ],),
          label: 'Cart',
        ),
        BottomNavigationBarItem(
          icon: Icon(Feather.tag),
          label: 'Offer',
        ),
        BottomNavigationBarItem(
          icon: Icon(Feather.user),
          label: 'Account',
        ),
      ],
      currentIndex: _selectedIndex,
      selectedItemColor: AppColors.primary,
      onTap: _onItemTapped,
    ),
  );


  get _body => Center(
    child: _widgetOptions.elementAt(_selectedIndex),
  );

}