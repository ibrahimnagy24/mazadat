import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/navigation/custom_navigation.dart';
import '../../../../core/navigation/routes.dart';
import '../../../../core/services/pagination/pagination_service.dart';
import '../../../../core/shared/entity/error_entity.dart';
import '../../../../core/shared/widgets/autcion_cards/auction_card_widget.dart';
import '../../../../core/utils/extensions/extensions.dart';
import '../../../../core/utils/extensions/media_query_helper.dart';
import '../../../../core/utils/widgets/animated/animated_widget.dart';
import '../../../../core/utils/widgets/animated/grid_list_animator.dart';
import '../../../../core/utils/widgets/custom_loading_text.dart';
import '../../../../core/utils/widgets/errors/error_message_widget.dart';
import '../../../../core/utils/widgets/shimmer/custom_shimmer.dart';
import '../../../auction_details/view_auction/data/params/view_auction_details_route_params.dart';
import '../../logic/my_purchases_cubit.dart';
import '../../logic/my_purchases_state.dart';
import 'purchase_card_widget.dart';

class MyPurchasesBody extends StatelessWidget {
  const MyPurchasesBody({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<MyPurchasesCubit>();
    return Expanded(
        child: StreamBuilder(
            stream: context.read<MyPurchasesCubit>().listingStream,
            builder: (c, snapshot) {
              return BlocBuilder<MyPurchasesCubit, MyPurchasesState>(
                builder: (context, state) {
                  if (state is MyPurchasesLoading) {
                    return snapshot.data == true
                        ? ListAnimator(
                            padding: EdgeInsets.symmetric(horizontal: 24.w),
                            data: List.generate(
                              10,
                              (i) => Padding(
                                padding: EdgeInsets.symmetric(vertical: 8.h),
                                child: CustomShimmerContainer(
                                  height: 120.h,
                                  width: MediaQueryHelper.width,
                                ),
                              ),
                            ),
                          )
                        : GridListAnimator(
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
                  if (state is MyPurchasesError || state is MyPurchasesEmpty) {
                    return Padding(
                      padding: EdgeInsets.symmetric(horizontal: 24.w),
                      child: ErrorMessageWidget(
                        error: state is MyPurchasesError
                            ? state.error
                            : const ErrorEntity(
                                message: 'no Data',
                                statusCode: 200,
                                errors: []),
                        onTap: () {
                          cubit.myPurchasesStatesHandled(SearchEngine());
                        },
                      ),
                    );
                  }
                  if (state is MyPurchasesSuccess) {
                    return Column(
                      children: [
                        Expanded(
                          child: AnimatedSwitcher(
                            duration: const Duration(milliseconds: 250),
                            transitionBuilder:
                                (Widget child, Animation<double> animation) {
                              return FadeTransition(
                                opacity: CurvedAnimation(
                                  parent: animation,
                                  curve: Curves.easeInOut,
                                ),
                                child: child,
                              );
                            },
                            child: snapshot.data == true
                                ? ListView.builder(
                                    key: const ValueKey('list_view'),
                                    controller: cubit.controller,
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 24.w),
                                    itemCount: state.purchases.length,
                                    itemBuilder: (context, index) {
                                      return Padding(
                                        padding: EdgeInsets.only(bottom: 16.h),
                                        child: AuctionCardWidget(
                                          auctionId: state.purchases[index].id,
                                          image: state.purchases[index].auction
                                                  .productImages.isNotEmpty
                                              ? state.purchases[index].auction
                                                  .productImages.first.path
                                              : '',
                                          // auctionType: state.purchases[index].auction.,
                                          auctionStatus:
                                              state.purchases[index].status,
                                          needFavouriteIcon: false,
                                          fianancePrice: state
                                              .purchases[index].productPrice,
                                          onTap: () {
                                            CustomNavigator.push(
                                              Routes.VIEW_AUCTION_DETAILS,
                                              extra:
                                                  ViewAuctionDetailsRouteParams(
                                                auctionId:
                                                    state.purchases[index].id,
                                                primaryImage: state
                                                        .purchases[index]
                                                        .auction
                                                        .productImages
                                                        .isNotEmpty
                                                    ? state
                                                        .purchases[index]
                                                        .auction
                                                        .productImages
                                                        .first
                                                        .path
                                                    : '',
                                              ),
                                            );
                                          },
                                        ),
                                      );
                                    },
                                  )
                                : GridView.builder(
                                    key: const ValueKey('grid_view'),
                                    controller: cubit.controller,
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 24.w),
                                    gridDelegate:
                                        const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      crossAxisSpacing: 16,
                                      mainAxisSpacing: 16,
                                      mainAxisExtent: 213,
                                    ),
                                    itemBuilder: (context, index) {
                                      return PurchaseCardWidget(
                                        purchase: state.purchases[index],
                                        isGridView: true,
                                      );
                                    },
                                    itemCount: state.purchases.length,
                                  ),
                          ),
                        ),
                        CustomLoadingText(loading: state.isLoading),
                      ],
                    );
                  }
                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24.w),
                    child: const Text('no state provided'),
                  );
                },
              );
            }));
  }
}
