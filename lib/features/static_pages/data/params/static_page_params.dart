import 'package:equatable/equatable.dart';

class StaticPageParams extends Equatable {
  const StaticPageParams({
    required this.url,
    required this.title,
  });
  final String url;
  final String title;
  @override
  List<Object?> get props => [url, title];
}
