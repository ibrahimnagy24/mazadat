import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../core/assets/app_svg.dart';
import '../../../../core/navigation/custom_navigation.dart';
import '../../../../core/navigation/routes.dart';
import '../../../../core/theme/colors/styles.dart';
import '../../../../core/theme/radius/app_radius.dart';
import '../../../../core/theme/text_styles/text_styles.dart';
import '../../../../core/utils/constant/app_strings.dart';
import '../../../../core/utils/extensions/extensions.dart';
import '../../../../core/utils/widgets/misc/default_network_image.dart';
import '../../../../core/utils/widgets/text/main_text.dart';
import '../../../auctions/data/entity/auction_entity.dart';
import '../../../auction_details/data/params/auction_details_route_params.dart';
import '../../logic/search_result_cubit.dart';

class SearchResultCard extends StatelessWidget {
  const SearchResultCard(
      {super.key, required this.auction, this.withClear = true});
  final AuctionEntity auction;
  final bool withClear;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => CustomNavigator.push(
        Routes.AUCTION_DETAILS,
        extra: AuctionDetailsRouteParams(
            auctionId: auction.id, primaryImage: auction.primaryPhoto),
      ),
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 8.h),
        padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppRadius.rM),
          color: AppColors.fillColor,
          border: Border.all(color: AppColors.kGeryText8),
        ),
        child: Row(
          spacing: 12.w,
          children: [
            DefaultNetworkImage(
              auction.primaryPhoto,
              width: 80.w,
              height: 80.w,
              raduis: AppRadius.rMd.w,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                spacing: 8.h,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          auction.name,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: AppTextStyles.textLgMedium,
                        ),
                      ),
                      if (withClear)
                        InkWell(
                            onTap: () => context
                                .read<SearchResultCubit>()
                                .onDeleteItem(auction.searchId),
                            child: const Icon(
                              Icons.clear,
                              color: AppColors.iconDefault,
                              size: 24,
                            ))
                    ],
                  ),
                  Text(
                    auction.description,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppTextStyles.bodyXsReq,
                  ),
                  Row(
                    spacing: 4.w,
                    children: [
                      MainText(
                        text: AppStrings.openingPrice.tr,
                        style: AppTextStyles.textMdRegular
                            .copyWith(color: AppColors.textSecondaryParagraph),
                      ),
                      MainText(
                        text: auction.openingPrice,
                        style: AppTextStyles.textLgBold
                            .copyWith(color: AppColors.textPrimary),
                      ),
                      SvgPicture.asset(AppSvg.saudiArabiaSymbol,
                          color: AppColors.textPrimary),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
