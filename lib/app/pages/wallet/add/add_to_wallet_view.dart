import 'package:coupon_app/app/components/loading_button.dart';
import 'package:coupon_app/app/pages/searchable_view_state.dart';
import 'package:coupon_app/app/pages/wallet/add/add_to_wallet_controller.dart';
import 'package:coupon_app/app/utils/constants.dart';
import 'package:coupon_app/app/utils/locale_keys.dart';
import 'package:coupon_app/app/utils/utility.dart';
import 'package:coupon_app/data/repositories/data_authentication_repository.dart';
import 'package:coupon_app/data/repositories/data_wallet_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

class AddToWalletPage extends View {
  @override
  State<StatefulWidget> createState() => _AddToWalletPageState();
}

class _AddToWalletPageState
    extends SearchableViewState<AddToWalletPage, AddToWalletController> {
  _AddToWalletPageState()
      : super(AddToWalletController(
            DataAuthenticationRepository(), DataWalletRepository()));
  final _formKey = GlobalKey<FormState>();

  get _body => ControlledWidgetBuilder(
          builder: (BuildContext context, AddToWalletController controller) {
        return SizedBox(
          child: Padding(
            padding: const EdgeInsets.all(Dimens.spacingMedium),
            child: ListView(
              shrinkWrap: true,
              children: [

                SizedBox(
                  height: Dimens.spacingLarge,
                ),
                Text(
                  LocaleKeys.addMoneyToWallet.tr(),
                  style: heading4,
                ),
                SizedBox(
                  height: Dimens.spacingLarge,
                ),
                Form(
                  key: _formKey,
                  child: TextFormField(
                    controller: controller.amountTextController,
                    keyboardType: TextInputType.number,
                    maxLength: 5,
                    validator: (value) {
                      if (value.isEmpty) {
                        return LocaleKeys.invalidAmount.tr();
                      }
                      try {
                        var amount = double.parse(value);
                        if (amount <= 0) {
                          return LocaleKeys.invalidAmount.tr();
                        }
                      } catch (e) {
                        if (value.isEmpty) {
                          return LocaleKeys.invalidAmount.tr();
                        }
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      labelText: LocaleKeys.enterAmount.tr(),
                    ),
                  ),
                ),
                SizedBox(
                  height: Dimens.spacingMedium,
                ),
                SizedBox(
                  height: Dimens.spacingLarge,
                ),
                SizedBox(
                    width: double.infinity,
                    child: LoadingButton(
                      onPressed: () {
                        controller.checkForm({
                          'context': context,
                          'formKey': _formKey,
                          'globalKey': globalKey
                        });
                      },
                      isLoading: controller.isLoading,
                      text: LocaleKeys.proceed.tr(),
                    )),
                SizedBox(
                  height: Dimens.spacingLarge,
                ),
              ],
            ),
          ),
        );
      });


  @override
  Widget get body => _body;

  @override
  LabeledGlobalKey<State<StatefulWidget>> get key => globalKey;

  @override
  Widget get title => Text(
        LocaleKeys.addMoneyToWallet.tr(),
        style: heading5,
      );
}
