import 'package:coupon_app/app/utils/constants.dart';
import 'package:coupon_app/app/utils/locale_keys.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class StateView extends StatefulWidget {
  IconData emptyStateIcon;
  String emptyStateTitle;
  String emptyStateMessage;

  String errorTitle;
  String errorMessage;

  EmptyState state;

  Widget contentView;

  StateView(this.state, this.contentView,
      {this.emptyStateIcon,
      this.emptyStateTitle,
      this.emptyStateMessage,
      this.errorTitle,
      this.errorMessage});

  @override
  State<StatefulWidget> createState() => _StateViewState();
}

enum EmptyState { EMPTY, NETWORK_ERROR, ERROR, CONTENT, LOADING }

class _StateViewState extends State<StateView> {
  @override
  Widget build(BuildContext context) {
    switch (widget.state) {
      case EmptyState.EMPTY:
        return _emptyState;
      case EmptyState.NETWORK_ERROR:
        return  _errorView("Network Error", "Something went wrong");
      case EmptyState.ERROR:
        return  _errorView(widget.errorTitle, widget.errorMessage);
      case EmptyState.CONTENT:
        return  widget.contentView;
      case EmptyState.LOADING:
        return _loader;
    }
    return _emptyState;
  }

  Widget _errorView(title , message ){
    return Column(
      children: [
        Text(title),
        Text(message)
      ],
    );
  }

  get _emptyState => Container(
    width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(widget.emptyStateIcon ?? Feather.server, size: 36,),
            SizedBox(
              height: Dimens.spacingMedium,
            ),
            Text(widget.emptyStateMessage ?? LocaleKeys.noData.tr(), style: heading5.copyWith(color: AppColors.neutralGray),)
          ],
        ),
      );

  get _loader => Container(
        child: SpinKitWanderingCubes(
          color: AppColors.neutralGray,
        ),
      );
}
