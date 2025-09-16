import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../../core/assets/app_images.dart';
import '../../../../../core/assets/app_svg.dart';
import '../../../../../core/navigation/custom_navigation.dart';
import '../../../../../core/navigation/routes.dart';
import '../../../../../core/theme/text_styles/text_styles.dart';
import '../../../../../core/utils/constant/app_strings.dart';
import '../../../../../core/utils/extensions/extensions.dart';
import '../../../../../core/utils/widgets/buttons/default_button.dart';
import '../../../../../core/utils/widgets/errors/error_message_widget.dart';
import '../../../../../core/utils/widgets/misc/custom_scaffold_widget.dart';
import '../../../check_out_choose_payment/data/params/checkout_choose_payment_route_params.dart';
import '../../cubit/checkout_summary_cubit.dart';
import '../../cubit/checkout_summary_state.dart';
import '../../data/params/checkout_summary_route_params.dart';
import '../widgets/checkout_countdown_timer_widget.dart';
import '../widgets/checkout_delivery_address_widget.dart';
import '../widgets/checkout_purchase_details_widget.dart';
import '../widgets/checkout_summary_button_widget.dart';
import '../widgets/checkout_summary_header_widget.dart';
import '../widgets/checout_product_details_widget.dart';

class CheckoutSummaryScreen extends StatelessWidget {
  const CheckoutSummaryScreen({
    super.key,
    required this.params,
  });
  final CheckoutSummaryRouteParams params;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CheckoutSummaryCubit()
        ..init(params)
        ..getCheckoutSummaryStatesHandled(),
      child: CustomScaffoldWidget(
        child: BlocConsumer<CheckoutSummaryCubit, CheckoutSummaryState>(
          listener: (context, state) {
            if (state is AutionCheckoutTimeFinished) {
              showModalBottomSheet(
                context: context,
                isDismissible: false,
                enableDrag: false,
                constraints: BoxConstraints(
                  maxWidth: MediaQuery.of(context).size.width,
                  minHeight: 285,
                ),
                builder: (modalContext) {
                  return SafeArea(
                    top: false,
                    left: false,
                    right: false,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 24,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        spacing: 24,
                        children: [
                          Image.asset(
                            AppImages.wrongCircleIcon,
                            width: 90,
                            height: 90,
                          ),
                          Text(
                            AppStrings
                                .theDeadlineToCompleteThePurchaseHasExpired.tr,
                            style: AppTextStyles.displaySMMedium,
                            textAlign: TextAlign.center,
                          ),
                          Text(
                            AppStrings.yourInsuranceAmountWillBeDeducted.tr,
                            style: AppTextStyles.textLgRegular,
                            textAlign: TextAlign.center,
                          ),
                          DefaultButton(
                            onPressed: () {
                              Navigator.pop(modalContext);
                              CustomNavigator.pop();
                            },
                            text: AppStrings.backToAuctionDetails.tr,
                            textStyle: AppTextStyles.bodyXlBold
                                .copyWith(color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            }
            if (state is ValidateSummaryLoaded) {
              CustomNavigator.push(
                Routes.CHECKOUT_CHOOSE_PAYMENT,
                extra: CheckoutChoosePaymentRouteParams(
                  auctionId: params.auctionId,
                  cubit: params.cubit,
                ),
                replace: true,
              );
            }
          },
          buildWhen: (previous, current) =>
              current is CheckoutSummaryLoaded ||
              current is CheckoutSummaryError ||
              current is CheckoutSummaryLoading,
          builder: (context, state) {
            final cubit = context.read<CheckoutSummaryCubit>();
            if (state is CheckoutSummaryLoading) {
              return const SizedBox.shrink();
            }
            if (state is CheckoutSummaryError) {
              return ErrorMessageWidget(
                error: state.error,
                message: state.error.message,
                onTap: () {
                  context
                      .read<CheckoutSummaryCubit>()
                      .getCheckoutSummaryStatesHandled();
                },
              );
            }

            if (cubit.checkoutSummary != null) {
              return const Column(
                children: [
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 24),
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 16),
                            CheckoutSummaryHeaderWidget(),
                            SizedBox(height: 16),
                            CheckoutCountdownTimerWidget(),
                            SizedBox(height: 16),
                            ChecoutProductDetailsWidget(),
                            SizedBox(height: 16),
                            CheckoutDeliveryAddressWidget(),
                            SizedBox(height: 16),
                            CheckoutPurchaseDetailsWidget(),
                            SizedBox(height: 60),
                          ],
                        ),
                      ),
                    ),
                  ),
                  CheckoutSummaryButtonWidget(),
                ],
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
