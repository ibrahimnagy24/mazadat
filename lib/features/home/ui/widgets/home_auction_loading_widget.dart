import 'package:flutter/material.dart';

import '../../../../core/utils/widgets/loading/adaptive_cirluer_progress.dart';

class HomeAuctionLoadingWidget extends StatelessWidget {
  const HomeAuctionLoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const SliverToBoxAdapter(child: AdaptiveCircularProgress());
  }
}
