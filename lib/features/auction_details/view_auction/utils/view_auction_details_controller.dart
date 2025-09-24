import 'package:flutter/material.dart';

import '../../../../core/utils/utility.dart';

class ViewAuctionDetailsController with ChangeNotifier {
  ViewAuctionDetailsController({required TickerProvider vsync}) {
    _animController = AnimationController(
      vsync: vsync,
      duration: const Duration(milliseconds: 250),
    );

    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.0).animate(
        CurvedAnimation(parent: _animController, curve: Curves.easeOutCubic));

    _sheetController.addListener(_updateImageScaleOnDrag);
  }

  final DraggableScrollableController _sheetController =
      DraggableScrollableController();
  double _imageScale = 1.0;
  bool _isSheetExpanded = false;

  final double _maxImageFraction = 0.8;
  final double _minImageFraction = 0.3;
  final double _sheetOverlapFraction = 0.1;
  late AnimationController _animController;
  late Animation<double> _scaleAnimation;

  double _lastSize = 0.5;

  DraggableScrollableController get sheetController => _sheetController;
  Animation<double> get scaleAnimation => _scaleAnimation;
  double get maxImageFraction => _maxImageFraction;
  double get minImageFraction => _minImageFraction;
  bool get isSheetExpanded => _isSheetExpanded;

  /// Returns whether the sheet controller is attached to a DraggableScrollableSheet
  bool get isSheetAttached => _sheetController.isAttached;

  /// Returns the current size of the draggable sheet as a fraction (0.0 to 1.0)
  /// If the sheet is not attached, returns the initial size (0.5)
  double get currentSheetFraction {
    try {
      if (_sheetController.isAttached) {
        return _sheetController.size;
      }
      // Return initial child size if sheet not attached yet
      return 0.5; // Default value matching initialChildSize in AuctionDraggableSheet
    } catch (e) {
      cprint('Error getting sheet fraction: $e');
      return 0.5; // Default fallback
    }
  }

  /// Calculate the current hero image height based on screen size and animation value
  /// This can be used to position elements relative to the hero image
  double calculateHeroImageHeight(double screenHeight) {
    return screenHeight *
        (minImageFraction +
            (maxImageFraction - minImageFraction) * scaleAnimation.value);
  }

  void _updateImageScaleOnDrag() {
    final currentSize = _sheetController.size;

    final normalizedSheetSize = (currentSize - 0.3) / 0.4;
    final targetScale = 1.0 - (normalizedSheetSize * 0.3);

    _scaleAnimation = Tween<double>(
      begin: _imageScale,
      end: targetScale,
    ).animate(CurvedAnimation(
      parent: _animController,
      curve: Curves.easeOutCubic,
    ));

    _imageScale = targetScale;
    _lastSize = currentSize;

    _animController.reset();
    _animController.forward();

    _isSheetExpanded = currentSize > 0.5;
    notifyListeners();
  }

  @override
  void dispose() {
    _animController.dispose();
    _sheetController.removeListener(_updateImageScaleOnDrag);
    _sheetController.dispose();
    super.dispose();
  }
}
