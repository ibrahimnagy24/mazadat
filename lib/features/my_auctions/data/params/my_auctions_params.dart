import 'package:equatable/equatable.dart';

class MyAuctionsParams extends Equatable {
  final String status;

  const MyAuctionsParams({required this.status});

  Map<String, dynamic> returnedMap() {
    Map<String, dynamic> map = {'status': status};
    map.removeWhere((key, value) => value == null);
    return map;
  }

  @override
  List<Object?> get props => [status];
}
