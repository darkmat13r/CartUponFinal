import 'package:coupon_app/app/components/rounded_box.dart';
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
              title: Text("Home"),
            ),
            ListTile(
              leading: Icon(MaterialCommunityIcons.view_dashboard),
              title: Text("Categories"),
            ),
            ListTile(
              leading: Icon(MaterialCommunityIcons.settings),
              title: Text("Settings"),
            ),
            ListTile(
              title: Text("Privacy Policy"),
            ),
            ListTile(
              title: Text("Contact Us"),
            ),
            ListTile(
              onTap: () {
                Navigator.pop(context);

                showDialog(
                    context: context,
                    builder: (BuildContext ctx) {
                      return AlertDialog(
                        title: Text("Change Language"),
                        content: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Expanded(
                              child: InkWell(
                                onTap: () {
                                  ctx.setLocale( Locale("en"));
                                  Navigator.pop(ctx);
                                },
                                child: Container(
                                  width: 48,
                                  height: 48,
                                  child: Center(
                                      child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text("En"),
                                  )),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color:
                                            Config().locale.languageCode == "en"
                                                ? AppColors.accent
                                                : AppColors.neutralGray,
                                        width: 2),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 48,
                            ),
                            Expanded(
                              child: InkWell(
                                onTap: () {
                                  ctx.setLocale( Locale("ar"));
                                  Navigator.pop(ctx);
                                },
                                child: Container(
                                  width: 48,
                                  height: 48,
                                  child: Center(
                                      child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text("Ar"),
                                  )),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color:
                                            Config().locale.languageCode == "ar"
                                                ? AppColors.accent
                                                : AppColors.neutralGray,
                                        width: 2),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    });
              },
              title: Text("Switch Language"),
            )
          ],
        ),
      ),
    );
  }
}
