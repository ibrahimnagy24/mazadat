import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/navigation/custom_navigation.dart';
import '../../../../core/navigation/routes.dart';
import '../../../../core/shared/widgets/autcion_cards/auction_card_widget.dart';
import '../../../../core/shared/widgets/autcion_cards/stacked_auction_card_widget.dart';
import '../../../../core/utils/extensions/extensions.dart';
import '../../../../core/utils/widgets/empty/responsive_empty_widget.dart';
import '../../../../core/utils/widgets/errors/error_message_widget.dart';
import '../../../../core/utils/widgets/loading/logo_loading.dart';
import '../../../home/data/enum/displayed_types.dart';
import '../../../auction_details/view_auction/data/params/view_auction_details_route_params.dart';
import '../../logic/my_auctions_cubit.dart';
import '../../logic/my_auctions_state.dart';

class MyAuctionsDisplayedAuctionsWidget extends StatelessWidget {
  const MyAuctionsDisplayedAuctionsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MyAuctionsCubit, MyAuctionsState>(
      buildWhen: (previous, current) =>
          current is MyAuctionsDisplayedTypeChanged ||
          current is MyAuctionsLoading ||
          current is MyAuctionsLoaded ||
          current is MyAuctionsError,
      builder: (context, state) {
        final cubit = context.read<MyAuctionsCubit>();
        if (state is MyAuctionsLoading) {
          return const LogoLoadingWidget();
        }
        if (state is MyAuctionsError) {
          return Center(
            child: ErrorMessageWidget(
              error: state.error,
              onTap: () {
                cubit.myAuctionsStatesHandled();
              },
              message: state.error.message,
            ),
          );
        }
        if (cubit.myAuctions != null && cubit.myAuctions!.isNotEmpty) {
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
                      return AuctionCardWidget(
                        auctionId: cubit.myAuctions![index].id,
                        image: cubit.myAuctions![index].primaryPhoto,
                        auctionType: cubit.myAuctions![index].auctionType,
                        auctionStatus: cubit.myAuctions![index].auctionStatus,
                        needFavouriteIcon: true,
                        isFav: false,
                        startDate: cubit.myAuctions![index].startDate,
                        endDate: cubit.myAuctions![index].endDate,
                        fianancePrice: cubit.myAuctions![index].openingPrice,
                        onTap: () {
                          CustomNavigator.push(
                            Routes.VIEW_AUCTION_DETAILS,
                            extra: ViewAuctionDetailsRouteParams(
                              auctionId: cubit.myAuctions![index].id,
                              primaryImage:
                                  cubit.myAuctions![index].primaryPhoto,
                            ),
                          );
                        },
                      );
                    },
                    itemCount: cubit.myAuctions!.length,
                  )
                : ListView.builder(
                    key: const ValueKey('list_view'),
                    itemCount: cubit.myAuctions!.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: StackedAuctionCardWidget(
                          image: cubit.myAuctions![index].primaryPhoto,
                          auctionType: cubit.myAuctions![index].auctionType,
                          auctionStatus: cubit.myAuctions![index].auctionStatus,
                          auctionId: cubit.myAuctions![index].id,
                          startDate: cubit.myAuctions![index].startDate,
                          endDate: cubit.myAuctions![index].endDate,
                          auctionFianancePrice:
                              cubit.myAuctions![index].openingPrice,
                          onTap: () {
                            CustomNavigator.push(
                              Routes.VIEW_AUCTION_DETAILS,
                              extra: ViewAuctionDetailsRouteParams(
                                auctionId: cubit.myAuctions![index].id,
                                primaryImage:
                                    cubit.myAuctions![index].primaryPhoto,
                              ),
                            );
                          },
                          height: 213,
                          isFav: false,
                        ),
                      );
                    },
                  ),
          );
        }
        if (cubit.myAuctions == null || cubit.myAuctions!.isEmpty) {
          return ResponsiveEmptyWidget(
            onTap: () {
              cubit.myAuctionsStatesHandled();
            },
            title: 'No Auctions'.tr,
            subtitle: 'No auctions found'.tr,
          );
        }
        return SizedBox.fromSize();
      },
    );
  }
}
