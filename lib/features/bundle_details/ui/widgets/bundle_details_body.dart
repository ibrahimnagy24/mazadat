import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/shared/entity/error_entity.dart';
import '../../../../core/utils/extensions/extensions.dart';
import '../../../../core/utils/extensions/media_query_helper.dart';
import '../../../../core/utils/widgets/animated/animated_widget.dart';
import '../../../../core/utils/widgets/errors/error_message_widget.dart';
import '../../../../core/utils/widgets/shimmer/custom_shimmer.dart';
import '../../../auctions/ui/widgets/list_auction_card.dart';
import '../../data/params/bundle_details_route_params.dart';
import '../../logic/bundle_details_cubit.dart';

class BundleDetailsBody extends StatelessWidget {
  const BundleDetailsBody({super.key, required this.routeParams});
  final BundleDetailsRouteParams routeParams;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<BundleDetailsCubit>();
    return Expanded(
      child: BlocBuilder<BundleDetailsCubit, BundleDetailsState>(
        builder: (context, state) {
          if (state is BundleDetailsLoading) {
            return ListAnimator(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              data: List.generate(
                10,
                (i) => Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.h),
                  child: CustomShimmerContainer(
                    height: 215.h,
                    width: MediaQueryHelper.width,
                  ),
                ),
              ),
            );
          }
          if (state is BundleDetailsError || state is BundleDetailsEmpty) {
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: ErrorMessageWidget(
                error: state is BundleDetailsError
                    ? state.errorEntity
                    : const ErrorEntity(
                        message: 'no Data', statusCode: 200, errors: []),
                onTap: () {
                  cubit.getBundleDetails(routeParams);
                },
              ),
            );
          }
          if (state is BundleDetailsSuccess) {
            return ListAnimator(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              data: List.generate(
                state.bundleDetails.auction?.length ?? 0,
                (i) => Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.h),
                  child:
                      ListAuctionCard(auction: state.bundleDetails.auction![i]),
                ),
              ),
            );
          }
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: const Text('no state provided'),
          );
        },
      ),
    );
  }
}
