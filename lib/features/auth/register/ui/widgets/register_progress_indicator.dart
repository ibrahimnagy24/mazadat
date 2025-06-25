import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/theme/colors/styles.dart';
import '../../../../../core/utils/extensions/extensions.dart';
import '../../../../../core/utils/extensions/media_query_helper.dart';
import '../../logic/register_cubit.dart';

class RegisterProgressIndicator extends StatelessWidget {
  const RegisterProgressIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<int>(
        stream: context.read<RegisterCubit>().stepStream,
        builder: (context, snapshot) {
          return Row(
            children: List.generate(
              2,
              (i) => Expanded(
                  child: GestureDetector(
                onTap: () => context.read<RegisterCubit>().updateStep(0),
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 4.w),
                  width: MediaQueryHelper.width,
                  height: 5.h,
                  decoration: BoxDecoration(
                      color: i == 0
                          ? AppColors.kPrimary
                          : (snapshot.data ?? 0) == 1
                              ? AppColors.kPrimary200
                              : AppColors.kWhite,
                      borderRadius: BorderRadius.circular(100)),
                ),
              )),
            ),
          );
        });
  }
}
