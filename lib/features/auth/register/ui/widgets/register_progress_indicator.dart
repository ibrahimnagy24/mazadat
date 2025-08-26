import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/theme/colors/styles.dart';
import '../../../../../core/utils/extensions/media_query_helper.dart';
import '../../logic/register_cubit.dart';
import '../../logic/register_state.dart';

class RegisterProgressIndicator extends StatelessWidget {
  const RegisterProgressIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterCubit, RegisterState>(
      buildWhen: (previous, current) {
        return current is RegisterStepChanged || current is RegisterInitial;
      },
      builder: (context, state) {
        final currentStep = context.read<RegisterCubit>().currentStep;
        return GestureDetector(
          onTap: () => context.read<RegisterCubit>().updateStep(0),
          child: Row(
            children: List.generate(
              2,
              (i) => Expanded(
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  width: MediaQueryHelper.width,
                  height: 5,
                  decoration: BoxDecoration(
                      color: currentStep == i
                          ? AppColors.kWhite
                          : const Color.fromRGBO(138, 147, 118, 1),
                      borderRadius: BorderRadius.circular(100)),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
