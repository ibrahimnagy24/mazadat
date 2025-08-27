import 'package:flutter/material.dart';
import 'view_auction_controller.dart';

class ViewAuctionProvider extends InheritedNotifier<ViewAuctionController> {
  const ViewAuctionProvider({
    super.key,
    required ViewAuctionController controller,
    required super.child,
  }) : super(notifier: controller);

  static ViewAuctionController of(BuildContext context) {
    final provider =
        context.dependOnInheritedWidgetOfExactType<ViewAuctionProvider>();
    if (provider == null) {
      throw Exception('ViewAuctionProvider not found in the widget tree');
    }
    return provider.notifier!;
  }
}
