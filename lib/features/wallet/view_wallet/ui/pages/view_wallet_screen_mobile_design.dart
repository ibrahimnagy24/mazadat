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
import '../../../../../core/utils/widgets/errors/error_message_widget.dart';
import '../../../../../core/utils/widgets/loading/adaptive_circle_progress.dart';
import '../../../../../core/utils/widgets/misc/custom_scaffold_widget.dart';
import '../../../../../core/utils/widgets/text/main_text.dart';
import '../../../view_wallet_history/logic/view_wallet_history_cubit.dart';
import '../../../view_wallet_history/logic/view_wallet_history_state.dart';
import '../widgets/wallet_balance_card_widget.dart';

class ViewWalletScreenMobileDesign extends StatelessWidget {
  const ViewWalletScreenMobileDesign({super.key});

  @override
  Widget build(BuildContext context) {
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
              const SizedBox(height: 15),
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
                      CustomNavigator.push(Routes.VIEW_WALLET_HISTORY);
                    },
                  )
                ],
              ),
              const SizedBox(height: 12),
              Expanded(
                child: BlocProvider(
                  create: (context) =>
                      ViewWalletHistoryCubit()..viewHistoryStatesHandled(),
                  child: BlocBuilder<ViewWalletHistoryCubit,
                      ViewWalletHistoryState>(
                    builder: (context, state) {
                      if (state is ViewWalletHistoryLoading) {
                        return const Center(child: AdaptiveCircularProgress());
                      }
                      if (state is ViewWalletHistoryError) {
                        return Center(
                          child: ErrorMessageWidget(
                            error: state.error,
                            message: state.error.message,
                            onTap: () {
                              context
                                  .read<ViewWalletHistoryCubit>()
                                  .viewHistoryStatesHandled();
                            },
                          ),
                        );
                      }
                      if (state is ViewWalletHistorySuccess ||
                          context
                                  .read<ViewWalletHistoryCubit>()
                                  .walletHistory !=
                              null) {
                        final cubit = context.read<ViewWalletHistoryCubit>();
                        return ListView.separated(
                          itemBuilder: (context, index) =>
                              WalletHistoryCardWidget(
                            wallet: cubit.walletHistory![index],
                          ),
                          separatorBuilder: (context, index) =>
                              const SizedBox(height: 16),
                          itemCount: cubit.walletHistory!.length,
                        );
                      }
                      return const SizedBox.shrink();
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
