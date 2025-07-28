import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/utils/widgets/misc/custom_screen_type_layout_widget.dart';
import '../../logic/view_wallet_history_cubit.dart';
import 'view_wallet_history_screen_mobile_design.dart';

class ViewWalletHistoryScreen extends StatelessWidget {
  const ViewWalletHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ViewWalletHistoryCubit()..viewHistoryStatesHandled(),
      child: CustomScreenTypeLayoutWidget(
        mobilePortrait: (context) =>
            const ViewWalletHistoryScreenMobileDesign(),
        mobileLandscape: (context) =>
            const ViewWalletHistoryScreenMobileDesign(),
      ),
    );
  }
}
