import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

abstract class BaseController extends Controller{
  bool isLoading = false;


  showLoading(){
    isLoading = true;
    refreshUI();
  }


  dismissLoading(){
    isLoading = false;
    refreshUI();
  }


  handlerUnknownError( e){
    if(e.stacktrace != null){
      print(e.stacktrace);
    }else{
      print(e);
    }
  }
}