import 'package:coupon_app/app/auth_presenter.dart';
import 'package:coupon_app/domain/repositories/authentication_repository.dart';
import 'package:coupon_app/domain/repositories/product_repository.dart';
import 'package:coupon_app/domain/usercases/product/post_reating_use_case.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

class CreateReviewPresenter extends AuthPresenter{

  final PostRatingUseCase _postRatingUseCase;

  Function postReviewOnComplete;
  Function postReviewOnError;
  Function postReviewOnNext;

  CreateReviewPresenter(AuthenticationRepository authRepo,ProductRepository productRepository) : _postRatingUseCase = PostRatingUseCase(productRepository), super(authRepo);


  submitReview(int productId, int rating, String review){
    _postRatingUseCase.execute(_PostReviewObserver(this), PostRatingParams(
      productId: productId,
      rating: rating,
      review:  review
    ));
  }

  @override
  void dispose() {
    _postRatingUseCase.dispose();
  }
}


class _PostReviewObserver extends Observer<dynamic>{
  final CreateReviewPresenter _presenter;

  _PostReviewObserver(this._presenter);

  @override
  void onComplete() {
    assert(_presenter.postReviewOnComplete != null);
    _presenter.postReviewOnComplete();
  }

  @override
  void onError(e) {
    assert(_presenter.postReviewOnError != null);
    _presenter.postReviewOnError(e);
  }

  @override
  void onNext(response) {
    assert(_presenter.postReviewOnNext != null);
    _presenter.postReviewOnNext(response);
  }

}