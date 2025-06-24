import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/shared/entity/error_entity.dart';
import '../../../../core/utils/widgets/errors/error_screen.dart';
import '../../data/params/static_page_params.dart';
import '../../logic/static_page_cubit.dart';

class StaticPageErrorWidget extends StatelessWidget {
  const StaticPageErrorWidget({
    super.key,
    required this.error,
    required this.params,
  });
  final ErrorEntity error;
  final StaticPageParams params;
  @override
  Widget build(BuildContext context) {
    return ErrorScreen(
      error: error,
      onPressed: () {
        context.read<StaticPageCubit>().getStaticPage(params);
      },
    );
  }
}
