import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:glass_kit/glass_kit.dart';
import '../../../../core/utils/extensions/media_query_helper.dart';
import '../../../../core/utils/widgets/misc/default_network_image.dart';
import '../../logic/view_auction_controller.dart';
import '../../logic/view_auction_cubit.dart';

class GlassyImagesRow extends StatelessWidget {
  const GlassyImagesRow({
    super.key,
    required this.controller,
    required this.imageUrls,
  });

  final ViewAuctionController controller;
  final List<String> imageUrls;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller.scaleAnimation,
      builder: (context, child) {
        final scale = controller.scaleAnimation.value;

        // Base values
        const baseHeight = 70.0;
        const verticalMargin = 4.0;
        const horizontalMargin = 10.0;
        const baseImgSize = 60.0;
        const baseBorderRadius = 4.0;

        // Scaled values
        final height = baseHeight * (0.3 + 0.7 * scale);
        final borderRadiusValue = baseBorderRadius + (8.0 * scale);
        final scaleTransform = 0.6 + (0.4 * scale);
        final blur = 10.0 + (10.0 * scale);
        final borderWidth = 0.8 + (1.2 * scale);
        final elevation = 1.0 + (3.0 * scale);
        final shadowOpacity = 0.1 + (0.2 * scale);

        return Transform.scale(
          scale: scaleTransform,
          child: GlassContainer(
            height: height,
            width: MediaQueryHelper.width,
            borderRadius: BorderRadius.circular(borderRadiusValue),
            margin: const EdgeInsets.symmetric(
              horizontal: horizontalMargin,
              vertical: verticalMargin,
            ),
            padding: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 3.0),
            gradient: LinearGradient(
              colors: [
                Colors.white.withOpacity(0.25),
                Colors.white.withOpacity(0.05),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderGradient: LinearGradient(
              colors: [
                Colors.white.withOpacity(0.6),
                Colors.white.withOpacity(0.1),
                Colors.lightBlueAccent.withOpacity(0.05),
                Colors.lightBlueAccent.withOpacity(0.6),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              stops: const [0.0, 0.39, 0.4, 1.0],
            ),
            blur: blur,
            borderWidth: borderWidth,
            elevation: elevation,
            shadowColor: Colors.white.withOpacity(shadowOpacity),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: StreamBuilder<int>(
                stream: context.read<AuctionDetailsCubit>().imageIndexStream,
                builder: (context, snapshot) {
                  final selectedIndex = snapshot.data;

                  if (selectedIndex == null || imageUrls.isEmpty) {
                    return const SizedBox();
                  }

                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: List.generate(imageUrls.length, (i) {
                      final imgSize = baseImgSize * (0.3 + 0.7 * scale);
                      final isSelected = i == selectedIndex;

                      return GestureDetector(
                        onTap: () {
                          context.read<AuctionDetailsCubit>().updateImageIndex(i);
                        },
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          padding: const EdgeInsets.all(1.0),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: isSelected ? Colors.blue : Colors.transparent,
                              width: 2.0,
                            ),
                            borderRadius: BorderRadius.circular(baseBorderRadius + 2),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(baseBorderRadius),
                            child: DefaultNetworkImage(
                              imageUrls[i],
                              width: imgSize,
                              height: imgSize,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      );
                    }),
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }
}
