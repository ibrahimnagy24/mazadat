import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/theme/colors/styles.dart';
import '../../../../core/utils/extensions/extensions.dart';
import '../../../../core/utils/widgets/text/main_text.dart';
import '../../controller/check_internet_cubit.dart';
import '../../controller/check_internet_state.dart';

class CheckFromInternetConnectionWidget extends StatelessWidget {
  const CheckFromInternetConnectionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<InternetConnectionCubit, InternetConnectionState>(
      buildWhen: (previous, current) =>
          current is InternetConnectionConnected ||
          current is InternetConnectionDisconnected,
      builder: (context, state) {
        if (state is InternetConnectionInitial) {
          return const SizedBox.shrink();
        }
        if (state is InternetConnectionConnected) {
          return const SizedBox.shrink();
        }
        if (state is InternetConnectionDisconnected) {
          return const SizedBox.shrink();
          // return Container(
          //   color: AppColors.RED_CHART_COLOR,
          //   padding: const EdgeInsets.symmetric(vertical: 10),
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.center,
          //     children: [
          //       MainText(
          //         text: 'No internet connection'.tr,
          //         color: AppColors.kWhite,
          //       ),
          //       const SizedBox(width: 10),
          //       const SizedBox(
          //         height: 10,
          //         width: 10,
          //         child: AdaptiveCircularProgress(),
          //       ),
          //     ],
          //   ),
          // );
        }
        if (state is InterConnectionSlow) {
          return Container(
            color: AppColors.ALERT_COLOR,
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                MainText(
                  text: 'your internet connection is very slow'.tr,
                  color: AppColors.kWhite,
                ),
              ],
            ),
          );
        }
        return const SizedBox();
      },
    );
  }
}
