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
import '../../../../core/utils/widgets/animated/grid_list_animator.dart';
import '../../../../core/utils/widgets/buttons/default_button.dart';
import '../../../../core/utils/widgets/custom_loading_text.dart';
import '../../../../core/utils/widgets/errors/error_message_widget.dart';
import '../../../../core/utils/widgets/shimmer/custom_shimmer.dart';
import '../../../../core/utils/widgets/text/main_text.dart';
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
                        style: AppTextStyles.displayMdBold.copyWith(
                          color: const Color.fromRGBO(34, 39, 21, 1),
                        ),
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
                                    horizontal: 24,
                                  ),
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
                                      SearchEngine(),
                                    );
                              },
                            ),
                          );
                        }
                        if (state is FavouritesEmpty) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 40),
                            child: Column(
                              children: [
                                Image.asset(
                                  AppImages.emptyFavourites,
                                  height: 271,
                                  width: 271,
                                ),
                                48.sbH,
                                MainText(
                                  text: AppStrings
                                      .noFavoriteAuctionsHaveBeenAddedYet
                                      .tr,
                                  style: AppTextStyles.displayMdSemiBold
                                      .copyWith(
                                        color: const Color.fromRGBO(
                                          81,
                                          94,
                                          50,
                                          1,
                                        ),
                                      ),
                                  textAlign: TextAlign.center,
                                ),
                                12.sbH,
                                MainText(
                                  text: AppStrings
                                      .startAddingTheAuctionYouLikeToYourFavoritesForEasyAccessLater
                                      .tr,
                                  style: AppTextStyles.textLgRegular.copyWith(
                                    color: const Color.fromRGBO(
                                      116,
                                      116,
                                      116,
                                      1,
                                    ),
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                40.sbH,
                                SizedBox(
                                  width: 150,
                                  child: DefaultButton(
                                    text: AppStrings.discoverMore.tr,
                                    onPressed: () => NavbarLayoutCubit.instance
                                        .onItemTapped(0),
                                    width: 150,
                                    height: 48,
                                    borderRadiusValue: 8,
                                    textStyle: AppTextStyles.textXLBold
                                        .copyWith(
                                          color: const Color.fromRGBO(
                                            255,
                                            255,
                                            255,
                                            1,
                                          ),
                                        ),
                                    backgroundColor: const Color.fromRGBO(
                                      81,
                                      94,
                                      50,
                                      1,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        }
                        return const SizedBox();
                      },
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
