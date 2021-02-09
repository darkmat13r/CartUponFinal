import 'package:flutter/material.dart';
import 'package:coupon_app/app/utils/constants.dart';

class LoadingButton extends StatefulWidget {
  Function onPressed;
  bool isLoading;
  String text;

  LoadingButton(
      {@required Function onPressed, bool isLoading, @required String text})
      : this.isLoading = isLoading == null ? false : isLoading,
        this.onPressed = onPressed,
        this.text = text;

  @override
  LoadingButtonState createState() => LoadingButtonState();
}

class LoadingButtonState extends State<LoadingButton> {
  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      onPressed: widget.isLoading ? null : widget.onPressed,
      child: widget.isLoading
          ? CircularProgressIndicator()
          : Text(
              widget.text,
              style: buttonText,
            ),
    );
  }
}
