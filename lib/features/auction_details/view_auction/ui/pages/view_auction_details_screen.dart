import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/utils/widgets/misc/custom_screen_type_layout_widget.dart';
import '../../../../user/logic/user_cubit.dart';
import '../../../pusher_service/pusher_cubit.dart';
import '../../../pusher_service/pusher_state.dart';
import '../../data/params/view_auction_details_route_params.dart';
import '../../logic/view_auction_details_cubit.dart';
import '../bottom_sheets/auction_results_status_widget.dart';
import 'view_auction_details_mobile_design.dart';

class ViewAuctionDetailsScreen extends StatelessWidget {
  const ViewAuctionDetailsScreen({super.key, required this.routeParams});
  final ViewAuctionDetailsRouteParams routeParams;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ViewAuctionDetailsCubit()
            ..init(routeParams)
            ..viewAuctionDetailsStatesHandled(),
        ),
        BlocProvider(
          create: (context) => PusherCubit()..init(routeParams.auctionId),
        ),
      ],
      child: BlocConsumer<PusherCubit, PusherState>(
        listener: (context, state) async {
          if (state is AuctionBidReceived) {
            final auctionCubit = context.read<ViewAuctionDetailsCubit>();
            await auctionCubit.viewAuctionDetailsStatesHandled();
          }
          if (state is AuctionEnded) {
            final auctionCubit = context.read<ViewAuctionDetailsCubit>();
            if (state.winnerId != null) {
              final isCurrentUserWinner =
                  state.winnerId == context.read<UserCubit>().userEntity!.id;
              showModalBottomSheet(
                context: context,
                enableDrag: true,
                isScrollControlled: true,
                isDismissible: true,
                builder: (modalBuildContext) {
                  return BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
                    child: AuctionResultsStatusWidget(
                      modalBuildContext: modalBuildContext,
                      status: isCurrentUserWinner
                          ? AuctionResultStatus.winner
                          : AuctionResultStatus.loser,
                      onContinue: () {
                        auctionCubit.viewAuctionDetailsStatesHandled();
                      },
                    ),
                  );
                },
              );
            }
            await auctionCubit.viewAuctionDetailsStatesHandled();
          }
          if (state is AuctionStarted) {
            final auctionCubit = context.read<ViewAuctionDetailsCubit>();
            await auctionCubit.viewAuctionDetailsStatesHandled();
          }
        },
        builder: (context, state) {
          return CustomScreenTypeLayoutWidget(
            mobilePortrait: (context) =>
                const ViewAuctionDetailsMobileDesignScreen(),
            mobileLandscape: (context) =>
                const ViewAuctionDetailsMobileDesignScreen(),
          );
        },
      ),
    );
  }
}
