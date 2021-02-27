import 'package:coupon_app/app/utils/constants.dart';
import 'package:coupon_app/app/utils/locale_keys.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

class NavigationDrawer extends StatefulWidget {
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
                  Text("UserName"),
                  SizedBox(
                    height: Dimens.spacingLarge,
                  ),
                ],
              ),
            ),
            ListTile(
              leading: Icon(MaterialCommunityIcons.home),
              title: Text("Home"),
            ),
            ListTile(
              leading: Icon(MaterialCommunityIcons.view_dashboard),
              title: Text("Categories"),
            ),
            ListTile(
              leading: Icon(MaterialCommunityIcons.settings),
              title: Text("Settings"),
            )
          ],
        ),
      ),
    );
  }
}
