import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/widgets/misc/custom_scaffold_widget.dart';
import '../../data/params/view_auction_route_params.dart';
import '../../logic/view_auction_controller.dart';
import '../../logic/view_auction_cubit.dart';
import '../widgets/auction_content.dart';
import '../widgets/auction_draggable_sheet.dart';
import '../widgets/auction_hero_image.dart';

/// ViewAuctionScreen is the main screen for viewing auction details.
/// It uses a clean architecture with separate logic and UI components.
class ViewAuctionScreen extends StatefulWidget {
  const ViewAuctionScreen({super.key, required this.routeParams});
  final ViewAuctionRouteParams routeParams;

  @override
  State<ViewAuctionScreen> createState() => _ViewAuctionScreenState();
}

class _ViewAuctionScreenState extends State<ViewAuctionScreen>
    with SingleTickerProviderStateMixin {
  late ViewAuctionController _controller;

  final String _imageUrl =
      'https://images.unsplash.com/photo-1501854140801-50d01698950b';
  final String _auctionId = 'UC-1045';

  @override
  void initState() {
    super.initState();
    _controller = ViewAuctionController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ViewAuctionCubit()..loadAuctionImages(),
      child: CustomScaffoldWidget(
        needAppbar: false,
        child: Stack(
          fit: StackFit.expand,
          children: [
            AuctionHeroImage(
              controller: _controller,
              routeParams: widget.routeParams,
              imageUrl: _imageUrl,
            ),
            AuctionDraggableSheet(
              controller: _controller,
              child: AuctionContent(auctionId: _auctionId),
            ),
          ],
        ),
      ),
    );
  }
}
