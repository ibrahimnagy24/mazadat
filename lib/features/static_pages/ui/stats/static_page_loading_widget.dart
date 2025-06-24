import 'package:flutter/material.dart';
import '../../../../core/utils/widgets/loading/adaptive_cirluer_progress.dart';

class StaticPageLoadingWidget extends StatelessWidget {
  const StaticPageLoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: AdaptiveCircularProgress());
  }
}
