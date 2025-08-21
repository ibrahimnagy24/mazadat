import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/services/pagination/pagination_service.dart';
import '../../../../core/shared/entity/error_entity.dart';
import '../../../../core/utils/extensions/extensions.dart';
import '../../../../core/utils/extensions/media_query_helper.dart';
import '../../../../core/utils/widgets/animated/animated_widget.dart';
import '../../../../core/utils/widgets/animated/grid_list_animator.dart';
import '../../../../core/utils/widgets/custom_loading_text.dart';
import '../../../../core/utils/widgets/errors/error_message_widget.dart';
import '../../../../core/utils/widgets/shimmer/custom_shimmer.dart';
import '../../logic/auctions_cubit.dart';
import '../../logic/auctions_state.dart';

import '../widgets/grid_auction_card.dart';
import '../widgets/list_auction_card.dart';

class AuctionsPage extends StatelessWidget {
  const AuctionsPage({super.key, this.isListing = true});
  final bool isListing;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AuctionsCubit>();
    return Expanded(child: BlocBuilder<AuctionsCubit, AuctionsState>(
      builder: (context, state) {
        if (state is AuctionsLoading) {
          return isListing
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
        if (state is AuctionsError || state is AuctionsEmpty) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: ErrorMessageWidget(
              error: state is AuctionsError
                  ? state.error
                  : const ErrorEntity(
                      message: 'no Data', statusCode: 200, errors: []),
              onTap: () {
                cubit.auctionStatesHandled(SearchEngine());
              },
            ),
          );
        }
        if (state is AuctionsSuccess) {
          return Column(
            children: [
              Expanded(
                child: isListing
                    ? ListAnimator(
                        controller: cubit.controller,
                        padding: EdgeInsets.symmetric(horizontal: 24.w),
                        data: List.generate(
                          state.auctions.length,
                          (i) => Padding(
                            padding: EdgeInsets.symmetric(vertical: 8.h),
                            child: ListAuctionCard(auction: state.auctions[i]),
                          ),
                        ),
                      )
                    : GridListAnimator(
                        controller: cubit.controller,
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        data: List.generate(
                          state.auctions.length,
                          (i) => GridAuctionCard(auction: state.auctions[i]),
                        ),
                        crossAxisCount: 2,
                        aspectRatio: 163 / 207,
                      ),
              ),
              CustomLoadingText(loading: state.isLoading),
            ],
          );
        }
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: const SliverToBoxAdapter(child: Text('no state provided')),
        );
      },
    ));
  }
}
