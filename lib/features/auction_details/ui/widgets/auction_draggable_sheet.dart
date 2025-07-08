import 'package:flutter/material.dart';

import '../../../../../core/theme/colors/styles.dart';
import '../../logic/view_auction_controller.dart';
import 'glassy_images_row.dart';

/// A draggable bottom sheet for displaying auction details that
/// can be expanded and collapsed by the user.
class AuctionDraggableSheet extends StatelessWidget {
  const AuctionDraggableSheet({
    super.key,
    required this.controller,
    required this.child,
    required this.imageUrls,
  });

  final ViewAuctionController controller;
  final Widget child;
  final List<String> imageUrls;

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      controller: controller.sheetController,
      initialChildSize: 0.5,
      minChildSize: .4,
      maxChildSize: 0.7,
      snap: true,
      snapSizes: const [0.4, 0.7],
      builder: (context, scrollController) {
        return Column(
          children: [
            if (imageUrls.isNotEmpty)
              GlassyImagesRow(controller: controller, imageUrls: imageUrls),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius:
                      const BorderRadius.vertical(top: Radius.circular(25)),
                  border: const Border.symmetric(
                    horizontal: BorderSide(
                      color: AppColors.kOpacityGrey3,
                      width: 1,
                    ),
                  ),
                  boxShadow: [
                    if (imageUrls.isNotEmpty)
                      const BoxShadow(
                        color: Colors.black26,
                        blurRadius: 10,
                        spreadRadius: 50,
                      )
                  ],
                ),
                child: ListView(
                  physics: const ClampingScrollPhysics(),
                  controller: scrollController,
                  padding: const EdgeInsets.only(top: 20, bottom: 50),
                  children: [child],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
