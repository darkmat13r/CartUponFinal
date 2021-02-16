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
    return ListView(
      children: [
        Container(
          color: AppColors.neutralLight,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [Image.asset(Resources.logo), Text("UserName")],
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
    );
  }
}
