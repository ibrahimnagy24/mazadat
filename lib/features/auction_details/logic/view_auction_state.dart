part of 'view_auction_cubit.dart';

sealed class ViewAuctionState extends Equatable {
  const ViewAuctionState();

  @override
  List<Object> get props => [];
}

class ViewAuctionInitial extends ViewAuctionState {}

class ViewAuctionImagesLoaded extends ViewAuctionState {
  final List<String> imageUrls;
  final int selectedImageIndex;

  const ViewAuctionImagesLoaded({
    required this.imageUrls,
    this.selectedImageIndex = 0,
  });

  @override
  List<Object> get props => [imageUrls, selectedImageIndex];

  ViewAuctionImagesLoaded copyWith({
    List<String>? imageUrls,
    int? selectedImageIndex,
  }) {
    return ViewAuctionImagesLoaded(
      imageUrls: imageUrls ?? this.imageUrls,
      selectedImageIndex: selectedImageIndex ?? this.selectedImageIndex,
    );
  }
}
