import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/theme/colors/styles.dart';
import '../../../../../core/theme/text_styles/text_styles.dart';
import '../../../../../core/utils/constant/app_strings.dart';
import '../../../../../core/utils/extensions/extensions.dart';
import '../../../../../core/utils/widgets/custom_app_bar.dart';
import '../../../../../core/utils/widgets/misc/custom_scaffold_widget.dart';
import '../../../search_result/ui/page/search_result_page.dart';
import '../../logic/search_cubit.dart';
import '../../logic/search_state.dart';
import '../widgets/search_body.dart';
import '../widgets/search_header.dart';

class SearchMobileDesign extends StatelessWidget {
  const SearchMobileDesign({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffoldWidget(
      needAppbar: true,
      appbar: CustomAppBar(
        title: AppStrings.search.tr,
        titleStyle: AppTextStyles.displayMdBold
            .copyWith(color: const Color.fromRGBO(34, 39, 21, 1)),
        backColor: const Color.fromRGBO(22, 22, 22, 1),
      ),
      child: AnnotatedRegion<SystemUiOverlayStyle>(
        value: const SystemUiOverlayStyle(
          statusBarColor: AppColors.transparent,
          statusBarIconBrightness: Brightness.dark,
          statusBarBrightness: Brightness.light,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SearchHeader(),
            16.sbH,
            BlocBuilder<SearchCubit, SearchState>(
              builder: (context, state) {
                final cubit = context.read<SearchCubit>();

                if (state is SearchInitial) {
                  return const SearchResultPage();
                } else {
                  return const SearchBody();
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
