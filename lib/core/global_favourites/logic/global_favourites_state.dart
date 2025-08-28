import 'package:equatable/equatable.dart';

abstract class GlobalFavouritesState extends Equatable {
  const GlobalFavouritesState();

  @override
  List<Object?> get props => [];
}

class GlobalFavouritesInitial extends GlobalFavouritesState {
  const GlobalFavouritesInitial();
}

class GlobalFavouritesLoading extends GlobalFavouritesState {
  const GlobalFavouritesLoading();
}

class GlobalFavouritesLoaded extends GlobalFavouritesState {
  final Set<int> favouriteIds;
  
  const GlobalFavouritesLoaded({required this.favouriteIds});

  @override
  List<Object?> get props => [favouriteIds];

  GlobalFavouritesLoaded copyWith({
    Set<int>? favouriteIds,
  }) {
    return GlobalFavouritesLoaded(
      favouriteIds: favouriteIds ?? this.favouriteIds,
    );
  }
}

class GlobalFavouritesError extends GlobalFavouritesState {
  final String message;
  
  const GlobalFavouritesError({required this.message});

  @override
  List<Object?> get props => [message];
}

class GlobalFavouritesToggling extends GlobalFavouritesState {
  final int itemId;
  final Set<int> favouriteIds;
  
  const GlobalFavouritesToggling({
    required this.itemId,
    required this.favouriteIds,
  });

  @override
  List<Object?> get props => [itemId, favouriteIds];
}
