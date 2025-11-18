import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../../core/assets/app_svg.dart';
import '../../../../../core/navigation/custom_navigation.dart';
import '../../../../../core/navigation/routes.dart';
import '../../../../../core/theme/radius/app_radius.dart';
import '../../../../../core/theme/text_styles/text_styles.dart';
import '../../../../../core/utils/constant/app_strings.dart';
import '../../../../../core/utils/extensions/extensions.dart';
import '../../../../../core/utils/widgets/misc/default_network_image.dart';
import '../../../../../core/utils/widgets/text/main_text.dart';
import '../../../../auctions/data/entity/auction_entity.dart';
import '../../../../auction_details/view_auction/data/params/view_auction_details_route_params.dart';
import '../../logic/search_result_cubit.dart';

class SearchResultCard extends StatelessWidget {
  const SearchResultCard({
    super.key,
    required this.auction,
    this.withClear = true,
  });
  final AuctionEntity auction;
  final bool withClear;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => CustomNavigator.push(
        Routes.VIEW_AUCTION_DETAILS,
        extra: ViewAuctionDetailsRouteParams(
          auctionId: auction.id,
          primaryImage: auction.primaryPhoto,
        ),
      ),
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8),
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppRadius.rM),
          color: const Color.fromRGBO(255, 255, 255, 0.5),
          border: Border.all(color: const Color.fromRGBO(232, 232, 232, 1)),
        ),
        child: Row(
          spacing: 12,
          children: [
            DefaultNetworkImage(
              auction.primaryPhoto,
              width: 80,
              height: 80,
              radius: AppRadius.rMd,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                spacing: 8,
                children: [
                  Padding(
                    padding: const EdgeInsetsDirectional.only(end: 8),
                    child: Row(
                      children: [
                        Expanded(
                          child: MainText(
                            text: auction.name,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: AppTextStyles.textLgMedium.copyWith(
                              color: const Color.fromRGBO(34, 39, 21, 1),
                            ),
                          ),
                        ),
                        if (withClear)
                          InkWell(
                            onTap: () => context
                                .read<SearchResultCubit>()
                                .onDeleteItem(auction.searchId),
                            child: const Icon(
                              Icons.clear,
                              color: Color.fromRGBO(162, 162, 162, 1),
                              size: 18,
                            ),
                          ),
                      ],
                    ),
                  ),
                  Text(
                    auction.description,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppTextStyles.bodyXsReqCairo.copyWith(
                      color: const Color.fromRGBO(116, 116, 116, 1),
                    ),
                  ),
                  Row(
                    spacing: 6,
                    children: [
                      MainText(
                        text: AppStrings.openingPrice.tr,
                        style: AppTextStyles.textSmRegular.copyWith(
                          color: const Color.fromRGBO(162, 162, 162, 1),
                        ),
                      ),
                      MainText(
                        text: auction.openingPrice,
                        style: AppTextStyles.textMdMedium.copyWith(
                          color: const Color.fromRGBO(81, 94, 50, 1),
                        ),
                      ),
                      SvgPicture.asset(
                        AppSvg.saudiArabiaSymbol,
                        color: const Color.fromRGBO(81, 94, 50, 1),
                        height: 13,
                        width: 13,
                      ),
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
