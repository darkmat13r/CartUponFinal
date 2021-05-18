import 'package:coupon_app/app/components/cart_button.dart';
import 'package:coupon_app/app/components/navigation_drawer.dart';
import 'package:coupon_app/app/pages/account/account_view.dart';
import 'package:coupon_app/app/pages/cart/cart_view.dart';
import 'package:coupon_app/app/pages/explore/explore_view.dart';
import 'package:coupon_app/app/pages/home/home_view.dart';
import 'package:coupon_app/app/pages/main/main_controller.dart';
import 'package:coupon_app/app/pages/pages.dart';
import 'package:coupon_app/app/pages/whishlist/whishlist_view.dart';
import 'package:coupon_app/app/utils/constants.dart';
import 'package:coupon_app/app/utils/router.dart';
import 'package:coupon_app/data/repositories/data_authentication_repository.dart';
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
  MainPageView() : super(MainController(DataAuthenticationRepository()));

  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  List<Widget> _widgetOptions = <Widget>[
    HomePage(),
    ExplorePage(),
    AccountPage(),
    WhishlistPage(),
    CartPage(),
  ];

  void _onItemTapped(int index, MainController controller) {
    setState(() {
      controller.selectedIndex = index;
      if (index == 2) {
        if (controller.currentUser == null) {
          controller.selectedIndex = 0;
          Navigator.of(context).pushNamed(Pages.welcome);
        }
      }
    });
  }

  GlobalKey<ScaffoldState> _drawerKey = GlobalKey();
  bool _isSearching = false;
  String searchQuery = null;
  TextEditingController _searchQuery = TextEditingController();

  get _appBar => AppBar(
        title: _isSearching
            ? _buildSearchField()
            : SizedBox(
                height: 40,
                child: Image.asset(
                  Resources.toolbarLogo2,
                  fit: BoxFit.fitHeight,
                ),
              ),
        actions: _buildActions(),
      );

  void _startSearch() {
    print("open search box");
    ModalRoute
        .of(context)
        .addLocalHistoryEntry(new LocalHistoryEntry(onRemove: _stopSearching));

    setState(() {
      _isSearching = true;
    });
  }
  Widget _buildSearchField() {
    return  ControlledWidgetBuilder(builder: (BuildContext context, MainController controller){
      return TextField(
        controller: _searchQuery,
        autofocus: true,
        textInputAction: TextInputAction.search,
        onSubmitted: (value){
          String query = value;
          setState(() {
            _stopSearching();
          });
          controller.startSearch(_drawerKey, query);
        },
        decoration: const InputDecoration(
          hintText: 'Search...',
          border: InputBorder.none,
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          hintStyle: const TextStyle(color: AppColors.neutralGray),
        ),
        style: const TextStyle(color: AppColors.neutralDark, fontSize: 16.0),
        onChanged: updateSearchQuery,
      );
    });
  }
  void _stopSearching() {
    _clearSearchQuery();

    setState(() {
      _isSearching = false;
    });
  }
  void updateSearchQuery(String newQuery) {

    setState(() {
      searchQuery = newQuery;
    });
    print("search query " + newQuery);

  }
  void _clearSearchQuery() {
    print("close search box");
    setState(() {
      _searchQuery.clear();
      updateSearchQuery("Search query");
    });
  }
  _buildActions() {
    if (_isSearching) {
      return <Widget>[
        new IconButton(
          icon: const Icon(Icons.clear),
          onPressed: () {
            if (_searchQuery == null || _searchQuery.text.isEmpty) {
              Navigator.pop(context);
              return;
            }
            _clearSearchQuery();
          },
        ),
      ];
    }
    return [
      IconButton(
        icon: Icon(MaterialIcons.search),
        onPressed: _startSearch,
      ),
      CartButton(),
      IconButton(
        icon: Icon(MaterialIcons.menu),
        onPressed: () {
          setState(() {
            _openEndDrawer();
          });
        },
      )
    ];
  }

  void _openEndDrawer() {
    _drawerKey.currentState.openEndDrawer();
  }

  @override
  Widget get view => Scaffold(
        appBar: _appBar,
        key: _drawerKey,
        body: _body,
        endDrawer: ControlledWidgetBuilder(
          builder: (BuildContext ctx, MainController controller) {
            return NavigationDrawer(controller.currentUser != null
                ? controller.currentUser.user
                : null);
          },
        ),
        bottomNavigationBar: _bottomNavigation,
      );

  get _bottomNavigation => ControlledWidgetBuilder(
          builder: (BuildContext context, MainController controller) {
        return Container(
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
            currentIndex: controller.selectedIndex,
            onTap: (index) {
              _onItemTapped(index, controller);
            },
          ),
        );
      });

  get _body => ControlledWidgetBuilder(
          builder: (BuildContext ctx, MainController controller) {
        return Center(
          child: _widgetOptions[controller.selectedIndex],
        );
      });


}
