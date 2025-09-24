import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../../core/shared/blocs/main_app_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/assets/app_images.dart';
import '../../../../../core/theme/colors/styles.dart';
import '../../../../../core/theme/text_styles/text_styles.dart';
import '../../../../../core/utils/constant/app_strings.dart';
import '../../../../../core/utils/extensions/extensions.dart';
import '../../../../../core/utils/widgets/errors/error_message_widget.dart';
import '../../../../../core/utils/widgets/text/main_text.dart';
import '../../logic/view_my_wallet_cubit.dart';
import '../../logic/view_my_wallet_state.dart';
import 'recharge_wallet_bottom_sheet_widget.dart';

class WalletBalanceCardWidget extends StatelessWidget {
  const WalletBalanceCardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ViewMyWalletCubit, ViewMyWalletState>(
      buildWhen: (previous, current) =>
          current is ViewMyWalletLoading ||
          current is ViewMyWalletSuccess ||
          current is ViewMyWalletError,
      builder: (context, state) {
        final cubit = context.read<ViewMyWalletCubit>();
        if (state is ViewMyWalletError) {
          return ErrorMessageWidget(
            error: state.error,
            onTap: () {
              context.read<ViewMyWalletCubit>().viewMyWalletStatesHandled();
            },
          );
        }
        if (cubit.viewMyWalletEntity == null) {
          return const SizedBox.shrink();
        }

        return Container(
          height: 148,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(AppImages.walletBackground),
              fit: BoxFit.cover,
            ),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsetsDirectional.only(
                  top: 12,
                  bottom: 16,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          backgroundColor: Colors.transparent,
                          barrierColor: Colors.transparent,
                          builder: (dialogContext) {
                            return BackdropFilter(
                              filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                              child: RechargeWalletBottomSheetWidget(
                                dialogContext: dialogContext,
                                cubit: context.read<ViewMyWalletCubit>(),
                              ),
                            );
                          },
                        );
                      },
                      child: Image.asset(
                        AppImages.addFloatingIcon,
                        height: 48,
                        width: 48,
                      ),
                    ),
                    GestureDetector(
                      onTap: () => context
                          .read<ViewMyWalletCubit>()
                          .viewMyWalletStatesHandled(),
                      child: Row(
                        children: [
                          Image.asset(
                            AppImages.arrowReloadHorizontal,
                            height: 16,
                            width: 16,
                          ),
                          const SizedBox(width: 4),
                          Builder(builder: (context) {
                            final isArabic = mainAppBloc.isArabic;
                            final dateStr =
                                cubit.viewMyWalletEntity?.lastUpdatedDate;
                            String formattedDate;
                            if (dateStr != null) {
                              try {
                                final dateTime = DateTime.parse(dateStr);
                                final locale = isArabic ? 'ar' : 'en';
                                final format =
                                    DateFormat('d MMMM yyyy', locale);
                                final prefix =
                                    isArabic ? 'تاريخ التحديث' : 'Last updated';
                                formattedDate =
                                    '$prefix ${format.format(dateTime)}';
                              } catch (e) {
                                formattedDate = '';
                              }
                            } else {
                              formattedDate = '';
                            }
                            return MainText(
                              text: formattedDate,
                              style: AppTextStyles.textMdRegular
                                  .copyWith(color: AppColors.kWhite),
                            );
                          })
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MainText(
                    text: AppStrings.currentBalance.tr,
                    style: AppTextStyles.textXLMedium
                        .copyWith(color: AppColors.mainDark),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      MainText(
                        text:
                            cubit.viewMyWalletEntity?.balance.toString() ?? '',
                        style: AppTextStyles.displaySMBold,
                      ),
                      const SizedBox(width: 8),
                      Image.asset(
                        AppImages.saudiRiyalSymbol,
                        height: 21,
                        width: 21,
                      ),
                    ],
                  )
                ],
              )
            ],
          ),
        );
      },
    );
  }
}
