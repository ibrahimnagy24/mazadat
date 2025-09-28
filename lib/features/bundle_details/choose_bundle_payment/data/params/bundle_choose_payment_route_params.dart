import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../../view_bundle_details/logic/bundle_details_cubit.dart';

class BundleChoosePaymentRouteParams extends Equatable {
  final int bundleId;
  final BundleDetailsCubit? cubit;
  final BuildContext bottomSheetContext;

  const BundleChoosePaymentRouteParams({
    required this.bundleId,
    this.cubit,
    required this.bottomSheetContext,
  });

  Map<String, dynamic> returnedMap() {
    Map<String, dynamic> map = {'bundleId': bundleId};
    map.removeWhere((key, value) => value == null);
    return map;
  }

  @override
  List<Object?> get props => [bundleId];
}
