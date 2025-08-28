import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/navigation/custom_navigation.dart';
import '../../../../core/navigation/routes.dart';
import '../../../../core/shared/widgets/autcion_cards/auction_card_widget.dart';
import '../../../../core/shared/widgets/autcion_cards/stacked_auction_card_widget.dart';
import '../../../../core/utils/widgets/empty/responsive_empty_widget.dart';
import '../../../../core/utils/widgets/errors/error_message_widget.dart';
import '../../../../core/utils/widgets/loading/logo_loading.dart';
import '../../../../core/global_favourites/global_favourites.dart';
import '../../../view_auction/data/params/view_auction_details_route_params.dart';
import '../../data/enum/displayed_types.dart';
import '../../logic/home_cubit.dart';
import '../../logic/home_state.dart';

class HomeDisplayedAuctionsWidget extends StatelessWidget {
  const HomeDisplayedAuctionsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      buildWhen: (previous, current) =>
          current is HomeDisplayedTypeChanged ||
          current is HomeAutionsLoading ||
          current is HomeAutionsSuccess ||
          current is HomeAutionsError,
      builder: (context, state) {
        final cubit = context.read<HomeCubit>();
        if (state is HomeAutionsLoading) {
          return const LogoLoadingWidget();
        }
        if (state is HomeAutionsError) {
          return Center(
            child: ErrorMessageWidget(
              error: state.error,
              onTap: () {
                cubit.getSuitableData();
              },
              message: state.error.message,
            ),
          );
        }
        if (cubit.homeAuctions != null && cubit.homeAuctions!.isNotEmpty) {
          return AnimatedSwitcher(
            duration: const Duration(milliseconds: 250),
            transitionBuilder: (Widget child, Animation<double> animation) {
              return FadeTransition(
                opacity: CurvedAnimation(
                  parent: animation,
                  curve: Curves.easeInOut,
                ),
                child: child,
              );
            },
            child: cubit.displayedType == HomeDisplayedTypes.grid
                ? GridView.builder(
                    key: const ValueKey('grid_view'),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                      mainAxisExtent: 213,
                    ),
                    itemBuilder: (context, index) {
                      return BlocBuilder<GlobalFavouritesCubit,
                          GlobalFavouritesState>(
                        bloc: GlobalFavouritesService.getCubit(),
                        builder: (context, state) {
                          final auctionId = cubit.homeAuctions![index].id;
                          final isFavourite =
                              GlobalFavouritesService.isFavourite(auctionId);

                          return AuctionCardWidget(
                            auctionId: cubit.homeAuctions![index].id,
                            image: cubit.homeAuctions![index].primaryPhoto,
                            auctionType: cubit.homeAuctions![index].auctionType,
                            auctionStatus:
                                cubit.homeAuctions![index].auctionStatus,
                            needFavouriteIcon: true,
                            isFav: isFavourite,
                            startDate: cubit.homeAuctions![index].startDate,
                            endDate: cubit.homeAuctions![index].endDate,
                            fianancePrice:
                                cubit.homeAuctions![index].openingPrice,
                            onTap: () {
                              CustomNavigator.push(
                                Routes.VIEW_AUCTION_DETAILS,
                                extra: ViewAuctionDetailsRouteParams(
                                  auctionId: cubit.homeAuctions![index].id,
                                  primaryImage:
                                      cubit.homeAuctions![index].primaryPhoto,
                                ),
                              );
                            },
                          );
                        },
                      );
                    },
                    itemCount: cubit.homeAuctions!.length,
                  )
                : ListView.builder(
                    key: const ValueKey('list_view'),
                    itemCount: cubit.homeAuctions!.length,
                    itemBuilder: (context, index) {
                      final auctionId = cubit.homeAuctions![index].id;
                      final isFavourite =
                          GlobalFavouritesService.isFavourite(auctionId);

                      return Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: StackedAuctionCardWidget(
                          image: cubit.homeAuctions![index].primaryPhoto,
                          auctionType: cubit.homeAuctions![index].auctionType,
                          auctionStatus:
                              cubit.homeAuctions![index].auctionStatus,
                          auctionId: cubit.homeAuctions![index].id,
                          startDate: cubit.homeAuctions![index].startDate,
                          endDate: cubit.homeAuctions![index].endDate,
                          auctionFianancePrice:
                              cubit.homeAuctions![index].openingPrice,
                          onTap: () {
                            CustomNavigator.push(
                              Routes.VIEW_AUCTION_DETAILS,
                              extra: ViewAuctionDetailsRouteParams(
                                auctionId: cubit.homeAuctions![index].id,
                                primaryImage:
                                    cubit.homeAuctions![index].primaryPhoto,
                              ),
                            );
                          },
                          height: 213,
                          isFav: isFavourite,
                        ),
                      );
                    },
                  ),
          );
        }
        if (cubit.homeAuctions == null || cubit.homeAuctions!.isEmpty) {
          return ResponsiveEmptyWidget(
            onTap: () {
              cubit.getSuitableData();
            },
            title: 'No Auctions',
            subtitle: 'No auctions found',
          );
        }
        return SizedBox.fromSize();
      },
    );
  }
}
