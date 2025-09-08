import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/utils/utility.dart';
import '../../../../../core/utils/widgets/errors/error_screen.dart';
import '../../../../../core/utils/widgets/loading/adaptive_circle_progress.dart';
import '../../../../../core/utils/widgets/misc/custom_screen_type_layout_widget.dart';
import '../../../../visitor/ui/pages/visitor_screen.dart';
import '../../logic/view_my_wallet_cubit.dart';
import '../../logic/view_my_wallet_state.dart';
import 'view_wallet_screen_mobile_design.dart';

class ViewWalletScreen extends StatelessWidget {
  const ViewWalletScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return !Utility.isUserLoggedIn()
        ? const VisitorScreen()
        : BlocProvider(
            create: (context) =>
                ViewMyWalletCubit()..viewMyWalletStatesHandled(),
            child: BlocBuilder<ViewMyWalletCubit, ViewMyWalletState>(
              builder: (context, state) {
                final cubit = context.read<ViewMyWalletCubit>();
                if (state is ViewMyWalletLoading) {
                  return const Center(child: AdaptiveCircularProgress());
                }
                if (state is ViewMyWalletError) {
                  return ErrorScreen(
                    error: state.error,
                    onPressed: () {
                      context
                          .read<ViewMyWalletCubit>()
                          .viewMyWalletStatesHandled();
                    },
                  );
                }
                if (state is ViewMyWalletSuccess ||
                    cubit.viewMyWalletEntity != null) {
                  return CustomScreenTypeLayoutWidget(
                    mobilePortrait: (context) =>
                        const ViewWalletScreenMobileDesign().animate().fadeIn(),
                    mobileLandscape: (context) =>
                        const ViewWalletScreenMobileDesign().animate().fadeIn(),
                  );
                }
                return const SizedBox.shrink();
              },
            ),
          );
  }
}
