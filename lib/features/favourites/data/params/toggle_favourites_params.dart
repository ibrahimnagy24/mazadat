import 'package:equatable/equatable.dart';

import '../enums/toggle_favorite_auction_enum.dart';

class ToggleFavouritesParams extends Equatable {
  final int? id;
  final ToggleFavoriteAuctions? action;
  final Function()? onSuccess;
  const ToggleFavouritesParams({
    this.id,
    this.action,
    this.onSuccess,
  });
  @override
  List<Object?> get props => [id, action, onSuccess];
  Map<String, dynamic> returnedMap() {
    Map<String, dynamic> map = {
      'id': id,
      'action': action?.name,
    };
    map.removeWhere((key, value) => value == null);
    return map;
  }
}
