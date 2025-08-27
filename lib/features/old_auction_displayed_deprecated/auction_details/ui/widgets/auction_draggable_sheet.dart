import 'package:flutter/material.dart';

import '../../../../../../core/theme/colors/styles.dart';
import '../../../../../core/utils/extensions/extensions.dart';
import '../../../../../core/utils/widgets/animated/animated_widget.dart';
import '../../data/model/auction_details_model.dart';
import '../../logic/view_auction_controller.dart';
import 'glassy_images_row.dart';

/// A draggable bottom sheet for displaying auction details that
/// can be expanded and collapsed by the user.
class AuctionDraggableSheet extends StatelessWidget {
  const AuctionDraggableSheet({
    super.key,
    required this.controller,
    required this.child,
    required this.attachments,
  });

  final ViewAuctionController controller;
  final Widget child;
  final List<AttachmentModel> attachments;

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
            if (attachments.isNotEmpty)
              GlassyImagesRow(controller: controller, attachments: attachments),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.background,
                  borderRadius:
                      const BorderRadius.vertical(top: Radius.circular(25)),
                  border: const Border.symmetric(
                    horizontal: BorderSide(
                      color: AppColors.kOpacityGrey3,
                      width: 1,
                    ),
                  ),
                  boxShadow: [
                    if (attachments.isNotEmpty)
                      const BoxShadow(
                        color: Colors.black26,
                        blurRadius: 10,
                        spreadRadius: 50,
                      )
                  ],
                ),
                child: ListAnimator(
                  physics: const ClampingScrollPhysics(),
                  controller: scrollController,
                  padding: EdgeInsets.only(
                    top: 20.h,
                    bottom: 50.h,
                    left: 24.w,
                    right: 24.w,
                  ),
                  data: [child],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
