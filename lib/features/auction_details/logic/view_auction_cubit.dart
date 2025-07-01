import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'view_auction_state.dart';

class ViewAuctionCubit extends Cubit<ViewAuctionState> {
  ViewAuctionCubit() : super(ViewAuctionInitial());
  
//---------------------------------VARIABLES----------------------------------//
  // Mock data for demonstration - in a real app, this would come from an API
  final List<String> _mockImages = List.generate(
    10, 
    (index) => 'https://picsum.photos/800/800?random=$index'
  );

//---------------------------------FUNCTIONS----------------------------------//
  /// Load the auction images (in a real app, this would fetch from an API)
  void loadAuctionImages() {
    emit(ViewAuctionImagesLoaded(imageUrls: _mockImages));
  }
  
  /// Select a specific image from the gallery
  void selectImage(int index) {
    final currentState = state;
    if (currentState is ViewAuctionImagesLoaded) {
      // Only update if the index is valid
      if (index >= 0 && index < currentState.imageUrls.length) {
        emit(currentState.copyWith(selectedImageIndex: index));
      }
    }
  }
  
  /// Get the currently selected image URL
  String? getSelectedImageUrl() {
    final currentState = state;
    if (currentState is ViewAuctionImagesLoaded) {
      return currentState.imageUrls[currentState.selectedImageIndex];
    }
    return null;
  }

//----------------------------------REQUEST-----------------------------------//
}
