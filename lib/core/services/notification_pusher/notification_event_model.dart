import 'package:equatable/equatable.dart';

class NotificationEventModel extends Equatable {
  final String? title;
  final String? body;
  final String? type;
  final Map<String, dynamic>? data;

  const NotificationEventModel({
    this.title,
    this.body,
    this.type,
    this.data,
  });

  factory NotificationEventModel.fromJson(Map<String, dynamic> json) {
    return NotificationEventModel(
      title: json['title']?.toString(),
      body: json['body']?.toString(),
      type: json['type']?.toString(),
      data: json['data'] as Map<String, dynamic>?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'body': body,
      'type': type,
      'data': data,
    };
  }

  @override
  List<Object?> get props => [title, body, type, data];
}
