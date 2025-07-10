import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/utils/extensions/extensions.dart';
import '../../../../core/utils/widgets/custom_app_bar.dart';
import '../../../../core/utils/widgets/errors/error_message_widget.dart';
import '../../../../core/utils/widgets/loading/custom_loading.dart';
import '../../../../core/utils/widgets/misc/custom_scaffold_widget.dart';
import '../../data/params/auction_details_route_params.dart';
import '../../logic/view_auction_controller.dart';
import '../../logic/view_auction_cubit.dart';
import '../widgets/auction_content.dart';
import '../widgets/auction_details_app_bar.dart';
import '../widgets/auction_draggable_sheet.dart';
import '../widgets/auction_hero_image.dart';

class AuctionDetailsMobileDesignScreen extends StatefulWidget {
  const AuctionDetailsMobileDesignScreen(
      {super.key, required this.routeParams});
  final AuctionDetailsRouteParams routeParams;

  @override
  State<AuctionDetailsMobileDesignScreen> createState() =>
      _AuctionDetailsMobileDesignScreenState();
}

class _AuctionDetailsMobileDesignScreenState
    extends State<AuctionDetailsMobileDesignScreen>
    with SingleTickerProviderStateMixin {
  late ViewAuctionController _controller;

  @override
  void initState() {
    _controller = ViewAuctionController(vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuctionDetailsCubit, AuctionDetailsState>(
        builder: (context, state) {
      if (state is AuctionDetailsLoading) {
        return const CustomScaffoldWidget(
          appbar: CustomAppBar(),
          needAppbar: true,
          child: CustomLoading(),
        );
      }
      if (state is AuctionDetailsError) {
        return CustomScaffoldWidget(
            appbar: const CustomAppBar(),
            needAppbar: true,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: ErrorMessageWidget(
                error: state.error,
                onTap: () {
                  context
                      .read<AuctionDetailsCubit>()
                      .auctionDetailsStatesHandled(widget.routeParams);
                },
              ),
            ));
      }
      if (state is AuctionDetailsSuccess) {
        return CustomScaffoldWidget(
          needAppbar: false,
          child: Stack(
            fit: StackFit.expand,
            children: [
              AuctionHeroImage(
                controller: _controller,
                routeParams: widget.routeParams,
                imageUrl: widget.routeParams.primaryImage,
                imageUrls: state.AuctionDetails.images ?? [],
              ),
              AuctionDraggableSheet(
                controller: _controller,
                imageUrls: state.AuctionDetails.images ?? [],

                child: AuctionContent(model: state.AuctionDetails),
              ),
              PositionedDirectional(
                top: 0,
                child: AuctionDetailsAppBar(
                  auctionStatus: state.AuctionDetails.statusLabel ?? '',
                ),
              ),
            ],
          ),
        );
      } else {
        return CustomScaffoldWidget(
          appbar: const CustomAppBar(),
          needAppbar: true,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: const Text('no state provided'),
          ),
        );
      }
    });
  }
}
