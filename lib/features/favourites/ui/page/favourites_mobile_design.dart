import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/theme/colors/styles.dart';
import '../../../../../core/utils/extensions/extensions.dart';
import '../../../../../core/utils/widgets/misc/custom_scaffold_widget.dart';
import '../../../../core/assets/app_images.dart';
import '../../../../core/services/pagination/pagination_service.dart';
import '../../../../core/theme/text_styles/text_styles.dart';
import '../../../../core/utils/constant/app_strings.dart';
import '../../../../core/utils/extensions/media_query_helper.dart';
import '../../../../core/utils/widgets/animated/animated_widget.dart';
import '../../../../core/utils/widgets/animated/grid_list_animator.dart';
import '../../../../core/utils/widgets/buttons/default_button.dart';
import '../../../../core/utils/widgets/custom_loading_text.dart';
import '../../../../core/utils/widgets/empty/empty_state.dart';
import '../../../../core/utils/widgets/errors/error_message_widget.dart';
import '../../../../core/utils/widgets/shimmer/custom_shimmer.dart';
import '../../../auctions/ui/widgets/grid_auction_card.dart';
import '../../../nav_layout/cubit/navbar_layout_cubit.dart';
import '../../logic/favourites_cubit.dart';
import '../../logic/favourites_state.dart';

class ChooseCategoryMobilePortraitDesignScreen extends StatelessWidget {
  const ChooseCategoryMobilePortraitDesignScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffoldWidget(
      needAppbar: false,
      child: AnnotatedRegion<SystemUiOverlayStyle>(
        value: const SystemUiOverlayStyle(
          statusBarColor: AppColors.transparent,
          statusBarIconBrightness: Brightness.light,
          statusBarBrightness: Brightness.light,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SafeArea(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 24.w,
                  vertical: 24.h,
                ),
                child: Text(
                  AppStrings.favourite.tr,
                  style: AppTextStyles.displayMdBold,
                ),
              ),
            ),
            Expanded(
              child: BlocBuilder<FavouritesCubit, FavouritesState>(
                builder: (context, state) {
                  final cubit = context.read<FavouritesCubit>();
                  if (state is FavouritesLoading) {
                    return GridListAnimator(
                      padding: EdgeInsets.symmetric(horizontal: 24.w),
                      data: List.generate(
                        20,
                        (i) => CustomShimmerContainer(
                          height: 120.h,
                          width: MediaQueryHelper.width,
                        ),
                      ),
                      crossAxisCount: 2,
                      aspectRatio: 0.9,
                    );
                  }
                  if (state is FavouritesSuccess) {
                    return Column(
                      children: [
                        Expanded(
                            child: GridListAnimator(
                          controller: cubit.controller,
                          padding: EdgeInsets.symmetric(horizontal: 24.w),
                          data: List.generate(
                              state.auctions.length,
                              (i) =>
                                  GridAuctionCard(auction: state.auctions[i])),
                          crossAxisCount: 2,
                          aspectRatio: 0.9,
                        )),
                        CustomLoadingText(loading: state.isLoading),
                      ],
                    );
                  }
                  if (state is FavouritesError) {
                    return Padding(
                      padding: EdgeInsets.symmetric(horizontal: 24.w),
                      child: ErrorMessageWidget(
                        error: state.error,
                        onTap: () {
                          cubit.favouritesAuctionStatesHandled(SearchEngine());
                        },
                      ),
                    );
                  }
                  if (state is FavouritesEmpty) {
                    return ListAnimator(
                        padding: EdgeInsets.symmetric(horizontal: 24.w),
                        data: [
                          EmptyState(
                            img: AppImages.emptyFavourites,
                            txt: AppStrings.noFavouriteAuctions.tr,
                            subText: AppStrings.favouriteAuctionHint.tr,
                          ),
                          40.sbH,
                          DefaultButton(
                            text: AppStrings.discoverMore.tr,
                            onPressed: () =>
                                NavbarLayoutCubit.instance.onItemTapped(0),
                          )
                        ]);
                  }
                  return const SizedBox();
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
