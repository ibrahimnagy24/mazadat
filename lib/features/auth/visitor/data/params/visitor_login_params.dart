import 'package:equatable/equatable.dart';

class VisitorLoginParams extends Equatable {
  final String deviceName;
  final String deviceType;
  final String lang;

  const VisitorLoginParams({
    required this.deviceName,
    required this.deviceType,
    required this.lang,
  });
  Map<String, dynamic> returnedMap() {
    Map<String, dynamic> map = {
      'device': deviceName,
      'platform': deviceType,
      'language': lang,
    };
    map.removeWhere((key, value) => value == null);
    return map;
  }

  @override
  List<Object?> get props => [deviceName, deviceType, lang];
}
