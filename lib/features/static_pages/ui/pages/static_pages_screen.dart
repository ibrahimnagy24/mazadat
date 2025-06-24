import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/shared/widgets/custom_back_icon.dart';
import '../../../../core/theme/text_styles/text_styles.dart';
import '../../../../core/utils/constant/app_constant.dart';
import '../../../../core/utils/extensions/extensions.dart';
import '../../../../core/utils/widgets/misc/custom_scaffold_widget.dart';
import '../../../../core/utils/widgets/text/main_text.dart';
import '../../data/params/static_page_params.dart';
import '../../logic/static_page_cubit.dart';
import '../../logic/static_page_state.dart';
import '../stats/static_page_error_widget.dart';
import '../stats/static_page_loading_widget.dart';
import '../stats/static_page_success_widget.dart';

class StaticPageScreen extends StatelessWidget {
  const StaticPageScreen({super.key, required this.params});
  final StaticPageParams params;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<StaticPageCubit>(
      create: (context) => StaticPageCubit()..getStaticPage(params),
      child: CustomScaffoldWidget(
        appbarTitle: MainText(
          text: params.title.tr,
          style: AppTextStyles.balooBhaijaan2W600Size16Primary1000
              .copyWith(fontSize: 16),
        ),
        centerAppbarTitle: true,
        appbarLeading: const CustomBackIcon(),
        appbarHeight: AppConstant.appbarheight,
        child: BlocBuilder<StaticPageCubit, StaticPageState>(
          buildWhen: (previous, current) =>
              current is GetStaticPageLoading ||
              current is GetStaticPageSuccess ||
              current is GetStaticPageError,
          builder: (context, state) {
            if (state is GetStaticPageLoading) {
              return const StaticPageLoadingWidget();
            }

            if (state is GetStaticPageSuccess) {
              return StaticPageSuccessWidget(state.entity);
            }

            if (state is GetStaticPageError) {
              return StaticPageErrorWidget(
                error: state.error,
                params: params,
              );
            }
            return const Text('no state provided');
          },
        ),
      ),
    );
  }
}
