import 'package:coupon_app/app/auth_presenter.dart';
import 'package:coupon_app/domain/entities/models/Token.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

abstract class BaseController extends Controller {
  bool isLoading = false;

  Token currentUser;

  initBaseListeners(AuthPresenter authPresenter) {
    authPresenter.getCurrentUserOnNext = (token) => {this.currentUser = token};
    authPresenter.getCurrentUserOnError = (e) => {onAuthError(e)};
    authPresenter.getCurrentUserOnComplete = onAuthComplete;
  }

  onAuthComplete() {
    refreshUI();
  }

  onAuthError(e) {}

  showLoading() {
    isLoading = true;
    refreshUI();
  }

  dismissLoading() {
    isLoading = false;
    refreshUI();
  }

  handlerUnknownError(e) {
    print(e);
  }
}
