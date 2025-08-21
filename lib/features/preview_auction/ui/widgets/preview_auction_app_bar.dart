import 'package:flutter/material.dart';
import '../../../../core/utils/extensions/extensions.dart';

class PreviewAuctionAppBar extends StatelessWidget {
  const PreviewAuctionAppBar({
    super.key,
    required this.auctionStatus,
  });

  final String auctionStatus;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 100.h,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.black.withOpacity(0.6),
            Colors.transparent,
          ],
        ),
      ),
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                decoration: BoxDecoration(
                  color: _getStatusColor(auctionStatus),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  auctionStatus,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'active':
      case 'live':
        return Colors.green;
      case 'upcoming':
      case 'scheduled':
        return Colors.blue;
      case 'ended':
      case 'closed':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }
}
