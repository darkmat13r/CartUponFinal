import 'package:coupon_app/app/base_controller.dart';
import 'package:coupon_app/app/pages/reviews/create/create_review_presenter.dart';
import 'package:coupon_app/app/utils/constants.dart';
import 'package:coupon_app/app/utils/locale_keys.dart';
import 'package:coupon_app/domain/repositories/authentication_repository.dart';
import 'package:coupon_app/domain/repositories/product_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

class CreateReviewController extends BaseController {
  final CreateReviewPresenter _presenter;

  final int productId;
  int rating;

  TextEditingController reviewTextController;

  CreateReviewController(this.productId,AuthenticationRepository authRepo, ProductRepository productRepository)
      : _presenter = CreateReviewPresenter(authRepo, productRepository) {
    reviewTextController = TextEditingController();
  }

  @override
  void initListeners() {
    initBaseListeners(_presenter);
    initPostReviewListeners();
  }

  @override
  onAuthComplete() {
    super.onAuthComplete();
    if(currentUser == null){
      Navigator.of(getContext()).pop();
    }
  }

  postReview(){
    showProgressDialog();
    _presenter.submitReview(productId, rating, reviewTextController.text);
  }

  changeRating(int rating){
    this.rating = rating;
    refreshUI();
  }

  void initPostReviewListeners() {
    _presenter.postReviewOnComplete = (){
      dismissProgressDialog();
      showGenericSnackbar(getContext(), LocaleKeys.reviewPostedSuccessfully.tr());
      Navigator.pop(getContext(), true);
    };
    _presenter.postReviewOnError = (e){
      dismissProgressDialog();
      showGenericSnackbar(getContext(), e.message, isError: true);
    };

    _presenter.postReviewOnNext = (res){
    };
  }

  void checkForm(Map<String, Object> params) {
    dynamic formKey = params['formKey'];
    // Validate params
    assert(formKey is GlobalKey<FormState>);
    if (formKey.currentState.validate()) {
      if(rating == null || rating == 0){
        showGenericSnackbar(getContext(), LocaleKeys.errorRatingMustBe.tr(), isError: true);
        return;
      }
      postReview();
    }
  }
}
