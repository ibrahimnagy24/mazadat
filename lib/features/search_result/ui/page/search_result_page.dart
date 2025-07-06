import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/services/pagination/pagination_service.dart';
import '../../../../core/shared/entity/error_entity.dart';
import '../../../../core/theme/text_styles/text_styles.dart';
import '../../../../core/utils/constant/app_strings.dart';
import '../../../../core/utils/extensions/extensions.dart';
import '../../../../core/utils/extensions/media_query_helper.dart';
import '../../../../core/utils/widgets/animated/animated_widget.dart';
import '../../../../core/utils/widgets/custom_loading_text.dart';
import '../../../../core/utils/widgets/errors/error_message_widget.dart';
import '../../../../core/utils/widgets/shimmer/custom_shimmer.dart';
import '../../logic/search_result_cubit.dart';
import '../../logic/search_state.dart';
import '../widgets/search_result_card.dart';

class SearchResultPage extends StatelessWidget {
  const SearchResultPage({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<SearchResultCubit>();
    return Expanded(child: BlocBuilder<SearchResultCubit, SearchResultState>(
      builder: (context, state) {
        if (state is SearchResultLoading) {
          return ListAnimator(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            data: List.generate(
              10,
              (i) => Padding(
                padding: EdgeInsets.symmetric(vertical: 8.h),
                child: CustomShimmerContainer(
                  height: 100.h,
                  width: MediaQueryHelper.width,
                ),
              ),
            ),
          );
        }
        if (state is SearchResultError || state is SearchResultEmpty) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: ErrorMessageWidget(
              error: state is SearchResultError
                  ? state.error
                  : const ErrorEntity(
                      message: 'no Data', statusCode: 200, errors: []),
              onTap: () {
                cubit.searchResultStatesHandled(SearchEngine());
              },
            ),
          );
        }
        if (state is SearchResultSuccess) {
          return Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: Row(
                  spacing: 16.w,
                  children: [
                    Expanded(
                      child: Text(
                        AppStrings.lastResult.tr,
                        style: AppTextStyles.textLgBold,
                      ),
                    ),
                    TextButton(
                      onPressed: () =>
                          context.read<SearchResultCubit>().onDeleteAll(),
                      child: Text(
                        AppStrings.deleteAll.tr,
                        style: AppTextStyles.textMdSemibold,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                  child: ListAnimator(
                controller: cubit.controller,
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                data: List.generate(
                  state.auctions.length,
                  (i) => SearchResultCard(auction: state.auctions[i]),
                ),
              )),
              CustomLoadingText(loading: state.isLoading),
            ],
          );
        }
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: const SliverToBoxAdapter(child: Text('no state provided')),
        );
      },
    ));
  }
}
