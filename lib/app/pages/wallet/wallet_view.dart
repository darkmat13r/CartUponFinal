import 'package:coupon_app/app/components/state_view.dart';
import 'package:coupon_app/app/pages/searchable_view_state.dart';
import 'package:coupon_app/app/pages/wallet/wallet_controller.dart';
import 'package:coupon_app/app/utils/constants.dart';
import 'package:coupon_app/app/utils/date_helper.dart';
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

class _WalletPageState extends SearchableViewState<WalletPage, WalletController>
    with SingleTickerProviderStateMixin {
  _WalletPageState()
      : super(WalletController(
            DataAuthenticationRepository(), DataWalletRepository()));
  TabController _tabController;

  get _credited => ControlledWidgetBuilder(
          builder: (BuildContext context, WalletController controller) {
        return StateView(
          controller.transactions != null &&
                  controller.transactions.walletData != null &&
                  controller.transactions.walletData.length > 0
              ? EmptyState.CONTENT
              : EmptyState.EMPTY,
          ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: controller.transactions != null &&
                      controller.transactions.walletData != null
                  ? controller.transactions.walletData.length
                  : 0,
              itemBuilder: (BuildContext context, int index) {
                var entry = controller.transactions.walletData[index];
                return Card(
                  child: Padding(
                    padding: const EdgeInsets.all(Dimens.spacingNormal),
                    child: Row(
                      children: [
                        Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                          DateHelper.formatServerDate(entry.created_at),
                          style: captionNormal1.copyWith(
                                  color: AppColors.neutralGray),
                        ),
                                Text(
                                 Utility.capitalize( entry.pay_status.toLowerCase()),
                                  style: captionNormal1.copyWith(
                                      color: _getColorByState(entry.pay_status)),
                                ),
                              ],
                            )),
                        Text(
                          Utility.currencyFormat(entry.amount),
                          style: bodyTextNormal1,
                        )
                      ],
                    ),
                  ),
                );
              }),
        );
      });

  _getColorByState(String status){
    if(status.toLowerCase() == 'initiated'){
      return AppColors.neutralLightGray;
    }
    if(status.toLowerCase() == 'captured'){
      return AppColors.green;
    }

    return AppColors.neutralDark;
  }
  get _debited => ControlledWidgetBuilder(
          builder: (BuildContext context, WalletController controller) {
        return StateView(
          controller.transactions != null &&
                  controller.transactions.walletUsed != null &&
                  controller.transactions.walletUsed.length > 0
              ? EmptyState.CONTENT
              : EmptyState.EMPTY,
          ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: controller.transactions != null &&
                      controller.transactions.walletUsed != null
                  ? controller.transactions.walletUsed.length
                  : 0,
              itemBuilder: (BuildContext context, int index) {
                var entry = controller.transactions.walletUsed[index];
                return Card(
                  child: Padding(
                    padding: const EdgeInsets.all(Dimens.spacingNormal),
                    child: Row(
                      children: [
                        Expanded(
                            child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              DateHelper.formatServerDate(entry.created_at),
                              style: captionNormal1.copyWith(
                                  color: AppColors.neutralGray),
                            ),
                            SizedBox(
                              height: Dimens.spacingSmall,
                            ),
                            Text(
                              LocaleKeys.orderNo.tr(),
                              style: captionNormal2.copyWith(
                                  color: AppColors.neutralGray),
                            ),
                            Text(
                              entry.order_no,
                              style: captionNormal1.copyWith(
                                  color: AppColors.neutralDark),
                            ),
                          ],
                        )),
                        Text(
                          Utility.currencyFormat(entry.total),
                          style: bodyTextNormal1,
                        )
                      ],
                    ),
                  ),
                );
              }),
        );
      });

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

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
            Padding(
              padding: const EdgeInsets.all(Dimens.spacingNormal),
              child: Column(
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: _currentBalance,
                  ),
                  _tabs,
                  _getTabContent(_tabController.index)
                ],
              ),
            ),
          ],
        );
      });

  _getTabContent(int index) {
    if(index  == 0){
      return _credited;
    }
    return _debited;
  }

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
                  Utility.currencyFormat(controller.transactions != null && controller.transactions.customer != null
                      ? (controller.transactions.customer.wallet_balance ?? "0")
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
  LabeledGlobalKey<State<StatefulWidget>> get key => globalKey;

  @override
  Widget get title => Text(
        LocaleKeys.wallet.tr(),
        style: heading5,
      );

  get _tabs => ControlledWidgetBuilder(
          builder: (BuildContext context, WalletController controller) {
        return TabBar(
          unselectedLabelColor: AppColors.neutralDark,
          labelColor: AppColors.primary,
          tabs: [
            Tab(
              text: LocaleKeys.walletDeposit.tr(),
            ),
            Tab(
              text: LocaleKeys.walletUsed.tr(),
            )
          ],
          onTap: (index) {
            setState(() {});
          },
          controller: _tabController,
          indicatorSize: TabBarIndicatorSize.tab,
        );
      });
}
