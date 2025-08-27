import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/utils/extensions/media_query_helper.dart';
import '../../../../../core/utils/widgets/misc/default_network_image.dart';
import '../../../../../core/utils/widgets/misc/default_video_card.dart';
import '../../data/model/auction_details_model.dart';
import '../../data/params/auction_details_route_params.dart';
import '../../logic/view_auction_controller.dart';
import '../../logic/view_auction_cubit.dart';

class AuctionHeroImage extends StatelessWidget {
  const AuctionHeroImage({
    super.key,
    required this.controller,
    required this.routeParams,
    required this.imageUrls,
  });

  final ViewAuctionController controller;
  final AuctionDetailsRouteParams routeParams;
  final List<AttachmentModel> imageUrls;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<int>(
      stream: context.read<AuctionDetailsCubit>().imageIndexStream,
      builder: (context, snapshot) {
        // handle null or out of bounds index
        final index = snapshot.data;
        final hasValidIndex =
            index != null && index >= 0 && index < imageUrls.length;

        if (!hasValidIndex) return const SizedBox();

        final imageUrl = imageUrls[index];

        return AnimatedBuilder(
          animation: controller.scaleAnimation,
          builder: (context, child) {
            final animationValue = controller.scaleAnimation.value;
            final imageHeight = MediaQueryHelper.height *
                (controller.minImageFraction +
                    (controller.maxImageFraction -
                            controller.minImageFraction) *
                        animationValue);

            return Positioned(
              top: 0,
              left: 0,
              right: 0,
              height: imageHeight,
              child: Hero(
                tag: 'auction_image_${routeParams.primaryImage}',
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 500),
                  transitionBuilder: (child, animation) {
                    final curved = CurvedAnimation(
                      parent: animation,
                      curve: Curves.easeOutCubic,
                    );

                    return FadeTransition(
                      opacity: animation,
                      child: ScaleTransition(
                        scale: Tween<double>(
                          begin: 0.95,
                          end: 1.0,
                        ).animate(curved),
                        child: child,
                      ),
                    );
                  },
                  child: imageUrl.isVideo == true
                      ? DefaultVideoCard(
                          key: ValueKey<String>(imageUrl.url ?? ''),
                          videoUrl: imageUrl.url ?? '',
                          width: MediaQueryHelper.width,
                          height: imageHeight,
                        )
                      : DefaultNetworkImage(
                          imageUrl.url ?? '',
                          key: ValueKey<String>(imageUrl.url ?? ''),
                          fit: BoxFit.cover,
                          width: MediaQueryHelper.width,
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
