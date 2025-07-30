import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/navigation/custom_navigation.dart';
import '../../../../../core/navigation/routes.dart';
import '../../../../../core/shared/widgets/wallet_history_card_widget.dart';
import '../../../../../core/theme/colors/styles.dart';
import '../../../../../core/theme/text_styles/app_font_size_styles.dart';
import '../../../../../core/theme/text_styles/text_styles.dart';
import '../../../../../core/utils/constant/app_strings.dart';
import '../../../../../core/utils/extensions/extensions.dart';
import '../../../../../core/utils/widgets/misc/custom_scaffold_widget.dart';
import '../../../../../core/utils/widgets/text/main_text.dart';
import '../../../view_wallet_history/data/params/view_wallet_history_route_params.dart';
import '../../logic/view_my_wallet_cubit.dart';
import '../../logic/view_my_wallet_state.dart';
import '../widgets/wallet_balance_card_widget.dart';

class ViewWalletScreenMobileDesign extends StatelessWidget {
  const ViewWalletScreenMobileDesign({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ViewMyWalletCubit>();
    bool isListNotEmpty =
        cubit.viewMyWalletEntity?.walletHistory.isNotEmpty ?? false;

    return BlocBuilder<ViewMyWalletCubit, ViewMyWalletState>(
      buildWhen: (previous, current) =>
          current is ViewMyWalletLoading ||
          current is ViewMyWalletSuccess ||
          current is ViewMyWalletError,
      builder: (context, state) {
        return CustomScaffoldWidget(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            child: SizedBox(
              width: MediaQuery.sizeOf(context).width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MainText(
                    text: AppStrings.myWallet.tr,
                    style: AppTextStyles.displayMdBold
                        .copyWith(color: AppColors.textPrimarySaFlag),
                  ),
                  const SizedBox(height: 24),
                  const WalletBalanceCardWidget(),
                  if (isListNotEmpty) const SizedBox(height: 15),
                  if (isListNotEmpty)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        MainText(
                          text: AppStrings.transactionHistory.tr,
                          style: AppTextStyles.bodyMBold,
                        ),
                        MainText(
                          text: AppStrings.viewAll.tr,
                          style: AppTextStyles.bodyMBold.copyWith(
                            fontWeight: FontWeight.w500,
                            fontSize: AppFontSizes.fsXs,
                          ),
                          onTap: () {
                            CustomNavigator.push(
                              Routes.VIEW_WALLET_HISTORY,
                              extra: ViewWalletHistoryRouteParams(
                                viewMyWalletCubit: cubit,
                              ),
                            );
                          },
                        )
                      ],
                    ),
                  if (isListNotEmpty) const SizedBox(height: 12),
                  if (isListNotEmpty)
                    Expanded(
                      child: ListView.separated(
                        itemBuilder: (context, index) =>
                            WalletHistoryCardWidget(
                          wallet:
                              cubit.viewMyWalletEntity!.walletHistory[index],
                        ),
                        separatorBuilder: (context, index) =>
                            const SizedBox(height: 16),
                        itemCount:
                            cubit.viewMyWalletEntity!.walletHistory.length,
                      ),
                    ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
