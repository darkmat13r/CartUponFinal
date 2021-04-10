import 'package:coupon_app/app/auth_presenter.dart';
import 'package:coupon_app/domain/entities/models/Product.dart';
import 'package:coupon_app/domain/entities/models/WhishlistItem.dart';
import 'package:coupon_app/domain/repositories/authentication_repository.dart';
import 'package:coupon_app/domain/repositories/whishlist_repository.dart';
import 'package:coupon_app/domain/usercases/whishlist/delete_whishlist_item_use_case.dart';
import 'package:coupon_app/domain/usercases/whishlist/get_whishlist_use_case.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

class WhishlistPresenter extends AuthPresenter {
  GetWhishlistUseCase _getWhishlistUseCase;
  Function getWhishlistOnComplete;
  Function getWhishlistOnNext;
  Function getWhishlistOnError;


  DeleteWhishlistItemUseCase _deleteWhishlistUseCase;
  Function deleteWhishlistOnComplete;
  Function deleteWhishlistOnError;
  Function deleteWhishlistOnNext;

  WhishlistPresenter(WhishlistRepository whishlistRepository,
      AuthenticationRepository authRepo)
      : _getWhishlistUseCase = GetWhishlistUseCase(whishlistRepository),
        _deleteWhishlistUseCase = DeleteWhishlistItemUseCase(whishlistRepository),super(authRepo){
    fetchWhishList();
  }


  deleteWhishlistItem(WhishlistItem item){
    _deleteWhishlistUseCase.execute(_DeleteWhishlistObserver(this), item);
  }

  fetchWhishList(){
    _getWhishlistUseCase.execute(_GetWhishlistObserver(this));
  }


}


class _GetWhishlistObserver extends Observer<List<WhishlistItem>>{
  final WhishlistPresenter _presenter;

  _GetWhishlistObserver(this._presenter);

  @override
  void onComplete() {
    assert(_presenter.getWhishlistOnComplete != null);
    _presenter.getWhishlistOnComplete();
  }

  @override
  void onError(e) {
    assert(_presenter.getWhishlistOnError != null);
    _presenter.getWhishlistOnError(e);
  }

  @override
  void onNext(List<WhishlistItem> response) {
    assert(_presenter.getWhishlistOnNext != null);
    _presenter.getWhishlistOnNext(response);
  }

}

class _DeleteWhishlistObserver extends Observer<void>{
  final WhishlistPresenter _presenter;


  _DeleteWhishlistObserver(this._presenter);

  @override
  void onComplete() {
    assert(_presenter.deleteWhishlistOnComplete !=  null);
    _presenter.deleteWhishlistOnComplete();
  }

  @override
  void onError(e) {
   assert(_presenter.deleteWhishlistOnError != null);
   _presenter.deleteWhishlistOnError(e);
  }

  @override
  void onNext(void response) {
   assert(_presenter.deleteWhishlistOnNext != null);
   _presenter.deleteWhishlistOnNext(response);
  }

}