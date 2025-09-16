import 'package:flutter/material.dart';
import '../../../../core/navigation/custom_navigation.dart';
import '../../../../core/navigation/routes.dart';
import '../../../auction_details/view_auction/data/params/view_auction_details_route_params.dart';
import '../../data/entity/my_purchase_content_entity.dart';

class PurchaseCardWidget extends StatelessWidget {
  final MyPurchaseContentEntity purchase;
  final bool isGridView;

  const PurchaseCardWidget({
    super.key,
    required this.purchase,
    this.isGridView = false,
  });

  @override
  Widget build(BuildContext context) {
    final primaryImage = purchase.auction.productImages.isNotEmpty
        ? purchase.auction.productImages.first.path
        : '';

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: InkWell(
        onTap: () => _navigateToDetails(context),
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: isGridView ? _buildGridContent(primaryImage) : _buildListContent(primaryImage),
        ),
      ),
    );
  }

  Widget _buildGridContent(String primaryImage) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Product Image
        Expanded(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(8),
              ),
              child: primaryImage.isNotEmpty
                  ? Image.network(
                      primaryImage,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) =>
                          Icon(Icons.image, color: Colors.grey[400]),
                    )
                  : Icon(Icons.image, color: Colors.grey[400]),
            ),
          ),
        ),
        const SizedBox(height: 8),
        
        // Product Name
        Text(
          purchase.auction.productName,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        const SizedBox(height: 4),
        
        // Order Number
        Text(
          'Order #${purchase.orderNumber}',
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey[600],
          ),
        ),
        const SizedBox(height: 8),
        
        // Status and Price
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildStatusChip(),
            Text(
              '${purchase.totalAmount} SAR',
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: Colors.green,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildListContent(String primaryImage) {
    return Row(
      children: [
        // Product Image
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(8),
            ),
            child: primaryImage.isNotEmpty
                ? Image.network(
                    primaryImage,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) =>
                        Icon(Icons.image, color: Colors.grey[400]),
                  )
                : Icon(Icons.image, color: Colors.grey[400]),
          ),
        ),
        const SizedBox(width: 16),
        
        // Purchase Details
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                purchase.auction.productName,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 4),
              Text(
                'Order #${purchase.orderNumber}',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey[600],
                ),
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Total Amount',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[600],
                    ),
                  ),
                  Text(
                    '${purchase.totalAmount} SAR',
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.green,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Status',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[600],
                    ),
                  ),
                  _buildStatusChip(),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildStatusChip() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: _getStatusColor().withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        purchase.status,
        style: TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.w500,
          color: _getStatusColor(),
        ),
      ),
    );
  }

  Color _getStatusColor() {
    switch (purchase.status.toUpperCase()) {
      case 'PAID':
        return Colors.green;
      case 'PENDING':
        return Colors.orange;
      case 'CANCELLED':
        return Colors.red;
      case 'SHIPPED':
        return Colors.blue;
      case 'DELIVERED':
        return Colors.teal;
      default:
        return Colors.grey;
    }
  }

  void _navigateToDetails(BuildContext context) {
    // Navigate to purchase details or auction details
    CustomNavigator.push(
      Routes.VIEW_AUCTION_DETAILS,
      extra: ViewAuctionDetailsRouteParams(
        auctionId: purchase.id,
        primaryImage: purchase.auction.productImages.isNotEmpty
            ? purchase.auction.productImages.first.path
            : '',
      ),
    );
  }
}
