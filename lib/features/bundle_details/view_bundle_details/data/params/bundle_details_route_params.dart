import 'package:equatable/equatable.dart';

class BundleDetailsRouteParams extends Equatable {
  final int bundleId;
  final bool fromMyBundles;

  const BundleDetailsRouteParams(
      {required this.bundleId,  this.fromMyBundles = false});

  Map<String, dynamic> toMap() {
    return {
      'id': bundleId,
      'fromMyBundles': fromMyBundles,
    };
  }

  @override
  List<Object?> get props => [bundleId, fromMyBundles];
}
