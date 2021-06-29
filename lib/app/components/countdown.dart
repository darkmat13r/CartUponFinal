import 'dart:async';

import 'package:coupon_app/app/utils/constants.dart';
import 'package:coupon_app/app/utils/date_helper.dart';
import 'package:flutter/cupertino.dart';

class CountdownView extends StatefulWidget{

  DateTime validFrom;
  DateTime validTo;
  bool showIcon = true;
  TextStyle textStyle;


  CountdownView({this.validFrom, this.validTo, this.showIcon, this.textStyle});

  @override
  State<StatefulWidget> createState() => _CountdownViewState();

}

class _CountdownViewState extends State<CountdownView>{
  Timer _timer;
  String _elapsedTime;

  _CountdownViewState(){

  }

  @override
  Widget build(BuildContext context) {
    _createTimer();
    return _elapsedTime != null
        ? Row(
      children: [
        (widget.showIcon ?? true ) ? Image.asset(
          Resources.timerIcon,
          width: 16,
          height: 16,
          color: AppColors.primary,
        ) : SizedBox(),
        (widget.showIcon ?? true ) ? SizedBox(
          width: Dimens.spacingNormal,
        ) : SizedBox(),
        Text(
          _elapsedTime != null ? _elapsedTime : "",
          style: widget.textStyle ?? bodyTextNormal2.copyWith(
              color: AppColors.primary, fontSize: 12),
        )
      ],
    )
        : SizedBox();
  }

  bool _isValidToValid() {
    var isValid = false;
    if (widget.validFrom == null && widget.validTo == null) {
      return false;
    }
    var validFrom = widget.validFrom;
    var validTo = widget.validTo;
    if (validFrom != null &&
        validTo != null) {
      isValid = validFrom.toUtc().isBefore(validTo.toUtc()) && validTo.toUtc().isAfter(DateTime.now());
    }
    return isValid;
  }

  _createTimer() {
    if(_timer != null ){
      _timer.cancel();
    }
    if (_isValidToValid()) {
      _timer = Timer.periodic(Duration(seconds: 1), (timer) {
        if (mounted) {
          setState(() {
            _elapsedTime = DateHelper.format(
                DateTime.now(), widget.validTo);
          });
        } else {
          _timer.cancel();
        }
      });
    }
  }
  @override
  void dispose() {
    if (_timer != null) {
      _timer.cancel();
    }
    super.dispose();
  }
  @override
  void deactivate() {
    if (_timer != null) {
      _timer.cancel();
    }
    super.deactivate();
  }
}