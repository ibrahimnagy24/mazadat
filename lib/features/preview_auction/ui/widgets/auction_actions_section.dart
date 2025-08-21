import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/model/auction_details_model.dart';
import '../../data/params/preview_auction_bidding_params.dart';
import '../../data/params/preview_auction_withdrawal_params.dart';
import '../../logic/preview_auction_cubit.dart';
import '../../logic/preview_auction_state.dart';

class AuctionActionsSection extends StatelessWidget {
  const AuctionActionsSection({
    super.key,
    required this.model,
  });

  final AuctionDetailsModel model;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PreviewAuctionCubit, PreviewAuctionState>(
      builder: (context, state) {
        return Column(
          children: [
            // Join Auction Button
            if (model.isJoined != true && model.isStarted != true) ...[
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: state is PreviewAuctionJoiningLoading
                      ? null
                      : () => _joinAuction(context),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    backgroundColor: Theme.of(context).primaryColor,
                    foregroundColor: Colors.white,
                  ),
                  child: state is PreviewAuctionJoiningLoading
                      ? const CircularProgressIndicator(color: Colors.white)
                      : const Text('Join Auction'),
                ),
              ),
              const SizedBox(height: 12),
            ],

            // Switch Bidding Method Button
            if (model.isJoined == true &&
                model.isStarted == true &&
                model.isEnded != true) ...[
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: state is PreviewAuctionLoading
                      ? null
                      : () => _toggleAutoBidding(context),
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: Text(
                    model.autoBiddingEnabled == true
                        ? 'Switch to Manual Bidding'
                        : 'Switch to Auto Bidding',
                  ),
                ),
              ),
              const SizedBox(height: 12),
            ],

            // Withdraw Button
            if (model.isJoined == true && model.isEnded != true) ...[
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: state is PreviewAuctionWithdrawalLoading
                      ? null
                      : () => _showWithdrawDialog(context),
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    foregroundColor: Colors.red,
                    side: const BorderSide(color: Colors.red),
                  ),
                  child: state is PreviewAuctionWithdrawalLoading
                      ? const CircularProgressIndicator(color: Colors.red)
                      : const Text('Withdraw from Auction'),
                ),
              ),
            ],

            // Favorite Button
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: () => _toggleFavorite(context),
                  icon: Icon(
                    model.myfav == true
                        ? Icons.favorite
                        : Icons.favorite_border,
                    color: model.myfav == true ? Colors.red : Colors.grey,
                  ),
                ),
                Text(
                  model.myfav == true
                      ? 'Remove from Favorites'
                      : 'Add to Favorites',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  void _joinAuction(BuildContext context) {
    if (model.id == null) return;

    // First validate joining
    context.read<PreviewAuctionCubit>().validateJoiningAuctionById(model.id!);
  }

  void _toggleAutoBidding(BuildContext context) {
    if (model.id == null) return;

    final params = PreviewAuctionBiddingParams(
      auctionId: model.id!,
      amount: 0.0, // Default amount for switching bidding method
      isAutoBid: !(model.autoBiddingEnabled ?? false),
    );

    context.read<PreviewAuctionCubit>().switchBiddingMethod(params);
  }

  void _showWithdrawDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: const Text('Withdraw from Auction'),
          content: const Text(
            'Are you sure you want to withdraw from this auction? This action cannot be undone.',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(dialogContext).pop();
                _withdrawFromAuction(context);
              },
              style: TextButton.styleFrom(foregroundColor: Colors.red),
              child: const Text('Withdraw'),
            ),
          ],
        );
      },
    );
  }

  void _withdrawFromAuction(BuildContext context) {
    if (model.id == null) return;

    final params = PreviewAuctionWithdrawalParams(
      auctionId: model.id!,
    );

    context.read<PreviewAuctionCubit>().withdrawFromAuction(params);
  }

  void _toggleFavorite(BuildContext context) {
    // This would typically call an API to toggle favorite status
    // For now, we'll just show a snackbar
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          model.myfav == true ? 'Removed from favorites' : 'Added to favorites',
        ),
        backgroundColor: Colors.green,
      ),
    );
  }
}
