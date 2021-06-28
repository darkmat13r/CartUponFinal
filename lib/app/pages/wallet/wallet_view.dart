import 'package:coupon_app/app/components/state_view.dart';
import 'package:coupon_app/app/pages/searchable_view_state.dart';
import 'package:coupon_app/app/pages/wallet/wallet_controller.dart';
import 'package:coupon_app/app/utils/constants.dart';
import 'package:coupon_app/app/utils/locale_keys.dart';
import 'package:coupon_app/app/utils/utility.dart';
import 'package:coupon_app/data/repositories/data_authentication_repository.dart';
import 'package:coupon_app/data/repositories/data_wallet_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:flutter_icons/flutter_icons.dart';

class WalletPage extends View {
  @override
  State<StatefulWidget> createState() => _WalletPageState();
}

class _WalletPageState extends SearchableViewState<WalletPage, WalletController> {
  _WalletPageState()
      : super(WalletController(
            DataAuthenticationRepository(), DataWalletRepository()));

  get _stateView => ControlledWidgetBuilder(
          builder: (BuildContext context, WalletController controller) {
        return StateView(
            controller.isLoading ? EmptyState.LOADING : EmptyState.CONTENT,
            _body2);
      });


  Widget get _body2 => ControlledWidgetBuilder(
          builder: (BuildContext context, WalletController controller) {
        return ListView(
          shrinkWrap: true,
          children: [
            Padding(padding: const EdgeInsets.all(Dimens.spacingNormal), child: _currentBalance,),
          ],
        );
      });

  get _currentBalance => ControlledWidgetBuilder(
          builder: (BuildContext context, WalletController controller) {
        return Card(
          child: Padding(
            padding: const EdgeInsets.all(Dimens.spacingMedium),
            child: Column(
              children: [
                Text(
                  LocaleKeys.currentBalance.tr(),
                  style: captionNormal1.copyWith(color: AppColors.neutralGray),
                ),
                Text(
                  Utility.currencyFormat(controller.currentUser != null
                      ? (controller.currentUser.wallet_balance ?? "0")
                      : "0"),
                  style: heading4,
                ),
                TextButton.icon(
                    onPressed: () {
                      controller.addMoneyToWallet();
                    },
                    icon: Icon(MaterialCommunityIcons.wallet),
                    label: Text(
                      LocaleKeys.addMoneyToWallet.tr(),
                      style: buttonText.copyWith(color: AppColors.accent),
                    ))
              ],
            ),
          ),
        );
      });

  @override
  Widget get body => _stateView;

  @override
  LabeledGlobalKey<State<StatefulWidget>> get key =>globalKey;

  @override
  Widget get title => Text(
    LocaleKeys.wallet.tr(),
    style: heading5,
  );
}
