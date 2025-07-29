import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/assets/app_images.dart';
import '../../../../../core/theme/colors/styles.dart';
import '../../../../../core/theme/text_styles/text_styles.dart';
import '../../../../../core/utils/constant/app_constant.dart';
import '../../../../../core/utils/constant/app_strings.dart';
import '../../../../../core/utils/extensions/extensions.dart';
import '../../../../../core/utils/widgets/empty/empty_screen.dart';
import '../../../../../core/utils/widgets/errors/error_message_widget.dart';
import '../../../../../core/utils/widgets/loading/adaptive_circle_progress.dart';
import '../../../../../core/utils/widgets/misc/custom_scaffold_widget.dart';
import '../../../../../core/utils/widgets/text/main_text.dart';
import '../../logic/view_wallet_history_cubit.dart';
import '../../logic/view_wallet_history_state.dart';
import '../../../../../core/shared/widgets/wallet_history_card_widget.dart';

class ViewWalletHistoryScreenMobileDesign extends StatelessWidget {
  const ViewWalletHistoryScreenMobileDesign({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffoldWidget(
      appbarTitle: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Row(
          children: [
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Image.asset(
                AppImages.arrowBlack,
                height: 14,
                width: 14,
              ),
            ),
            const SizedBox(width: 16),
            MainText(
              text: AppStrings.transactionHistory.tr,
              style: AppTextStyles.displayMdBold
                  .copyWith(color: AppColors.textPrimarySaFlag),
            ),
          ],
        ),
      ),
      appbarHeight: AppConstant.appbarheight,
      centerAppbarTitle: false,
      appbarLeading: const SizedBox.shrink(),
      leadingWidth: 1,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: BlocBuilder<ViewWalletHistoryCubit, ViewWalletHistoryState>(
          buildWhen: (previous, current) =>
              current is ViewWalletHistoryLoading ||
              current is ViewWalletHistorySuccess ||
              current is ViewWalletHistoryError,
          builder: (context, state) {
            final cubit = context.read<ViewWalletHistoryCubit>();
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

            if (cubit.walletHistory != null) {
              if (cubit.walletHistory!.isEmpty) {
                return Center(
                  child: EmptyScreen(
                    onRefresh: () async {
                      context
                          .read<ViewWalletHistoryCubit>()
                          .viewHistoryStatesHandled();
                      return;
                    },
                  ),
                );
              }
              return ListView.separated(
                physics: const BouncingScrollPhysics(),
                itemCount: cubit.walletHistory!.length,
                separatorBuilder: (context, index) =>
                    const SizedBox(height: 16),
                padding: const EdgeInsets.symmetric(vertical: 16),
                itemBuilder: (context, index) {
                  return WalletHistoryCardWidget(
                    wallet: cubit.walletHistory![index],
                  );
                },
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
