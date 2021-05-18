import 'package:coupon_app/app/base_controller.dart';
import 'package:coupon_app/app/pages/home/products/prodcuts_presenter.dart';
import 'package:coupon_app/app/utils/constants.dart';
import 'package:coupon_app/app/utils/router.dart';
import 'package:coupon_app/domain/entities/models/Category.dart';
import 'package:coupon_app/domain/entities/models/CategoryType.dart';
import 'package:coupon_app/domain/entities/models/Product.dart';
import 'package:coupon_app/domain/entities/models/ProductDetail.dart';
import 'package:coupon_app/domain/repositories/category_repository.dart';
import 'package:coupon_app/domain/repositories/product_repository.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

class ProductsController extends BaseController {
  final ProductsPresenter _presenter;

  final String type;

  List<CategoryType> categories;
  List<ProductDetail> products;

  ProductsController(this.type, CategoryRepository categoryRepository,
      ProductRepository productRepository)
      : _presenter =
            ProductsPresenter(type, categoryRepository, productRepository){
    showLoading();
  }

  @override
  void initListeners() {
    _presenter.getCategoriesOnComplete = (){
      dismissLoading();
    };
    _presenter.getCategoriesOnError = (e){
      dismissLoading();
      showGenericSnackbar(getContext(), e.message);
    };

    _presenter.getCategoriesOnNext = (data){
      categories = data;
      refreshUI();
    };

    _presenter.getProductsOnComplete = (){
      dismissLoading();
    };
    _presenter.getProductsOnNext = (data){
      products  = data;
      refreshUI();
    };

    _presenter.getProductsOnError = (e){
      dismissLoading();
      showGenericSnackbar(getContext(), e.message);
    };
  }

  void openCategory(CategoryType category) {
    AppRouter().categorySearch(getContext(), category);
  }
}
