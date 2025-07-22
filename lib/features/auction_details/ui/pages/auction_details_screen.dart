import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_builder/responsive_builder.dart';
import '../../../../core/utils/constant/app_constant.dart';
import '../../data/params/auction_details_route_params.dart';
import '../../logic/auction_pusher_cubit.dart';
import '../../logic/view_auction_cubit.dart';
import 'auction_details_mobile_design.dart';

class AuctionDetailsScreen extends StatelessWidget {
  const AuctionDetailsScreen({super.key, required this.routeParams});
  final AuctionDetailsRouteParams routeParams;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AuctionDetailsCubit()..auctionDetailsStatesHandled(routeParams.auctionId),),
        BlocProvider(create: (context) => AuctionPusherCubit()..init(routeParams.auctionId),),

      ],
      child: ScreenTypeLayout.builder(
        breakpoints: AppConstant.breakpoints,
        mobile: (_) => OrientationLayoutBuilder(
          portrait: (context) =>
              AuctionDetailsMobileDesignScreen(routeParams: routeParams),
          landscape: (context) =>
              AuctionDetailsMobileDesignScreen(routeParams: routeParams),
        ),
        tablet: (_) => OrientationLayoutBuilder(
          portrait: (context) =>
              AuctionDetailsMobileDesignScreen(routeParams: routeParams),
          landscape: (context) =>
              AuctionDetailsMobileDesignScreen(routeParams: routeParams),
        ),
      ),
    );
  }
}
