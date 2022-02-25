import 'package:coupon_app/app/base_controller.dart';
import 'package:coupon_app/app/pages/contact/contact_us_presenter.dart';
import 'package:coupon_app/app/utils/constants.dart';
import 'package:coupon_app/domain/entities/models/WebSetting.dart';
import 'package:coupon_app/domain/repositories/home_repository.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:logger/logger.dart';
import 'package:url_launcher/url_launcher.dart';
class ContactUsController extends BaseController {
  final ContactUsPresenter _presenter;
  WebSetting webSetting;

  ContactUsController(HomeRepository homeRepository)
      : this._presenter = ContactUsPresenter(homeRepository);

  @override
  void initListeners() {
    _presenter.getSettingsOnComplete = () {};
    _presenter.getSettingsOnNext = (response) {
      webSetting = response;
      refreshUI();
    };
    _presenter.getSettingsOnError = (error) {
      showGenericSnackbar(getContext(), error.message, isError: true);
    };
  }

  @override
  void onDisposed() {
    _presenter.dispose();
    super.onDisposed();
  }

  void openCall(String number) {
    Logger().e(number);
    final Uri phoneLaunchUrl = Uri(
      scheme: 'tel',
      path: number.replaceAll(" ", "").replaceAll("-", ""),
    );
    launch(phoneLaunchUrl.toString());
  }

  void openMail(String s) {
    final Uri emailLaunchUri = Uri(
      scheme: 'mailto',
      path: s,
    );
    launch(emailLaunchUri.toString());
  }

  void openWhatsapp(String s) async{
    try{
      final Uri emailLaunchUri = Uri(
        scheme: 'whatsapp',
        path: "send?phone=${s.replaceAll("+", "").replaceAll("-", "").replaceAll(" ", "")}&text=Hello%20Cartupon",
      );
      Logger().e(emailLaunchUri);
      if(await canLaunch(emailLaunchUri.toString())){
       await launch(emailLaunchUri.toString());
      }

    }catch(e){

    }
  }
}
