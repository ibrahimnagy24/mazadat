import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/extensions/extensions.dart';
import '../../../../core/utils/extensions/media_query_helper.dart';
import '../../../../core/utils/widgets/errors/error_message_widget.dart';
import '../../../../core/utils/widgets/shimmer/custom_shimmer.dart';
import '../../data/enums/auction_enums.dart';
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
    return BlocBuilder<AuctionsCubit, AuctionsState>(
      buildWhen: (previous, current) =>
          current is AuctionsLoading ||
          current is AuctionsSuccess ||
          current is AuctionsError,
      builder: (context, state) {
        if (state is AuctionsLoading) {
          return SliverList.separated(
            itemBuilder: (context, index) => Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: CustomShimmerContainer(
                height: 120.h,
                width: MediaQueryHelper.width,
              ),
            ),
            itemCount: cubit.allAuctions?.length ?? 0,
            separatorBuilder: (context, index) {
              return SizedBox(height: 16.h);
            },
          );
        }
        if (state is AuctionsError) {
          return SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: ErrorMessageWidget(
                error: state.error,
                onTap: () {
                  cubit.auctionStatesHandled();
                },
              ),
            ),
          );
        }
        if (cubit.allAuctions != null) {
          if (cubit.allAuctions!.isEmpty) {
            return const SizedBox();
          }
          return isListing
              ? SliverList.separated(
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.symmetric(horizontal: 24.w),
                      child: isListing
                          ? ListAuctionCard(auction: cubit.allAuctions![index])
                          : GridAuctionCard(auction: cubit.allAuctions![index]),
                    );
                  },
                  itemCount: cubit.allAuctions?.length ?? 0,
                  separatorBuilder: (context, index) {
                    return const SizedBox(height: 16);
                  },
                )
              : SliverGrid.builder(
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.symmetric(horizontal: 24.w),
                      child:
                          GridAuctionCard(auction: cubit.allAuctions![index]),
                    );
                  },
                  itemCount: cubit.allAuctions?.length ?? 0,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 16.w,
                    crossAxisSpacing: 16.w,
                    childAspectRatio: 1,
                  ),
                );
        }
        return SliverToBoxAdapter(
            child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: const Center(child: Text('no state provided')),
        ));
      },
    );
  }
}
