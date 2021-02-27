import 'package:coupon_app/app/pages/splash/splash_controller.dart';
import 'package:coupon_app/app/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

class SplashPage extends View {
  @override
  State<StatefulWidget> createState() => _SplashPageState();
}

class _SplashPageState extends ViewState<SplashPage, SplashController> {
  _SplashPageState() : super(SplashController());

  @override
  Widget get view => Scaffold(
        key: globalKey,
        body: _body,
      );

  get _body => Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 200,
                  decoration: BoxDecoration(
                      color: AppColors.accent,
                    borderRadius: BorderRadius.only(bottomLeft: Radius.circular(70), bottomRight: Radius.circular(70))
                  ),

                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        CircleAvatar(
                          radius: 36,
                          backgroundColor: AppColors.neutralLight,
                          child: Image.asset(Resources.mainLogo, width: 48,),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
            Center(
              child: SizedBox(width: 240, child: Image.asset(Resources.toolbarLogo)),
            )
          ],
        ),
      );
}
