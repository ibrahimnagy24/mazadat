import 'package:flutter/material.dart';

import '../../../../core/shared/entity/error_entity.dart';
import '../../../../core/utils/widgets/errors/error_message_widget.dart';

class HomeAuctionErrorWidget extends StatelessWidget {
  const HomeAuctionErrorWidget({
    super.key,
    required this.errorEntity,
    this.onTap,
  });
  final ErrorEntity errorEntity;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: ErrorMessageWidget(
        error: errorEntity,
        onTap: onTap,
      ),
    );
  }
}
