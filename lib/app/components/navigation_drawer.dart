import 'package:coupon_app/app/components/rounded_box.dart';
import 'package:coupon_app/app/pages/contactus/contact_us_view.dart';
import 'package:coupon_app/app/pages/pages.dart';
import 'package:coupon_app/app/pages/payment/payment_view.dart';
import 'package:coupon_app/app/pages/webview/webpage_view.dart';
import 'package:coupon_app/app/utils/config.dart';
import 'package:coupon_app/app/utils/constants.dart';
import 'package:coupon_app/app/utils/locale_keys.dart';
import 'package:coupon_app/data/utils/constants.dart';
import 'package:coupon_app/domain/entities/models/User.dart';
import 'package:coupon_app/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_html/style.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:logger/logger.dart';
import 'package:url_launcher/url_launcher.dart';

class NavigationDrawer extends StatefulWidget {
  final User user;
  Function onSelectHome;
  Function onSelectCategory;
  Function onOpenUrl;

  NavigationDrawer(this.user,
      {this.onSelectHome, this.onSelectCategory, this.onOpenUrl});

  @override
  State<StatefulWidget> createState() => _NavigationDrawerState();
}

class _NavigationDrawerState extends State<NavigationDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: AppColors.neutralLight,
        child: Column(
          children: [
            _buildListView(context),
            Spacer(),
            _buildFollowUsOn(),
            SizedBox(height: 30),
            _buildBottomMenu(context),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  ListView _buildListView(BuildContext context) {
    return ListView(
            shrinkWrap: true,
            children: [
              Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: Dimens.spacingLarge,
                    ),
                    Image.asset(
                      Resources.toolbarLogo2,
                      width: 80,
                    ),
                    // SizedBox(
                    //   height: Dimens.spacingLarge,
                    // ),
                    // widget.user != null
                    //     ? Text(widget.user.first_name)
                    //     : SizedBox(),
                    SizedBox(
                      height: Dimens.spacingLarge * 2,
                    ),
                  ],
                ),
              ),
              ListTile(
                leading: Icon(MaterialCommunityIcons.home),
                title: Text(
                  LocaleKeys.tabHome.tr(),
                  style: heading5,
                ),
                onTap: () {
                  if (widget.onSelectHome != null) widget.onSelectHome();
                  Navigator.pop(context);
                },
              ),
              Divider(
                color: AppColors.neutralLightGray,
                indent: 60,
                endIndent: 20,
              ),
              ListTile(
                leading: Icon(MaterialCommunityIcons.view_dashboard),
                title: Text(
                  LocaleKeys.tabCategories.tr(),
                  style: heading5,
                ),
                onTap: () {
                  if (widget.onSelectCategory != null) widget.onSelectCategory();
                  Navigator.pop(context);
                },
              ),
              Divider(
                color: AppColors.neutralLightGray,
                indent: 60,
                endIndent: 20,
              ),
              ListTile(
                leading: Icon(MaterialCommunityIcons.settings),
                title: Text(
                  LocaleKeys.settings.tr(),
                  style: heading5,
                ),
                onTap: () {
                  Navigator.pushNamed(context, Pages.settings);
                },
              ),
              Divider(
                color: AppColors.neutralLightGray,
                indent: 60,
                endIndent: 20,
              ),
              /* ListTile(
                title: Text(LocaleKeys.contactUs.tr()),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ContactUsPage()),
                  );
                },
              ),*/
            ],
          );
  }

  Container _buildBottomMenu(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              InkWell(
                onTap: () {
                  openUrl(context, LocaleKeys.terms.tr(), Constants.termsUrl);
                },
                child: Text(
                  LocaleKeys.terms.tr(),
                  style: captionNormal1.copyWith(color: AppColors.accent),
                ),
              ),
              InkWell(
                onTap: () {
                  openUrl(context, LocaleKeys.privacyPolicy.tr(),
                      Constants.privacyUrl);
                },
                child: Text(
                  LocaleKeys.privacyPolicy.tr(),
                  style: captionNormal1.copyWith(color: AppColors.accent),
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
          InkWell(
            onTap: () {
              openUrl(context, LocaleKeys.aboutUs.tr(), Constants.aboutUsUrl);
            },
            child: Text(
              LocaleKeys.aboutUs.tr(),
              style: captionNormal1.copyWith(color: AppColors.accent),
            ),
          ),
        ],
      ),
    );
  }

  Container _buildFollowUsOn() {
    return Container(
      child: Column(
        children: [
          Text(
            LocaleKeys.followUsOn.tr(),
            style: formHintText.copyWith(fontWeight: FontWeight.bold),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              IconButton(
                icon: Icon(
                  FontAwesome.facebook,
                  color: AppColors.primary,
                ),
                onPressed: () {
                  openSocialSites(Resources.facebookUrl);
                },
              ),
              IconButton(
                icon: Icon(
                  FontAwesome.youtube,
                  color: AppColors.primary,
                ),
                onPressed: () {
                  openSocialSites(Resources.youtubeUrl);
                },
              ),
              IconButton(
                icon: Icon(
                  FontAwesome.instagram,
                  color: AppColors.primary,
                ),
                onPressed: () {
                  openSocialSites(Resources.instagramUrl);
                },
              ),
              IconButton(
                icon: Icon(
                  FontAwesome.twitter,
                  color: AppColors.primary,
                ),
                onPressed: () {
                  openSocialSites(Resources.twitterUrl);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  openSocialSites(String url) async {
    await canLaunch(url) ? await launch(url) : throw 'Could not launch $url';
  }

  openUrl(context, String title, String page) async {
    Navigator.pop(context);
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => WebPage(
                page: page,
                title: title,
              )),
    );
  }
}
