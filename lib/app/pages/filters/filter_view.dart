import 'package:coupon_app/app/components/loading_button.dart';
import 'package:coupon_app/app/pages/filters/filter_controller.dart';
import 'package:coupon_app/app/utils/constants.dart';
import 'package:coupon_app/app/utils/locale_keys.dart';
import 'package:coupon_app/app/utils/theme_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:flutter_icons/flutter_icons.dart';

class FilterPage extends View {
  @override
  State<StatefulWidget> createState() => FilterPageState();
}

class FilterPageState extends ViewState<FilterPage, FilterController> {
  FilterPageState() : super(FilterController());

  @override
  Widget get view => Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          leading: IconButton(
            onPressed: () {},
            icon: Icon(Feather.chevron_left, color: AppColors.neutralGray),
          ),
          title: Text(
            LocaleKeys.filterSearch.tr(),
            style: heading4.copyWith(color: AppColors.neutralDark),
          ),
          shape: appBarShape,
        ),
        key: globalKey,
        body: _body,
      );

  get _body => ListView(
    shrinkWrap: true,
        children: [
          _priceRange,
          _condition,
          /*  _condition,
      _buyFormat,
      _applyFilter*/
          _applyFilter
        ],
      );

  get _priceRange => Padding(
        padding: const EdgeInsets.all(Dimens.spacingMedium),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              LocaleKeys.priceRange.tr(),
              style: heading5.copyWith(color: AppColors.neutralDark),
            ),
            SizedBox(
              height: Dimens.spacingMedium,
            ),
            Row(
              children: [
                Flexible(
                  flex: 1,
                  child: TextFormField(
                    decoration: InputDecoration(hintText: "\$1,120"),
                  ),
                ),
                SizedBox(
                  width: Dimens.spacingMedium,
                ),
                Flexible(
                  flex: 1,
                  child: TextFormField(
                    decoration: InputDecoration(hintText: "\$1,120"),
                  ),
                )
              ],
            ),
            _priceRangeSlider
          ],
        ),
      );

  get _priceRangeSlider => ControlledWidgetBuilder(
          builder: (BuildContext context, FilterController controller) {
        return RangeSlider(
            min: controller.minPrice,
            max: controller.maxPrice,
            values: controller.currentPriceRangeValues,
            labels: RangeLabels(LocaleKeys.min.tr(), LocaleKeys.max.tr()),
            onChanged: controller.onPriceRangeChanged);
      });

  get _condition => ControlledWidgetBuilder(
          builder: (BuildContext context, FilterController controller) {
        return Padding(
          padding: const EdgeInsets.all(Dimens.spacingMedium),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              Text(
                LocaleKeys.color.tr(),
                style: heading5.copyWith(color: AppColors.neutralDark),
              ),
              SizedBox(
                height: Dimens.spacingMedium,
              ),
              GridView(
                shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    childAspectRatio: 2.5, crossAxisCount: 3),
                children: ["Red", "Blue", "Black"].map((e) => Padding(
                  padding: const EdgeInsets.all(Dimens.spacingSmall),
                  child: OutlinedButton(
                      onPressed: () {},
                      child: Text(
                        e,
                        style: buttonText.copyWith(color: AppColors.primary),
                      )),
                )).toList(),
              ),
            ],
          ),
        );
      });

  get _buyFormat => null;

  get _applyFilter => ControlledWidgetBuilder(
          builder: (BuildContext context, FilterController controller) {
        return Padding(
          padding: const EdgeInsets.all(Dimens.spacingMedium),
          child: LoadingButton(
            onPressed: () {
              controller.applyFilter();
            },
            text: LocaleKeys.applyFilter.tr(),
          ),
        );
      });
}
