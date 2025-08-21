import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/utils/extensions/extensions.dart';
import '../../data/model/auction_details_model.dart';
import '../../logic/preview_auction_cubit.dart';
import '../../logic/preview_auction_state.dart';
import 'bidding_section.dart';
import 'auction_info_section.dart';
import 'auction_actions_section.dart';

class PreviewAuctionContent extends StatelessWidget {
  const PreviewAuctionContent({
    super.key,
    required this.model,
  });

  final AuctionDetailsModel model;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 8.h),

          // Auction Title
          Text(
            model.name ?? 'Auction Item',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).textTheme.headlineLarge?.color,
            ),
          ),

          SizedBox(height: 8.h),

          // Auction Number
          if (model.auctionNumber != null)
            Text(
              'Auction #${model.auctionNumber}',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
              ),
            ),

          SizedBox(height: 16.h),

          // Real-time bidding updates listener
          BlocListener<PreviewAuctionCubit, PreviewAuctionState>(
            listener: (context, state) {
              if (state is PreviewAuctionBidUpdate) {
                // Update the model with new bid data
                model.currentBiddingAmount = state.bidData.currentBiddingAmount;
                model.lastBidderId = state.bidData.userId;
              }
            },
            child: const SizedBox.shrink(),
          ),

          // Bidding Section
          BiddingSection(model: model),

          SizedBox(height: 24.h),

          // Auction Information
          AuctionInfoSection(model: model),

          SizedBox(height: 24.h),

          // Action Buttons
          AuctionActionsSection(model: model),

          SizedBox(height: 16.h),

          // Description
          if (model.description != null && model.description!.isNotEmpty) ...[
            const Text(
              'Description',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              model.description!,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[700],
                height: 1.5,
              ),
            ),
            SizedBox(height: 24.h),
          ],

          // Video Section
          if (model.videoLink != null && model.videoLink!.isNotEmpty) ...[
            const Text(
              'Video',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 8.h),
            Container(
              height: 200.h,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Center(
                child: Icon(
                  Icons.play_circle_outline,
                  size: 50,
                  color: Colors.grey,
                ),
              ),
            ),
            SizedBox(height: 24.h),
          ],

          // Additional spacing for better UX
          SizedBox(height: 100.h),
        ],
      ),
    );
  }
}
