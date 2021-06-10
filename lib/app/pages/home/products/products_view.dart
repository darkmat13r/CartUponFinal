import 'package:coupon_app/app/components/category_button.dart';
import 'package:coupon_app/app/components/product_item.dart';
import 'package:coupon_app/app/components/state_view.dart';
import 'package:coupon_app/app/pages/home/products/products_controller.dart';
import 'package:coupon_app/app/pages/product/product_controller.dart';
import 'package:coupon_app/data/repositories/data_category_respository.dart';
import 'package:coupon_app/data/repositories/data_product_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

class ProductsPage extends View{

  final String type;


  ProductsPage(this.type);

  @override
  State<StatefulWidget> createState() => _ProductsPageState(type: type);

}

class _ProductsPageState extends ViewState<ProductsPage, ProductsController>{
  _ProductsPageState({String type}) : super(ProductsController(type, DataCategoryRepository(), DataProductRepository()));

  @override
  Widget get view => Scaffold(
    key: globalKey,
    body:  _body,
  );

  get _body => ControlledWidgetBuilder(builder: (BuildContext context, ProductsController  controller){
    return SingleChildScrollView(
      child: StateView(
          controller.isLoading ?  EmptyState.LOADING : EmptyState.CONTENT,
          ListView(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            children: [
             /* _categories,*/
              _products
            ],
          )
      ),
    );
  });

  get _categories => ControlledWidgetBuilder(builder: (BuildContext context, ProductsController controller ){
    return controller.categories != null &&  controller.categories.length > 0 ? SizedBox(
      height: 120,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemCount:  controller.categories.length ,
          itemBuilder: (BuildContext context, int index){
        return CategoryButton(
          showLabel: true,
          category: controller.categories[index],onClick: (){
          controller.openCategory(context, controller.categories[index]);
        },);
      }),
    ) : SizedBox();
  });


  get _products => ControlledWidgetBuilder(builder: (BuildContext context, ProductsController controller ){
    double cardWidth = MediaQuery.of(context).size.width / 3.3;
    double cardHeight = 160;
    return StateView(
      controller.isLoading ? EmptyState.LOADING : EmptyState.CONTENT ,
      GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: controller.products != null ? controller.products.length : 0,
        itemBuilder: (BuildContext context, int index){
        return ProductItem(product: controller.products[index]);
      }, gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, childAspectRatio:  cardWidth / cardHeight),),
    );
  });

}