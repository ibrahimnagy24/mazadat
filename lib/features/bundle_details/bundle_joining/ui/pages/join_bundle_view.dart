import 'package:flutter/material.dart';

import '../../../../../core/utils/widgets/loading/custom_loading.dart';

class JoinBundleView extends StatelessWidget {
  const JoinBundleView({
    super.key,
    required this.id,
    this.onSuccess,
  });
  final int id;
  final Function()? onSuccess;

  @override
  Widget build(BuildContext context) {
    // TODO: Implement the actual join bundle view with payment methods
    // This is a placeholder that matches the structure of JoinAuctionView
    return const Padding(
      padding: EdgeInsets.all(24.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CustomLoading(),
          SizedBox(height: 16),
          Text('Bundle joining implementation coming soon...'),
        ],
      ),
    );
  }
}
