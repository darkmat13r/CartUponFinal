import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

class FilterController extends Controller{
  RangeValues currentPriceRangeValues = const RangeValues(50, 80);

  double minPrice = 0;
  double maxPrice = 100;

  @override
  void initListeners() {
    refreshUI();
  }

  void onPriceRangeChanged(RangeValues values){

  }

  void applyFilter() {
    Navigator.of(getContext()).pop();
  }

}