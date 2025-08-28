import 'package:equatable/equatable.dart';

class FavouriteItem extends Equatable {
  final int id;
  final String? title;
  final String? imageUrl;
  final DateTime addedAt;

  const FavouriteItem({
    required this.id,
    this.title,
    this.imageUrl,
    required this.addedAt,
  });

  @override
  List<Object?> get props => [id, title, imageUrl, addedAt];

  factory FavouriteItem.fromJson(Map<String, dynamic> json) {
    return FavouriteItem(
      id: json['id'] as int,
      title: json['title'] as String?,
      imageUrl: json['imageUrl'] as String?,
      addedAt: DateTime.parse(json['addedAt'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'imageUrl': imageUrl,
      'addedAt': addedAt.toIso8601String(),
    };
  }

  FavouriteItem copyWith({
    int? id,
    String? title,
    String? imageUrl,
    DateTime? addedAt,
  }) {
    return FavouriteItem(
      id: id ?? this.id,
      title: title ?? this.title,
      imageUrl: imageUrl ?? this.imageUrl,
      addedAt: addedAt ?? this.addedAt,
    );
  }
}
