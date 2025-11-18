import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/params/bundle_details_route_params.dart';
import '../../logic/bundle_details_cubit.dart';
import 'bundle_details_mobile_design.dart';

class BundleDetailsScreen extends StatefulWidget {
  const BundleDetailsScreen({super.key, required this.routeParams});
  final BundleDetailsRouteParams routeParams;

  @override
  State<BundleDetailsScreen> createState() => _BundleDetailsScreenState();
}

class _BundleDetailsScreenState extends State<BundleDetailsScreen> {
  late BundleDetailsCubit _cubit;

  @override
  void initState() {
    super.initState();
    _cubit = BundleDetailsCubit();
    _cubit.getBundleDetails(widget.routeParams);
    _cubit.startAutoRefresh();
  }

  @override
  void dispose() {
    _cubit.stopAutoRefresh();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _cubit,
      child: BundleDetailsMobileDesignScreen(routeParams: widget.routeParams),
    );
  }
}
