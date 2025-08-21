import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_builder/responsive_builder.dart';
import '../../../../core/utils/constant/app_constant.dart';
import '../../../pusher_service/pusher_cubit.dart';
import '../../data/params/auction_details_route_params.dart';
import '../../logic/preview_auction_cubit.dart';
import 'preview_auction_mobile_design.dart';

class PreviewAuctionScreen extends StatelessWidget {
  const PreviewAuctionScreen({super.key, required this.routeParams});
  final PreviewAuctionRouteParams routeParams;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => PusherCubit()),
        BlocProvider(
          create: (context) => PreviewAuctionCubit(
            pusherCubit: context.read<PusherCubit>(),
          )
            ..init(routeParams)
            ..fetchAuctionDetails(),
        ),
      ],
      child: ScreenTypeLayout.builder(
        breakpoints: AppConstant.breakpoints,
        mobile: (_) => OrientationLayoutBuilder(
          portrait: (context) => const PreviewAuctionMobileDesign(),
          landscape: (context) => const PreviewAuctionMobileDesign(),
        ),
        tablet: (_) => OrientationLayoutBuilder(
          portrait: (context) => const PreviewAuctionMobileDesign(),
          landscape: (context) => const PreviewAuctionMobileDesign(),
        ),
      ),
    );
  }
}
