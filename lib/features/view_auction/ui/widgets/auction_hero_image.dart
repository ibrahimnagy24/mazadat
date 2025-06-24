import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/widgets/misc/default_network_image.dart';
import '../../data/params/view_auction_route_params.dart';
import '../../logic/view_auction_controller.dart';
import '../../logic/view_auction_cubit.dart';

class AuctionHeroImage extends StatelessWidget {
  const AuctionHeroImage({
    super.key,
    required this.controller,
    required this.routeParams,
    this.imageUrl,
  });

  final ViewAuctionController controller;
  final ViewAuctionRouteParams routeParams;
  final String? imageUrl;

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final screenHeight = screenSize.height;

    return BlocBuilder<ViewAuctionCubit, ViewAuctionState>(
      builder: (context, state) {
        String currentImageUrl;

        if (state is ViewAuctionImagesLoaded) {
          currentImageUrl = state.imageUrls[state.selectedImageIndex];
        } else {
          currentImageUrl = imageUrl ?? 'https://picsum.photos/800/800';
        }

        return AnimatedBuilder(
          animation: controller.scaleAnimation,
          builder: (context, child) {
            final imageHeight = screenHeight *
                (controller.minImageFraction +
                    (controller.maxImageFraction -
                            controller.minImageFraction) *
                        controller.scaleAnimation.value);
            return Positioned(
              top: 0,
              left: 0,
              right: 0,
              height: imageHeight,
              child: Hero(
                tag: 'auction_image_$routeParams',
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 500),
                  transitionBuilder:
                      (Widget child, Animation<double> animation) {
                    return FadeTransition(
                      opacity: animation,
                      child: ScaleTransition(
                        scale: Tween<double>(
                          begin: 0.95,
                          end: 1.0,
                        ).animate(CurvedAnimation(
                          parent: animation,
                          curve: Curves.easeOutCubic,
                        )),
                        child: child,
                      ),
                    );
                  },
                  child: DefaultNetworkImage(
                    currentImageUrl,
                    key: ValueKey<String>(currentImageUrl),
                    fit: BoxFit.cover,
                    width: screenSize.width,
                    height: imageHeight,
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
