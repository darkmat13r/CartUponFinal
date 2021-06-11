import 'package:coupon_app/app/base_controller.dart';
import 'package:coupon_app/app/pages/whishlist/whishlist_presenter.dart';
import 'package:coupon_app/app/utils/constants.dart';
import 'package:coupon_app/app/utils/locale_keys.dart';
import 'package:coupon_app/app/utils/router.dart';
import 'package:coupon_app/domain/entities/models/ProductDetail.dart';
import 'package:coupon_app/domain/entities/models/WhishlistItem.dart';

class WhishlistController extends BaseController {
  final WhishlistPresenter _presenter;

  List<WhishlistItem> whishListItems = [];

  WhishlistController(whishlistRepository, authRepo)
      : _presenter = WhishlistPresenter(whishlistRepository, authRepo) {
    showLoading();
  }

  @override
  void initListeners() {
    initBaseListeners(_presenter);
    _initDeleteWhishlistItemListeners();
    _initFetchWhishlistListeners();
  }

  delete(WhishlistItem item) {
    showGenericConfirmDialog(getContext(), LocaleKeys.alert.tr(), LocaleKeys.confirmRemoveWhishlistItem.tr(), onConfirm: (){
      whishListItems.remove(item);
      refreshUI();
      _presenter.deleteWhishlistItem(item);
    });
  }

  void _initDeleteWhishlistItemListeners() {
    _presenter.deleteWhishlistOnNext = (res) {};
    _presenter.deleteWhishlistOnError = (e) {
      dismissLoading();
      showGenericSnackbar(getContext(), e.message, isError: true);
      _presenter.fetchWhishList();
    };

    _presenter.deleteWhishlistOnComplete = () {
      dismissLoading();
      _presenter.fetchWhishList();
    };
  }

  void _initFetchWhishlistListeners() {
    _presenter.getWhishlistOnComplete = () {
      dismissLoading();
      dismissProgressDialog();
    };
    _presenter.getWhishlistOnNext = (items) {
      whishListItems = items;
      refreshUI();
    };
    _presenter.getWhishlistOnError = (e) {
      dismissLoading();
      dismissProgressDialog();
      showGenericSnackbar(getContext(), e.meesage, isError: true);
    };
  }

  void showProductDetails(ProductDetail productDetail){
    AppRouter().productDetailsById(getContext(), productDetail.id.toString());
  }
}
