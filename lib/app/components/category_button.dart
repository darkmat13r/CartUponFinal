import 'package:coupon_app/app/components/app_image.dart';
import 'package:coupon_app/app/utils/constants.dart';
import 'package:coupon_app/domain/entities/models/CategoryType.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CategoryButton extends StatefulWidget {
  final CategoryType category;
  final Function onClick;
  final double size;
  final bool showLabel;
  final bool chipStyle;

  const CategoryButton({this.category, this.onClick, this.size, this.showLabel, this.chipStyle})
      : super();

  @override
  State<StatefulWidget> createState() => _CategoryButtonState();
}

class _CategoryButtonState extends State<CategoryButton> {
  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.only(right: 8.0),
        child: InkWell(
          onTap: widget.onClick,
          child:widget.chipStyle ?? true ? Chip(
            backgroundColor: AppColors.cardBg,
            elevation: 3.0,
            shadowColor: AppColors.neutralDark,
            label:  Text(
              widget.category != null ? widget.category.name : "",
              textAlign: TextAlign.center,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: captionNormal1.copyWith(color: AppColors.primary),
            )
          ): _buildColumn(),
        ),
      );

  Column _buildColumn() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: widget.size ?? 36,
          height: widget.size ?? 36,
          child: Container(
            decoration: BoxDecoration(
                color: AppColors.neutralLight,
                borderRadius:
                    BorderRadius.all(Radius.circular(widget.size ?? 46)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey,
                    offset: Offset(1, 1),
                    blurRadius: 2.0,
                  ),
                ]),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(widget.size ?? 36),
              child: Center(

                child: Padding(
                  padding: const EdgeInsets.all(Dimens.spacingNormal),
                  child: AppImage(widget.category != null
                      ? widget.category.mobile_image
                      : "", fit: BoxFit.contain,),
                ),
              ),
            ),
          ),
        ),
        SizedBox(
          height: Dimens.spacingNormal,
        ),
        (widget.showLabel ?? true)
            ? Expanded(
                child: Text(
                  widget.category != null ? widget.category.name : "",
                  textAlign: TextAlign.center,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: captionNormal1.copyWith(color: AppColors.neutralDark),
                ),
              )
            : SizedBox(),
      ],
    );
  }
}
