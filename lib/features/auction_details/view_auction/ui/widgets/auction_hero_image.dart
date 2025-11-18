import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/utils/extensions/media_query_helper.dart';
import '../../../../../core/utils/widgets/misc/default_network_image.dart';
import '../../../../../core/utils/widgets/misc/default_video_card.dart';
import '../../../../../core/utils/widgets/video/full_screen_video_player.dart';
import '../../logic/view_auction_details_cubit.dart';
import '../../utils/view_auction_details_controller.dart';

class ViewAuctionHeroImage extends StatelessWidget {
  const ViewAuctionHeroImage({
    super.key,
    required this.controller,
  });

  final ViewAuctionDetailsController controller;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ViewAuctionDetailsCubit, ViewAuctionDetailsState>(
      buildWhen: (previous, current) =>
          current is ViewAuctionDetailsImageChanged,
      builder: (context, state) {
        final cubit = context.read<ViewAuctionDetailsCubit>();
        final index = cubit.currentImageIndex;
        final imageUrls = cubit.auctionDetails?.attachments ?? [];
        final hasValidIndex =
            index >= 0 && index < imageUrls.length && imageUrls.isNotEmpty;

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
                tag: 'auction_image_${cubit.auctionDetails?.primaryPhoto}',
                child: Stack(
                  children: [
                    AnimatedSwitcher(
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
                              key: ValueKey<String>(imageUrl.url),
                              videoUrl: imageUrl.url,
                              width: MediaQueryHelper.width,
                              height: imageHeight,
                            )
                          : DefaultNetworkImage(
                              imageUrl.url,
                              key: ValueKey<String>(imageUrl.url),
                              fit: BoxFit.cover,
                              width: MediaQueryHelper.width,
                              height: imageHeight,
                            ),
                    ),
                    // Video indicator and maximize button overlay for main display
                    if (imageUrl.isVideo == true)
                      Positioned(
                        top: 16,
                        right: 16,
                        child: Column(
                          children: [
                            // Video indicator
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.black.withOpacity(0.7),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: const Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    Icons.videocam,
                                    color: Colors.white,
                                    size: 16,
                                  ),
                                  SizedBox(width: 4),
                                  Text(
                                    'Video',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 8),
                            // Maximize button
                            GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => FullScreenVideoPlayer(
                                      videoUrl: imageUrl.url,
                                      title: 'Auction Video',
                                    ),
                                  ),
                                );
                              },
                              child: Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: Colors.black.withOpacity(0.7),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: const Icon(
                                  Icons.fullscreen,
                                  color: Colors.white,
                                  size: 24,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
