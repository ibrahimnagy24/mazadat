import 'package:equatable/equatable.dart';

class GetPreviewAuctionDetailsParams extends Equatable {
  final int id;

  const GetPreviewAuctionDetailsParams({required this.id});

  @override
  List<Object?> get props => [id];

  Map<String, dynamic> toMap() {
    return {
      'id': id,
    };
  }
}
