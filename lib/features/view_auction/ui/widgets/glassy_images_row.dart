import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:glass_kit/glass_kit.dart';
import '../../../../core/theme/colors/styles.dart';
import '../../../../core/utils/extensions/media_query_helper.dart';
import '../../../../core/utils/widgets/misc/default_network_image.dart';
import '../../../../core/utils/widgets/misc/default_video_card.dart';
import '../../logic/view_auction_details_cubit.dart';
import '../../utils/view_auction_details_controller.dart';

class ViewAuctionDetailsGlassyImagesRow extends StatelessWidget {
  const ViewAuctionDetailsGlassyImagesRow({
    super.key,
    required this.controller,
  });

  final ViewAuctionDetailsController controller;

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
              child:
                  BlocBuilder<ViewAuctionDetailsCubit, ViewAuctionDetailsState>(
                buildWhen: (previous, current) =>
                    current is ViewAuctionDetailsImageChanged,
                builder: (context, state) {
                  final cubit = context.read<ViewAuctionDetailsCubit>();
                  final selectedIndex = cubit.currentImageIndex;
                  final attachments = cubit.auctionDetails?.attachments ?? [];

                  if (attachments.isEmpty) {
                    return const SizedBox();
                  }

                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: List.generate(attachments.length, (i) {
                      final imgSize = baseImgSize * (0.3 + 0.7 * scale);
                      final isSelected = i == selectedIndex;

                      return GestureDetector(
                        onTap: () {
                          context
                              .read<ViewAuctionDetailsCubit>()
                              .changeImageIndex(i);
                        },
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          padding: const EdgeInsets.all(1.0),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: isSelected
                                  ? AppColors.kPrimary
                                  : AppColors.kSecondary,
                              width: 2.0,
                            ),
                            borderRadius:
                                BorderRadius.circular(baseBorderRadius + 2),
                          ),
                          child: ClipRRect(
                            borderRadius:
                                BorderRadius.circular(baseBorderRadius),
                            child: Stack(
                              children: [
                                (attachments[i].isVideo)
                                    ? DefaultVideoCard(
                                        onTap: () {
                                          log('xxx $i');
                                          context
                                              .read<ViewAuctionDetailsCubit>()
                                              .changeImageIndex(i);
                                        },
                                        play: false,
                                        key: ValueKey<String>(
                                            attachments[i].url),
                                        videoUrl: attachments[i].url,
                                        width: imgSize,
                                        height: imgSize,
                                      )
                                    : DefaultNetworkImage(
                                        attachments[i].url,
                                        width: imgSize,
                                        height: imgSize,
                                        fit: BoxFit.cover,
                                      ),
                              ],
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
