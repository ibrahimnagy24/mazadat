import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/utils/extensions/extensions.dart';
import '../../data/model/auction_details_model.dart';
import '../../data/params/preview_auction_bidding_params.dart';
import '../../logic/preview_auction_cubit.dart';
import '../../logic/preview_auction_state.dart';

class BiddingSection extends StatefulWidget {
  const BiddingSection({
    super.key,
    required this.model,
  });

  final AuctionDetailsModel model;

  @override
  State<BiddingSection> createState() => _BiddingSectionState();
}

class _BiddingSectionState extends State<BiddingSection> {
  final TextEditingController _bidController = TextEditingController();

  @override
  void dispose() {
    _bidController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PreviewAuctionCubit, PreviewAuctionState>(
      builder: (context, state) {
        return Container(
          padding: EdgeInsets.all(16.w),
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: Colors.grey.withOpacity(0.3),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Current Bid Information
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Current Bid',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  if (state is PreviewAuctionBidUpdate)
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                      decoration: BoxDecoration(
                        color: Colors.green.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: const Text(
                        'Updated!',
                        style: TextStyle(
                          fontSize: 10,
                          color: Colors.green,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                ],
              ),

              const SizedBox(height: 8),

              Text(
                '${widget.model.currentBiddingAmount?.toStringAsFixed(2) ?? '0.00'} SAR',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).primaryColor,
                ),
              ),

              const SizedBox(height: 4),

              if (widget.model.lastBidderId != null)
                Text(
                  'Last bidder: ${widget.model.lastBidderId}',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[600],
                  ),
                ),

              const SizedBox(height: 16),

              // Bid Information
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Opening Price',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[600],
                          ),
                        ),
                        Text(
                          '${widget.model.openingPrice ?? '0'} SAR',
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Increment',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[600],
                          ),
                        ),
                        Text(
                          '${widget.model.biddingIncrementAmount?.toStringAsFixed(2) ?? '0.00'} SAR',
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              if (widget.model.maxBiddingAmount != null) ...[
                SizedBox(height: 8.h),
                Text(
                  'Max Bid: ${widget.model.maxBiddingAmount!.toStringAsFixed(2)} SAR',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[600],
                  ),
                ),
              ],

              SizedBox(height: 16.h),

              // Bidding Input and Button
              if (widget.model.isJoined == true &&
                  widget.model.isStarted == true &&
                  widget.model.isEnded != true) ...[
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _bidController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          hintText: 'Enter bid amount',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 12.w,
                            vertical: 12.h,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 8.w),
                    ElevatedButton(
                      onPressed: state is PreviewAuctionBiddingLoading
                          ? null
                          : () => _placeBid(context),
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(
                          horizontal: 16.w,
                          vertical: 12.h,
                        ),
                      ),
                      child: state is PreviewAuctionBiddingLoading
                          ? SizedBox(
                              width: 16.w,
                              height: 16.h,
                              child: const CircularProgressIndicator(
                                strokeWidth: 2,
                              ),
                            )
                          : const Text('Bid'),
                    ),
                  ],
                ),
              ],
            ],
          ),
        );
      },
    );
  }

  void _placeBid(BuildContext context) {
    final bidAmount = double.tryParse(_bidController.text);
    if (bidAmount == null || bidAmount <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter a valid bid amount'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    final currentBid = widget.model.currentBiddingAmount ?? 0;
    final increment = widget.model.biddingIncrementAmount ?? 0;
    final minBid = currentBid + increment;

    if (bidAmount < minBid) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Minimum bid is ${minBid.toStringAsFixed(2)} SAR'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    final bidParams = PreviewAuctionBiddingParams(
      auctionId: widget.model.id!,
      amount: bidAmount,
    );

    context.read<PreviewAuctionCubit>().submitBid(
          bidParams,
          widget.model.firstBid != true,
        );

    _bidController.clear();
  }
}
