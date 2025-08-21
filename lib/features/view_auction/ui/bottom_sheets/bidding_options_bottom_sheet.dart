import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/navigation/custom_navigation.dart';
import '../../../../core/services/toast_service.dart';
import '../../../../core/assets/app_svg.dart';
import '../../../../core/shared/widgets/custom_images.dart';
import '../../../../core/shared/widgets/price_widget_with_flag_widget.dart';
import '../../../../core/theme/colors/styles.dart';
import '../../../../core/theme/radius/app_radius.dart';
import '../../../../core/theme/text_styles/text_styles.dart';
import '../../../../core/utils/constant/app_strings.dart';
import '../../../../core/utils/enums/enums.dart';
import '../../../../core/utils/extensions/extensions.dart';
import '../../../../core/utils/extensions/media_query_helper.dart';
import '../../../../core/utils/widgets/buttons/default_button.dart';
import '../../data/params/auction_bid_params.dart';
import '../../logic/view_auction_details_cubit.dart';

class BiddingOptionsBottomSheet extends StatefulWidget {
  const BiddingOptionsBottomSheet({
    super.key,
    required this.cubit,
    required this.bottomSheetContext,
    this.title,
    this.isAutoBidding = false,
    this.needToSelectBiddingMethod = true,
  });

  final ViewAuctionDetailsCubit cubit;
  final BuildContext bottomSheetContext;
  final String? title;
  final bool isAutoBidding;
  final bool needToSelectBiddingMethod;

  @override
  State<BiddingOptionsBottomSheet> createState() =>
      _BiddingOptionsBottomSheetState();
}

class _BiddingOptionsBottomSheetState extends State<BiddingOptionsBottomSheet>
    with TickerProviderStateMixin {
  late BiddingMethod selectedBiddingMethod;
  late double selectedMaxBiddingAmount;
  late AnimationController _priceAnimationController;
  late Animation<double> _priceScaleAnimation;
  late Animation<double> _priceOpacityAnimation;

  @override
  void initState() {
    super.initState();
    selectedBiddingMethod = widget.isAutoBidding
        ? BiddingMethod.auto
        : widget.cubit.auctionDetails!.currentBiddingMethod;
    selectedMaxBiddingAmount =
        widget.cubit.auctionDetails!.currentBiddingAmount +
            widget.cubit.auctionDetails!.biddingIncrementAmount;

    _priceAnimationController = AnimationController(
      duration: const Duration(milliseconds: 250),
      vsync: this,
    );

    // iOS-style spring animation for price changes
    _priceScaleAnimation = Tween<double>(
      begin: 0.95,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _priceAnimationController,
      curve: Curves.easeOutBack,
    ));

    _priceOpacityAnimation = Tween<double>(
      begin: 0.7,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _priceAnimationController,
      curve: Curves.easeOut,
    ));

    _priceAnimationController.forward();
  }

  @override
  void dispose() {
    _priceAnimationController.dispose();
    super.dispose();
  }

  void _updateBiddingMethod(BiddingMethod method) {
    setState(() {
      selectedBiddingMethod = method;
      if (method == BiddingMethod.manual) {
        selectedMaxBiddingAmount =
            widget.cubit.auctionDetails!.currentBiddingAmount +
                widget.cubit.auctionDetails!.biddingIncrementAmount;
      }
    });
  }

  void _updateMaxBiddingAmount(double amount) {
    _priceAnimationController.reset();
    setState(() {
      selectedMaxBiddingAmount = amount;
    });
    _priceAnimationController.forward();
  }

  void _incrementAmount() {
    HapticFeedback.mediumImpact();
    final newAmount = selectedMaxBiddingAmount +
        widget.cubit.auctionDetails!.biddingIncrementAmount;
    _updateMaxBiddingAmount(newAmount);
  }

  void _decrementAmount() {
    final currentPrice = widget.cubit.auctionDetails!.currentBiddingAmount;
    final minAmount =
        currentPrice + widget.cubit.auctionDetails!.biddingIncrementAmount;
    if (selectedMaxBiddingAmount > minAmount) {
      HapticFeedback.mediumImpact();
      final newAmount = selectedMaxBiddingAmount -
          widget.cubit.auctionDetails!.biddingIncrementAmount;
      _updateMaxBiddingAmount(newAmount);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: widget.cubit,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
        child: BlocConsumer<ViewAuctionDetailsCubit, ViewAuctionDetailsState>(
            listener: (context, state) {
              if (state is AuctionBidError) {
                HapticFeedback.mediumImpact();
                ToastService.showError(
                  state.error.message,
                  context: context,
                );
              }
              if (state is AuctionBidSuccess) {
                Navigator.pop(widget.bottomSheetContext);
              }
            },
            buildWhen: (previous, current) =>
                current is AuctionBidLoading ||
                current is AuctionBidSuccess ||
                current is AuctionBidError,
            builder: (context, state) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 8,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          widget.title ?? AppStrings.selectBiddingMethod.tr,
                          style: AppTextStyles.heading,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(widget.bottomSheetContext);
                        },
                        child: const Icon(Icons.clear,
                            size: 24, color: AppColors.textDefault),
                      )
                    ],
                  ),
                  if (widget.needToSelectBiddingMethod)
                    AnimatedSwitcher(
                      duration: const Duration(milliseconds: 300),
                      switchInCurve: Curves.easeOutCubic,
                      switchOutCurve: Curves.easeInCubic,
                      transitionBuilder: (child, animation) {
                        return SlideTransition(
                          position: Tween<Offset>(
                            begin: const Offset(0.0, 0.05),
                            end: Offset.zero,
                          ).animate(animation),
                          child: FadeTransition(
                            opacity: animation,
                            child: child,
                          ),
                        );
                      },
                      child: _SelectBiddingMethod(
                        key: ValueKey(selectedBiddingMethod),
                        selectedValue: selectedBiddingMethod,
                        currentAuctionPrice:
                            widget.cubit.auctionDetails!.currentBiddingAmount,
                        onBiddingMethodChanged: _updateBiddingMethod,
                      ),
                    ),
                  AnimatedBuilder(
                    animation: _priceAnimationController,
                    builder: (context, child) {
                      return Transform.scale(
                        scale: _priceScaleAnimation.value,
                        child: Opacity(
                          opacity: _priceOpacityAnimation.value,
                          child: _SelectMaxBiddingAmount(
                            currentPrice: widget
                                .cubit.auctionDetails!.currentBiddingAmount,
                            biddingIncrementAmount: widget
                                .cubit.auctionDetails!.biddingIncrementAmount,
                            currentBiddingMethod: selectedBiddingMethod,
                            selectedAmount: selectedMaxBiddingAmount,
                            onIncrement: _incrementAmount,
                            onDecrement: _decrementAmount,
                          ),
                        ),
                      );
                    },
                  ),
                  AnimatedSwitcher(
                    duration: const Duration(milliseconds: 350),
                    switchInCurve: Curves.easeOutCubic,
                    switchOutCurve: Curves.easeInCubic,
                    transitionBuilder: (child, animation) {
                      return SizeTransition(
                        sizeFactor: animation,
                        child: FadeTransition(
                          opacity: animation,
                          child: child,
                        ),
                      );
                    },
                    child: selectedBiddingMethod == BiddingMethod.auto
                        ? Container(
                            key: const ValueKey('auto_info'),
                            child: Row(
                              spacing: 4.w,
                              children: [
                                customImageIconSVG(
                                  imageName: AppSvg.money,
                                  width: 16.w,
                                  height: 16.h,
                                  color: AppColors.textSecondaryParagraph,
                                ),
                                Expanded(
                                  child: RichText(
                                    text: TextSpan(
                                      children: [
                                        TextSpan(
                                          text:
                                              AppStrings.currentAuctionPrice.tr,
                                          style: AppTextStyles.textMdRegular
                                              .copyWith(
                                                  color: AppColors
                                                      .textSecondaryParagraph),
                                        ),
                                        TextSpan(
                                          text:
                                              '  ${widget.cubit.auctionDetails!.currentBiddingAmount} ',
                                          style: AppTextStyles.textLgMedium
                                              .copyWith(
                                                  color: AppColors
                                                      .textPrimaryParagraph),
                                        ),
                                        WidgetSpan(
                                          child: customImageIconSVG(
                                              imageName:
                                                  AppSvg.saudiArabiaSymbol,
                                              width: 16.w,
                                              height: 16.w,
                                              color: AppColors
                                                  .textPrimaryParagraph),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                        : const SizedBox.shrink(key: ValueKey('empty')),
                  ),
                  const SizedBox(height: 24),
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    curve: Curves.easeOutCubic,
                    child: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 250),
                      switchInCurve: Curves.easeOutCubic,
                      child: DefaultButton(
                        key: ValueKey(state.runtimeType),
                        text: AppStrings.bid.tr,
                        onPressed: state is AuctionBidLoading
                            ? null
                            : () => widget.cubit.auctionBidStatesHandled(
                                  AuctionBidParams(
                                    auctionId: widget.cubit.auctionDetails!.id,
                                    biddingMethod: selectedBiddingMethod,
                                    maxBiddingValue: selectedMaxBiddingAmount,
                                  ),
                                ),
                        isLoading: state is AuctionBidLoading,
                      ),
                    ),
                  ),
                ],
              );
            }),
      ),
    );
  }
}

class _SelectBiddingMethod extends StatelessWidget {
  const _SelectBiddingMethod({
    required this.currentAuctionPrice,
    required this.selectedValue,
    required this.onBiddingMethodChanged,
    super.key,
  });

  final double currentAuctionPrice;
  final BiddingMethod selectedValue;
  final Function(BiddingMethod) onBiddingMethodChanged;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 12,
        children: [
          Text(
            AppStrings.selectBiddingMethod.tr,
            style: AppTextStyles.textLgBold,
          ),
          Wrap(
            alignment: WrapAlignment.start,
            spacing: 8,
            runSpacing: 8,
            runAlignment: WrapAlignment.start,
            children: List.generate(
              BiddingMethod.values.length,
              (i) => GestureDetector(
                onTap: () => onBiddingMethodChanged(BiddingMethod.values[i]),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  curve: Curves.easeOutCubic,
                  padding:
                      EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                  decoration: BoxDecoration(
                    color: selectedValue == BiddingMethod.values[i]
                        ? AppColors.kPrimary.withValues(alpha: 0.1)
                        : AppColors.kWhite,
                    border: Border.all(
                      color: selectedValue == BiddingMethod.values[i]
                          ? AppColors.borderPrimary
                          : AppColors.borderNeutralSecondary,
                      width:
                          selectedValue == BiddingMethod.values[i] ? 1.5 : .6,
                    ),
                    borderRadius: BorderRadius.circular(AppRadius.rS),
                  ),
                  child: AnimatedDefaultTextStyle(
                    duration: const Duration(milliseconds: 200),
                    curve: Curves.easeOutCubic,
                    style: selectedValue == BiddingMethod.values[i]
                        ? AppTextStyles.textMdBold
                        : AppTextStyles.textMdRegular,
                    child: Text('${BiddingMethod.values[i].name}_bidding'.tr),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SelectMaxBiddingAmount extends StatelessWidget {
  const _SelectMaxBiddingAmount({
    required this.currentPrice,
    required this.biddingIncrementAmount,
    required this.currentBiddingMethod,
    required this.selectedAmount,
    required this.onIncrement,
    required this.onDecrement,
  });
  final double currentPrice, biddingIncrementAmount;
  final BiddingMethod currentBiddingMethod;
  final double selectedAmount;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 12.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 12.h,
        children: [
          if (currentBiddingMethod == BiddingMethod.auto)
            Text(
              AppStrings.selectMaxBiddingAmount.tr,
              style: AppTextStyles.textLgBold,
            ),
          Stack(
            children: [
              Container(
                width: MediaQueryHelper.width,
                padding: EdgeInsets.symmetric(
                  horizontal: 18.w,
                  vertical: 18.h,
                ),
                decoration: BoxDecoration(
                  color: AppColors.kWhite,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: AppColors.border),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    if (currentBiddingMethod == BiddingMethod.auto)
                      Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: onDecrement,
                          borderRadius: BorderRadius.circular(8.w),
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 150),
                            curve: Curves.easeOutCubic,
                            width: 32.w,
                            height: 32.w,
                            padding: EdgeInsets.symmetric(
                              horizontal: 6.w,
                              vertical: 6.h,
                            ),
                            decoration: BoxDecoration(
                                color: AppColors.borderDefault,
                                borderRadius: BorderRadius.circular(8.w)),
                            child: Text(
                              '—',
                              style: AppTextStyles.textLgBold.copyWith(
                                  fontSize: 17,
                                  color: AppColors.HEADER,
                                  height: 1),
                            ),
                          ),
                        ),
                      ),
                    PriceWidgetWithFlagWidget(
                      price:
                          '${(currentBiddingMethod == BiddingMethod.manual) ? (currentPrice + biddingIncrementAmount) : selectedAmount}',
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      colorFilter: const ColorFilter.mode(
                        AppColors.kPrimary,
                        BlendMode.srcIn,
                      ),
                      priceStyle: AppTextStyles.displaySMMedium
                          .copyWith(color: AppColors.kPrimary, fontSize: 20),
                    ),
                    if (currentBiddingMethod == BiddingMethod.auto)
                      Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: onIncrement,
                          borderRadius: BorderRadius.circular(8.w),
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 150),
                            curve: Curves.easeOutCubic,
                            width: 32.w,
                            height: 32.w,
                            decoration: BoxDecoration(
                                border: Border.all(color: AppColors.kPrimary),
                                borderRadius: BorderRadius.circular(8.w)),
                            child: const Icon(
                              Icons.add,
                              color: AppColors.HEADER,
                              size: 24,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
              PositionedDirectional(
                top: 0,
                start: 20,
                child: Transform.translate(
                  offset: const Offset(0, -10),
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: AppColors.kWhite,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      currentBiddingMethod == BiddingMethod.auto
                          ? AppStrings.selectedPrice.tr
                          : AppStrings.currentPrice.tr,
                      style: AppTextStyles.textMdRegular,
                    ),
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
