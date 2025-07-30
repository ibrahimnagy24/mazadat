import 'package:equatable/equatable.dart';

class ViewWalletParams extends Equatable {
  final int page;
  final int? size;
  const ViewWalletParams({
    required this.page,
    this.size = 10,
  });

  Map<String, dynamic> returnedMap() {
    Map<String, dynamic> map = {
      'page': page,
      'size': size,
    };
    map.removeWhere((key, value) => value == null);
    return map;
  }

  @override
  List<Object?> get props => [page];
}
