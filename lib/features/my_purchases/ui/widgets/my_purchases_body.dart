import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/navigation/custom_navigation.dart';
import '../../../../core/navigation/routes.dart';
import '../../../../core/utils/widgets/empty/responsive_empty_widget.dart';
import '../../../../core/utils/widgets/errors/error_message_widget.dart';
import '../../../../core/utils/widgets/loading/logo_loading.dart';
import '../../../../core/utils/extensions/extensions.dart';
import '../../../auction_details/view_auction/data/params/view_auction_details_route_params.dart';
import '../../data/entity/shipment_entity.dart';
import '../../data/enum/display_types.dart';
import '../../logic/my_purchases_cubit.dart';
import '../../logic/my_purchases_state.dart';
import 'shipment_card_widget.dart';
import 'stacked_shipment_card_widget.dart';

class MyPurchasesBody extends StatelessWidget {
  const MyPurchasesBody({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<MyPurchasesCubit>();
    return Expanded(
      child: BlocBuilder<MyPurchasesCubit, MyPurchasesState>(
        buildWhen: (previous, current) =>
            current is MyPurchasesLoading ||
            current is MyPurchasesSuccess ||
            current is MyPurchasesError ||
            current is MyPurchasesDisplayTypeChanged ||
            current is MyPurchasesSearchLoading ||
            current is MyPurchasesSearchSuccess ||
            current is MyPurchasesSearchError ||
            current is MyPurchasesSearchEmpty,
        builder: (context, state) {
          // Determine which data to display
          List<ShipmentEntity>? currentData;
          bool isSearching = cubit.currentSearchQuery.isNotEmpty;

          if (isSearching) {
            // Use search results if searching
            if (state is MyPurchasesSearchSuccess) {
              currentData = state.searchResults;
            } else if (cubit.searchResults != null) {
              currentData = cubit.searchResults;
            }
          } else {
            // Use regular shipments data
            if (state is MyPurchasesSuccess) {
              currentData = state.shipments;
            } else if (cubit.shipments != null) {
              currentData = cubit.shipments;
            }
          }

          // Loading states
          if (state is MyPurchasesLoading) {
            return const LogoLoadingWidget();
          }

          // Error states
          if (state is MyPurchasesError) {
            return Center(
              child: ErrorMessageWidget(
                error: state.error,
                onTap: () {
                  cubit.getShipments();
                },
                message: state.error.message,
              ),
            );
          }

          if (state is MyPurchasesSearchError) {
            return Center(
              child: ErrorMessageWidget(
                error: state.error,
                onTap: () {
                  cubit.searchShipments(cubit.currentSearchQuery);
                },
                message: state.error.message,
              ),
            );
          }

          // Empty states
          if (state is MyPurchasesSearchEmpty ||
              (isSearching && (currentData == null || currentData.isEmpty))) {
            return ResponsiveEmptyWidget(
              onTap: () {
                cubit.searchShipments(cubit.currentSearchQuery);
              },
              title: 'No Search Results'.tr,
              subtitle: 'No shipments found for your search'.tr,
            );
          }

          if (!isSearching && (currentData == null || currentData.isEmpty)) {
            return ResponsiveEmptyWidget(
              onTap: () {
                cubit.getShipments();
              },
              title: 'No Shipments'.tr,
              subtitle: 'No shipments found'.tr,
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
                child: cubit.displayType == MyPurchasesDisplayTypes.list
                    ? ListView.builder(
                        key: const ValueKey('list_view'),
                        itemCount: currentData.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 16),
                            child: StackedShipmentCardWidget(
                              shipment: currentData![index],
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
                          return ShipmentCardWidget(
                            shipment: currentData![index],
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
