import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:glass_kit/glass_kit.dart';
import '../../../../core/utils/widgets/misc/default_network_image.dart';
import '../../logic/view_auction_controller.dart';
import '../../logic/view_auction_cubit.dart';

class GlassyImagesRow extends StatelessWidget {
  const GlassyImagesRow({
    super.key,
    required this.controller,
  });

  final ViewAuctionController controller;

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return AnimatedBuilder(
      animation: controller.scaleAnimation,
      builder: (context, child) {
        const baseHeight = 70.0;
        final heightScale = 0.3 + (0.7 * controller.scaleAnimation.value);
        final height = baseHeight * heightScale;

        final widthScale = 0.5 + (0.5 * controller.scaleAnimation.value);
        // final width = screenSize.width * widthScale;
        final width = screenSize.width;

        // final verticalMargin = 4.0 + (12.0 * controller.scaleAnimation.value);
        // final horizontalMargin =
        //     10.0 + (10.0 * controller.scaleAnimation.value);
        const verticalMargin = 4.0;
        const horizontalMargin = 10.0;

        final borderRadiusValue = 4.0 + (8.0 * controller.scaleAnimation.value);

        return Transform.scale(
          scale: 0.6 + (0.4 * controller.scaleAnimation.value),
          child: GlassContainer(
            height: height,
            width: width,
            borderRadius: BorderRadius.circular(4),
            margin: const EdgeInsets.symmetric(
                horizontal: horizontalMargin, vertical: verticalMargin),
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
                Colors.lightBlueAccent.withOpacity(0.6)
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              stops: const [0.0, 0.39, 0.4, 1.0],
            ),
            blur: 10.0 + (10.0 * controller.scaleAnimation.value),
            borderWidth: 0.8 + (1.2 * controller.scaleAnimation.value),
            elevation: 1.0 + (3.0 * controller.scaleAnimation.value),
            shadowColor: Colors.white
                .withOpacity(0.1 + (0.2 * controller.scaleAnimation.value)),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: BlocBuilder<ViewAuctionCubit, ViewAuctionState>(
                builder: (context, state) {
                  late List<String> imageUrls;
                  int selectedIndex = 0;

                  if (state is ViewAuctionImagesLoaded) {
                    imageUrls = state.imageUrls;
                    selectedIndex = state.selectedImageIndex;
                  } else {
                    imageUrls = List.generate(
                        10, (i) => 'https://picsum.photos/800/800?random=$i');
                  }

                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: List.generate(imageUrls.length, (index) {
                      const baseImgSize = 60.0;
                      final imgSize = baseImgSize *
                          (0.3 + (0.7 * controller.scaleAnimation.value));

                      const paddingValue = 1.0;

                      const imgBorderRadius = 4.0;

                      final isSelected = index == selectedIndex;

                      return GestureDetector(
                        onTap: () {
                          context.read<ViewAuctionCubit>().selectImage(index);
                        },
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          padding: const EdgeInsets.all(paddingValue),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color:
                                  isSelected ? Colors.blue : Colors.transparent,
                              width: 2.0,
                            ),
                            borderRadius:
                                BorderRadius.circular(imgBorderRadius + 2),
                          ),
                          child: ClipRRect(
                            borderRadius:
                                BorderRadius.circular(imgBorderRadius),
                            child: DefaultNetworkImage(
                              imageUrls[index],
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
