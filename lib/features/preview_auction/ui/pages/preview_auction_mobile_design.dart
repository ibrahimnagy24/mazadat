import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/utils/extensions/extensions.dart';
import '../../../../core/utils/widgets/custom_app_bar.dart';
import '../../../../core/utils/widgets/errors/error_message_widget.dart';
import '../../../../core/utils/widgets/loading/custom_loading.dart';
import '../../../../core/utils/widgets/misc/custom_scaffold_widget.dart';
import '../../logic/preview_auction_cubit.dart';
import '../../logic/preview_auction_state.dart';
import '../widgets/preview_auction_content.dart';
import '../widgets/preview_auction_app_bar.dart';
import '../widgets/preview_auction_draggable_sheet.dart';
import '../widgets/preview_auction_hero_image.dart';
import '../../logic/preview_auction_controller.dart';

class PreviewAuctionMobileDesign extends StatefulWidget {
  const PreviewAuctionMobileDesign({super.key});

  @override
  State<PreviewAuctionMobileDesign> createState() =>
      _PreviewAuctionMobileDesignState();
}

class _PreviewAuctionMobileDesignState extends State<PreviewAuctionMobileDesign>
    with SingleTickerProviderStateMixin {
  late PreviewAuctionController _controller;

  @override
  void initState() {
    _controller = PreviewAuctionController(vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PreviewAuctionCubit, PreviewAuctionState>(
        builder: (context, state) {
      if (state is PreviewAuctionLoading) {
        return const CustomScaffoldWidget(
          appbar: CustomAppBar(),
          needAppbar: true,
          child: CustomLoading(),
        );
      }
      if (state is PreviewAuctionError) {
        return CustomScaffoldWidget(
            appbar: const CustomAppBar(),
            needAppbar: true,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: ErrorMessageWidget(
                message: state.message,
                onTap: () {
                  context.read<PreviewAuctionCubit>().fetchAuctionDetails();
                },
              ),
            ));
      }
      if (state is PreviewAuctionDetailsSuccess) {
        return CustomScaffoldWidget(
          needAppbar: false,
          child: Stack(
            fit: StackFit.expand,
            children: [
              PreviewAuctionHeroImage(
                animationController: _controller.animationController,
                routeParams: context.read<PreviewAuctionCubit>().routeParams,
                imageUrls: state.auctionDetails.attachments ?? [],
              ),
              PreviewAuctionDraggableSheet(
                animationController: _controller.animationController,
                attachments: state.auctionDetails.attachments ?? [],
                child: PreviewAuctionContent(model: state.auctionDetails),
              ),
              PositionedDirectional(
                top: 0,
                child: PreviewAuctionAppBar(
                  auctionStatus: state.auctionDetails.statusLabel ?? '',
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
