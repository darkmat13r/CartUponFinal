import 'package:coupon_app/app/components/rounded_box.dart';
import 'package:coupon_app/app/pages/pages.dart';
import 'package:coupon_app/app/pages/payment/payment_view.dart';
import 'package:coupon_app/app/utils/config.dart';
import 'package:coupon_app/app/utils/constants.dart';
import 'package:coupon_app/app/utils/locale_keys.dart';
import 'package:coupon_app/data/utils/constants.dart';
import 'package:coupon_app/domain/entities/models/User.dart';
import 'package:coupon_app/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

class NavigationDrawer extends StatefulWidget {
  final User user;
  Function onSelectHome;
  Function onSelectCategory;

  NavigationDrawer(this.user, {this.onSelectHome, this.onSelectCategory});

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
                    Resources.toolbarLogo2,
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
              onTap: () {
                if (widget.onSelectHome != null) widget.onSelectHome();
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(MaterialCommunityIcons.view_dashboard),
              title: Text(LocaleKeys.tabCategories.tr()),
              onTap: (){
                if (widget.onSelectCategory != null) widget.onSelectCategory();
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(MaterialCommunityIcons.settings),
              title: Text(LocaleKeys.settings.tr()),
              onTap: () {
                Navigator.pushNamed(context, Pages.settings);

              },
            ),
            ListTile(
              title: Text(LocaleKeys.privacyPolicy.tr()),
              onTap: () {
                openUrl(context, Constants.privacyUrl);
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text(LocaleKeys.terms.tr()),
              onTap: () {
                openUrl(context, Constants.termsUrl);
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text(LocaleKeys.contactUs.tr()),
              onTap: () {
                openUrl(context, Constants.aboutUsUrl);
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  openUrl(context, String url) {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => PaymentPage(
                url,
              )),
    );
  }
}
