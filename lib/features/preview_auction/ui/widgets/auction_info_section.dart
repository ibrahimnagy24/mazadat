import 'package:flutter/material.dart';
import '../../../../core/utils/extensions/extensions.dart';
import '../../data/model/auction_details_model.dart';

class AuctionInfoSection extends StatelessWidget {
  const AuctionInfoSection({
    super.key,
    required this.model,
  });

  final AuctionDetailsModel model;

  @override
  Widget build(BuildContext context) {
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
          const Text(
            'Auction Information',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),

          const SizedBox(height: 16),

          // Auction Type and Category
          if (model.auctionType != null || model.auctionCategory != null)
            Row(
              children: [
                if (model.auctionType != null) ...[
                  Expanded(
                    child: _InfoItem(
                      label: 'Type',
                      value: model.auctionType!.toUpperCase(),
                    ),
                  ),
                ],
                if (model.auctionCategory != null) ...[
                  Expanded(
                    child: _InfoItem(
                      label: 'Category',
                      value: model.auctionCategory!.name,
                    ),
                  ),
                ],
              ],
            ),

          SizedBox(height: 12.h),

          // Start and End Dates
          Row(
            children: [
              Expanded(
                child: _InfoItem(
                  label: 'Start Date',
                  value: _formatDateTime(model.startDate),
                ),
              ),
              Expanded(
                child: _InfoItem(
                  label: 'End Date',
                  value: _formatDateTime(model.endDate),
                ),
              ),
            ],
          ),

          SizedBox(height: 12.h),

          // Duration and Status
          Row(
            children: [
              if (model.auctionDuration != null) ...[
                Expanded(
                  child: _InfoItem(
                    label: 'Duration',
                    value: model.auctionDuration!,
                  ),
                ),
              ],
              Expanded(
                child: _InfoItem(
                  label: 'Status',
                  value: _getStatusText(),
                  valueColor: _getStatusColor(),
                ),
              ),
            ],
          ),

          // Participation Status
          if (model.isJoined != null) ...[
            SizedBox(height: 12.h),
            _InfoItem(
              label: 'Participation',
              value: model.isJoined! ? 'Joined' : 'Not Joined',
              valueColor: model.isJoined! ? Colors.green : Colors.orange,
            ),
          ],

          // Bidding Method
          if (model.currentBiddingMethod != null) ...[
            SizedBox(height: 12.h),
            _InfoItem(
              label: 'Bidding Method',
              value: model.currentBiddingMethod!.toUpperCase(),
            ),
          ],
        ],
      ),
    );
  }

  String _formatDateTime(DateTime? dateTime) {
    if (dateTime == null) return 'N/A';
    return '${dateTime.day}/${dateTime.month}/${dateTime.year} ${dateTime.hour}:${dateTime.minute.toString().padLeft(2, '0')}';
  }

  String _getStatusText() {
    if (model.isEnded == true) return 'Ended';
    if (model.isStarted == true) return 'Active';
    return 'Upcoming';
  }

  Color _getStatusColor() {
    if (model.isEnded == true) return Colors.red;
    if (model.isStarted == true) return Colors.green;
    return Colors.blue;
  }
}

class _InfoItem extends StatelessWidget {
  const _InfoItem({
    required this.label,
    required this.value,
    this.valueColor,
  });

  final String label;
  final String value;
  final Color? valueColor;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey[600],
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: valueColor ?? Theme.of(context).textTheme.bodyLarge?.color,
          ),
        ),
      ],
    );
  }
}
