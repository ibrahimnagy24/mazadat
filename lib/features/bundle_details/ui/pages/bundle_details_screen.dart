import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_builder/responsive_builder.dart';
import '../../../../core/utils/constant/app_constant.dart';
import '../../data/params/bundle_details_route_params.dart';
import '../../logic/bundle_details_cubit.dart';
import 'bundle_details_mobile_design.dart';

class BundleDetailsScreen extends StatelessWidget {
  const BundleDetailsScreen({super.key, required this.routeParams});
  final BundleDetailsRouteParams routeParams;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BundleDetailsCubit()..getBundleDetails(routeParams),
      child: BundleDetailsMobileDesignScreen(routeParams: routeParams),
    );
  }
}
