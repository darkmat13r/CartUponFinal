import 'package:coupon_app/app/base_controller.dart';
import 'package:coupon_app/app/components/cart_button.dart';
import 'package:coupon_app/app/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:provider/provider.dart';
abstract class SearchableViewState<Page extends View, Con extends BaseController> extends ViewState<Page, Con>{
  bool _isSearching = false;
  String searchQuery = null;
  TextEditingController _searchQuery = TextEditingController();

  final Con _controller;
  SearchableViewState(this._controller) : super(_controller);

  Widget get title;

  LabeledGlobalKey<State<StatefulWidget>> get key;

  get _appBar => AppBar(
    title: _isSearching
        ? _buildSearchField()
        : title,
    actions: _buildActions(),
  );

  @override
  Widget get view => ChangeNotifierProvider<Con>.value(value: _controller, child:  Scaffold(
    appBar: _appBar,
    key: key,
    body: body,
  ));

  Widget get body;


  void _startSearch() {
    ModalRoute
        .of(key.currentContext)
        .addLocalHistoryEntry(new LocalHistoryEntry(onRemove: _stopSearching));
    setState(() {
      _isSearching = true;
    });
  }
  Widget _buildSearchField() {
    return TextField(
      controller: _searchQuery,
      autofocus: true,
      textInputAction: TextInputAction.search,
      onSubmitted: (value){
        String query = value;
        setState(() {
          _stopSearching();
        });
        _controller.startSearch(key, query);
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
              Navigator.pop(key.currentContext);
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
    ];
  }



}