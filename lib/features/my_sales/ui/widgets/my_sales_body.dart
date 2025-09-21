import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/navigation/custom_navigation.dart';
import '../../../../core/navigation/routes.dart';
import '../../../../core/utils/widgets/empty/responsive_empty_widget.dart';
import '../../../../core/utils/widgets/errors/error_message_widget.dart';
import '../../../../core/utils/widgets/loading/logo_loading.dart';
import '../../../../core/utils/extensions/extensions.dart';
import '../../../auction_details/view_auction/data/params/view_auction_details_route_params.dart';
import '../../data/entity/auction_entity.dart';
import '../../data/enum/display_types.dart';
import '../../logic/my_sales_cubit.dart';
import '../../logic/my_sales_state.dart';
import 'auction_card_widget.dart';
import 'stacked_auction_card_widget.dart';

class MySalesBody extends StatelessWidget {
  const MySalesBody({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<MySalesCubit>();
    return Expanded(
      child: BlocBuilder<MySalesCubit, MySalesState>(
        buildWhen: (previous, current) =>
            current is MySalesLoading ||
            current is MySalesSuccess ||
            current is MySalesError ||
            current is MySalesDisplayTypeChanged ||
            current is MySalesSearchLoading ||
            current is MySalesSearchSuccess ||
            current is MySalesSearchError ||
            current is MySalesSearchEmpty,
        builder: (context, state) {
          // Determine which data to display
          List<AuctionEntity>? currentData;
          bool isSearching = cubit.currentSearchQuery.isNotEmpty;

          if (isSearching) {
            // Use search results if searching
            if (state is MySalesSearchSuccess) {
              currentData = state.searchResults;
            } else if (cubit.searchResults != null) {
              currentData = cubit.searchResults;
            }
          } else {
            // Use regular auctions data
            if (state is MySalesSuccess) {
              currentData = state.auctions;
            } else if (cubit.auctions != null) {
              currentData = cubit.auctions;
            }
          }

          // Loading states
          if (state is MySalesLoading) {
            return const LogoLoadingWidget();
          }

          // Error states
          if (state is MySalesError) {
            return Center(
              child: ErrorMessageWidget(
                error: state.error,
                onTap: () {
                  cubit.getAuctions();
                },
                message: state.error.message,
              ),
            );
          }

          if (state is MySalesSearchError) {
            return Center(
              child: ErrorMessageWidget(
                error: state.error,
                onTap: () {
                  cubit.searchAuctions(cubit.currentSearchQuery);
                },
                message: state.error.message,
              ),
            );
          }

          // Empty states
          if (state is MySalesSearchEmpty ||
              (isSearching && (currentData == null || currentData.isEmpty))) {
            return ResponsiveEmptyWidget(
              onTap: () {
                cubit.searchAuctions(cubit.currentSearchQuery);
              },
              title: 'No Search Results'.tr,
              subtitle: 'No auctions found for your search'.tr,
            );
          }

          if (!isSearching && (currentData == null || currentData.isEmpty)) {
            return ResponsiveEmptyWidget(
              onTap: () {
                cubit.getAuctions();
              },
              title: 'No Auctions'.tr,
              subtitle: 'No auctions found'.tr,
            );
          }

          // Data display
          if (currentData != null && currentData.isNotEmpty) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: AnimatedSwitcher(
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
                child: cubit.displayType == MySalesDisplayTypes.list
                    ? ListView.builder(
                        key: const ValueKey('list_view'),
                        itemCount: currentData.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 16),
                            child: StackedAuctionCardWidget(
                              auction: currentData![index],
                              height: 210,
                              onTap: () {
                                CustomNavigator.push(
                                  Routes.VIEW_AUCTION_DETAILS,
                                  extra: ViewAuctionDetailsRouteParams(
                                    auctionId: currentData![index].id,
                                  ),
                                );
                              },
                            ),
                          );
                        },
                      )
                    : GridView.builder(
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
                            auction: currentData![index],
                            onTap: () {
                              CustomNavigator.push(
                                Routes.VIEW_AUCTION_DETAILS,
                                extra: ViewAuctionDetailsRouteParams(
                                  auctionId: currentData![index].id,
                                ),
                              );
                            },
                          );
                        },
                        itemCount: currentData.length,
                      ),
              ),
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}
