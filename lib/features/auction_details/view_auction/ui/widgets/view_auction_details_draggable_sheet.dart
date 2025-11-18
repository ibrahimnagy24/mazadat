import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/theme/colors/styles.dart';
import '../../logic/view_auction_details_cubit.dart';
import '../../utils/view_auction_details_controller.dart';
import '../component/auction_header_component.dart';
import '../component/auction_price_widget_component.dart';
import '../component/auction_description_component.dart';
import '../component/auction_dates_component.dart';
import '../component/auction_estimated_value_or_dates_component.dart';
import '../component/auction_content_component.dart';
import 'glassy_images_row.dart';

class ViewAuctionDetailsDraggableSheet extends StatelessWidget {
  const ViewAuctionDetailsDraggableSheet({
    super.key,
    required this.controller,
  });

  final ViewAuctionDetailsController controller;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ViewAuctionDetailsCubit>();
    return Column(
      children: [
        Expanded(
          child: DraggableScrollableSheet(
            controller: controller.sheetController,
            initialChildSize: 0.5,
            minChildSize: .4,
            maxChildSize: 0.6,
            snap: true,
            snapSizes: const [0.4, 0.6],
            builder: (context, scrollController) {
              return Column(
                children: [
                  ViewAuctionDetailsGlassyImagesRow(controller: controller),
                  Expanded(
                    child: Container(
                      decoration: const BoxDecoration(
                        color: AppColors.background,
                        borderRadius:
                            BorderRadius.vertical(top: Radius.circular(25)),
                        border: Border.symmetric(
                          horizontal: BorderSide(
                            color: AppColors.kOpacityGrey3,
                            width: 1,
                          ),
                        ),
                      ),
                      child: ListView(
                        physics: const ClampingScrollPhysics(),
                        controller: scrollController,
                        padding: const EdgeInsets.only(
                          top: 24,
                          bottom: 50,
                          left: 24,
                          right: 24,
                        ),
                        children: [
                          AuctionHeaderComponent(
                              auction: cubit.auctionDetails!),
                          const SizedBox(height: 16),
                          AuctionPriceWidgetComponent(
                              auction: cubit.auctionDetails!),
                          const SizedBox(height: 16),
                          AuctionDescriptionComponent(
                              auction: cubit.auctionDetails!),
                          AuctionAllDatesComponent(cubit: cubit),
                          const SizedBox(height: 16),
                          AuctionEstimatedValueOrDatesComponent(
                              auction: cubit.auctionDetails!),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
        if (cubit.auctionDetails?.cancellationReason == null)
          Container(
            padding: const EdgeInsetsDirectional.only(
              start: 24,
              end: 24,
            ),
            decoration: BoxDecoration(
              color: AppColors.background,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black26.withValues(alpha: .1),
                  blurRadius: .5,
                  spreadRadius: .5,
                  offset: const Offset(0, -1),
                )
              ],
            ),
            child: const SafeArea(
              top: false,
              left: false,
              right: false,
              child: Padding(
                padding: EdgeInsetsDirectional.only(top: 4, bottom: 4),
                child: AuctionContentComponent(),
              ),
            ),
          ),
      ],
    );
  }
}
