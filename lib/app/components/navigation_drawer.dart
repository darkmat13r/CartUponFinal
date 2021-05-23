import 'package:coupon_app/app/components/rounded_box.dart';
import 'package:coupon_app/app/pages/pages.dart';
import 'package:coupon_app/app/utils/config.dart';
import 'package:coupon_app/app/utils/constants.dart';
import 'package:coupon_app/app/utils/locale_keys.dart';
import 'package:coupon_app/domain/entities/models/User.dart';
import 'package:coupon_app/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

class NavigationDrawer extends StatefulWidget {
  final User user;

  NavigationDrawer(this.user);

  @override
  State<StatefulWidget> createState() => _NavigationDrawerState();
}

class _NavigationDrawerState extends State<NavigationDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SizedBox(
        width: 240,
        child: ListView(
          children: [
            Container(
              color: AppColors.neutralLight,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    Resources.logo,
                    width: 80,
                  ),
                  SizedBox(
                    height: Dimens.spacingLarge,
                  ),
                  widget.user != null
                      ? Text(widget.user.first_name)
                      : SizedBox(),
                  SizedBox(
                    height: Dimens.spacingLarge,
                  ),
                ],
              ),
            ),
            ListTile(
              leading: Icon(MaterialCommunityIcons.home),
              title: Text(LocaleKeys.tabHome.tr()),
            ),
            ListTile(
              leading: Icon(MaterialCommunityIcons.view_dashboard),
              title: Text(LocaleKeys.tabCategories.tr()),
            ),
            ListTile(
              leading: Icon(MaterialCommunityIcons.settings),
              title: Text(LocaleKeys.settings.tr()),
              onTap: (){
                Navigator.pushNamed(context, Pages.settings);
              },
            ),
            ListTile(
              title: Text(LocaleKeys.privacyPolicy),
            ),
            ListTile(
              title: Text(LocaleKeys.contactUs),
            ),

          ],
        ),
      ),
    );
  }
}
