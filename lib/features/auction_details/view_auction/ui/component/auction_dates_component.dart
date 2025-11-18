import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../../core/assets/app_svg.dart';
import '../../../../../core/shared/blocs/main_app_bloc.dart';
import '../../../../../core/shared/widgets/custom_images.dart';
import '../../../../../core/theme/colors/styles.dart';
import '../../../../../core/theme/text_styles/text_styles.dart';
import '../../../../../core/utils/constant/app_strings.dart';
import '../../../../../core/utils/extensions/extensions.dart';
import '../../../../../core/utils/widgets/text/main_text.dart';
import '../../data/entity/view_auction_details_entity.dart';
import '../../logic/view_auction_details_cubit.dart';

class AuctionDatesComponent extends StatelessWidget {
  const AuctionDatesComponent({
    super.key,
    required this.auction,
  });

  final ViewAuctionDetailsEntity auction;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (auction.startDate != null)
          _buildDateRow(
            AppStrings.auctionStartDate.tr,
            auction.startDate!,
          ),
        if (auction.endDate != null) const SizedBox(height: 8),
        if (auction.endDate != null)
          _buildDateRow(
            AppStrings.auctionEndDate.tr,
            auction.endDate!,
          ),
      ],
    );
  }

  Widget _buildDateRow(String label, DateTime date) {
    return Row(
      spacing: 8.w,
      children: [
        customImageIconSVG(
          imageName: AppSvg.calendar,
          width: 16.w,
          height: 16.w,
          color: AppColors.textSecondaryParagraph,
        ),
        Expanded(
          child: RichText(
            text: TextSpan(
              text: '$label  ',
              style: AppTextStyles.textLgRegular,
              children: [
                TextSpan(
                  text: date.toDateFormat(
                    format: 'd MMMM yyyy',
                    locale: mainAppBloc.lang.valueOrNull,
                  ),
                  style: AppTextStyles.textLgRegular
                      .copyWith(color: AppColors.textPrimary),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class AuctionAllDatesComponent extends StatelessWidget {
  const AuctionAllDatesComponent({
    super.key,
    required this.cubit,
  });

  final ViewAuctionDetailsCubit cubit;

  @override
  Widget build(BuildContext context) {
    if (cubit.auctionDetails == null) return const SizedBox.shrink();
    if (cubit.auctionDetails!.startDate == null ||
        cubit.auctionDetails!.endDate == null ||
        cubit.auctionDetails!.paymentDeadline == null) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 16),
        MainText(
          text: AppStrings.auctionDate.tr,
          style: AppTextStyles.textLgBold
              .copyWith(color: const Color.fromRGBO(46, 46, 46, 1)),
        ),
        const SizedBox(height: 12),
        if (cubit.auctionDetails!.startDate != null)
          _buildDateRow(
              AppStrings.auctionStartDate.tr, cubit.auctionDetails!.startDate!),
        if (cubit.auctionDetails!.startDate != null) const SizedBox(height: 8),
        if (cubit.auctionDetails!.endDate != null)
          _buildDateRow(AppStrings.auctionEndDate.tr, cubit.auctionDetails!.endDate!),
        if (cubit.auctionDetails!.endDate != null) const SizedBox(height: 8),
        if (cubit.auctionDetails!.paymentDeadline != null)
          _buildDateRow(AppStrings.purchaseDate.tr,
              DateTime.parse(cubit.auctionDetails!.paymentDeadline!)),
      ],
    );
  }

  Widget _buildDateRow(String label, DateTime date) {
    return Row(
      children: [
        SvgPicture.asset(
          AppSvg.calendar,
          height: 14.5,
          width: 14.5,
        ),
        const SizedBox(width: 6),
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: label,
                style: AppTextStyles.textMdRegular.copyWith(
                    color: const Color.fromRGBO(162, 162, 162, 1)),
              ),
              const WidgetSpan(child: SizedBox(width: 4)),
              TextSpan(
                text: date.toDateFormat(
                    format: mainAppBloc.isArabic
                        ? 'd MMMM yyyy \'م\' - h:mm \'م\''
                        : 'd MMMM yyyy - h:mm a',
                    locale: mainAppBloc.lang.valueOrNull),
                style: AppTextStyles.textLgRegular.copyWith(
                    color: const Color.fromRGBO(116, 116, 116, 1)),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
