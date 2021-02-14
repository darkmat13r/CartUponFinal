import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

class FilterController extends Controller{
  RangeValues currentPriceRangeValues = const RangeValues(50, 80);

  double minPrice = 0;
  double maxPrice = 100;

  TextEditingController minPriceController;
  TextEditingController maxPriceController;

  FilterController(){
    minPriceController = TextEditingController();
    maxPriceController = TextEditingController();
  }

  @override
  void initListeners() {
    refreshUI();
  }

  void onPriceRangeChanged(RangeValues values){
    currentPriceRangeValues = values;
    minPriceController.text = "\$ ${values.start}";
    maxPriceController.text = "\$ ${values.end}";
    refreshUI();
  }

  void applyFilter() {
    Navigator.of(getContext()).pop();
  }

}