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
import '../../../../core/utils/utility.dart';
import '../../../../core/utils/widgets/animated/animated_widget.dart';
import '../../../../core/utils/widgets/animated/grid_list_animator.dart';
import '../../../../core/utils/widgets/buttons/default_button.dart';
import '../../../../core/utils/widgets/custom_loading_text.dart';
import '../../../../core/utils/widgets/empty/empty_state.dart';
import '../../../../core/utils/widgets/errors/error_message_widget.dart';
import '../../../../core/utils/widgets/shimmer/custom_shimmer.dart';
import '../../../auctions/ui/widgets/grid_auction_card.dart';
import '../../../nav_layout/cubit/navbar_layout_cubit.dart';
import '../../../visitor/ui/pages/visitor_screen.dart';
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
          statusBarIconBrightness: Brightness.dark,
          statusBarBrightness: Brightness.light,
          systemNavigationBarColor: Colors.white,
          systemNavigationBarIconBrightness: Brightness.dark,
        ),
        child: !Utility.isUserLoggedIn()
            ? const VisitorScreen()
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SafeArea(
                    bottom: false,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 24,
                      ),
                      child: Text(
                        AppStrings.favourite.tr,
                        style: AppTextStyles.displayMdBold,
                      ),
                    ),
                  ),
                  Expanded(
                    child: BlocBuilder<FavouritesCubit, FavouritesState>(
                      bloc: FavouritesCubit.instance,
                      builder: (context, state) {
                        final cubit = FavouritesCubit.instance;
                        if (state is FavouritesLoading) {
                          return GridListAnimator(
                            padding: const EdgeInsets.symmetric(horizontal: 24),
                            data: List.generate(
                              20,
                              (i) => CustomShimmerContainer(
                                height: 120,
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
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 24),
                                  data: List.generate(
                                    state.auctions.length,
                                    (i) => GridAuctionCard(
                                      auction: state.auctions[i],
                                      height: 190,
                                    ),
                                  ),
                                  crossAxisCount: 2,
                                  aspectRatio: .75,
                                ),
                              ),
                              CustomLoadingText(loading: state.isLoading),
                            ],
                          );
                        }
                        if (state is FavouritesError) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 24),
                            child: ErrorMessageWidget(
                              error: state.error,
                              onTap: () {
                                FavouritesCubit.instance
                                    .favouritesAuctionStatesHandled(
                                        SearchEngine());
                              },
                            ),
                          );
                        }
                        if (state is FavouritesEmpty) {
                          return ListAnimator(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 24),
                              data: [
                                EmptyState(
                                  img: AppImages.emptyFavourites,
                                  txt: AppStrings.noFavouriteAuctions.tr,
                                  subText: AppStrings.favouriteAuctionHint.tr,
                                ),
                                40.sbH,
                                DefaultButton(
                                  text: AppStrings.discoverMore.tr,
                                  onPressed: () => NavbarLayoutCubit.instance
                                      .onItemTapped(0),
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
