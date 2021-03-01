import 'package:coupon_app/app/utils/constants.dart';
import 'package:coupon_app/domain/entities/category_entity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CategoryButton extends StatefulWidget{
  final CategoryEntity category;
  final Function onClick;

  const CategoryButton({this.category, this.onClick}) : super();

  @override
  State<StatefulWidget> createState() =>  _CategoryButtonState();

}

class _CategoryButtonState extends State<CategoryButton>{
  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.all(8.0),
    child: SizedBox(
      width: 40,
      child: InkWell(
        onTap: widget.onClick,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: 36,
              height: 36,
              child: Container(
                decoration: BoxDecoration(
                    color: AppColors.neutralLight,
                    borderRadius: BorderRadius.all(Radius.circular(46)),
                    boxShadow: [BoxShadow(
                      color: Colors.grey,
                      offset: Offset(2, 2),
                      blurRadius: 4.0,
                    ),]
                ),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(Dimens.spacingSmall),
                    child:widget.category != null && widget.category.icon.startsWith("http") ? Image.network(
                      widget.category != null ? widget.category.icon : "",
                      width: 16,
                    ):  Image.asset(
                      widget.category != null ? widget.category.icon : "",
                      width: 16,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: Dimens.spacingNormal,
            ),
            Expanded(
              child: Text(
                widget.category != null ? widget.category.name : "",
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: captionNormal2.copyWith(color: AppColors.neutralDark),
              ),
            ),
          ],
        ),
      ),
    ),
  );

}