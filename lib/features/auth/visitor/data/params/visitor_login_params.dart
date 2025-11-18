import 'package:equatable/equatable.dart';

class VisitorLoginParams extends Equatable {
  final String deviceName;
  final String deviceType;
  final String lang;
  final List<Map<String, dynamic>> categories;

  const VisitorLoginParams({
    required this.deviceName,
    required this.deviceType,
    required this.lang,
    required this.categories,
  });
  Map<String, dynamic> returnedMap() {
    Map<String, dynamic> map = {
      'device': deviceName,
      'platform': deviceType,
      'language': lang,
      'favoriteCategories': categories,
    };
    map.removeWhere((key, value) => value == null);
    return map;
  }

  @override
  List<Object?> get props => [deviceName, deviceType, lang, categories];
}
