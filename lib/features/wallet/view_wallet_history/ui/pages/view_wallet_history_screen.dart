import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/utils/widgets/misc/custom_screen_type_layout_widget.dart';
import '../../data/params/view_wallet_history_route_params.dart';
import 'view_wallet_history_screen_mobile_design.dart';

class ViewWalletHistoryScreen extends StatelessWidget {
  const ViewWalletHistoryScreen({super.key, required this.params});
  final ViewWalletHistoryRouteParams params;
  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: params.viewMyWalletCubit,
      child: CustomScreenTypeLayoutWidget(
        mobilePortrait: (context) =>
            ViewWalletHistoryScreenMobileDesign(params: params),
        mobileLandscape: (context) =>
            ViewWalletHistoryScreenMobileDesign(params: params),
      ),
    );
  }
}
