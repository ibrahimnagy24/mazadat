import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/services/pagination/pagination_service.dart';
import '../../../../core/shared/entity/error_entity.dart';
import '../../../../core/utils/extensions/extensions.dart';
import '../../../../core/utils/extensions/media_query_helper.dart';
import '../../../../core/utils/widgets/animated/animated_widget.dart';
import '../../../../core/utils/widgets/custom_loading_text.dart';
import '../../../../core/utils/widgets/errors/error_message_widget.dart';
import '../../../../core/utils/widgets/shimmer/custom_shimmer.dart';
import '../../../search_result/ui/widgets/search_result_card.dart';
import '../../logic/search_cubit.dart';
import '../../logic/search_state.dart';

class SearchBody extends StatelessWidget {
  const SearchBody({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<SearchCubit>();
    return Expanded(child: BlocBuilder<SearchCubit, SearchState>(
      builder: (context, state) {
        if (state is SearchLoading) {
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
        if (state is SearchError || state is SearchEmpty) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: ErrorMessageWidget(
              error: state is SearchError
                  ? state.error
                  : const ErrorEntity(
                      message: 'no Data', statusCode: 200, errors: []),
              onTap: () {
                cubit.searchStatesHandled(SearchEngine());
              },
            ),
          );
        }
        if (state is SearchSuccess) {
          return Column(
            children: [
              Expanded(
                  child: ListAnimator(
                controller: cubit.controller,
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                data: List.generate(
                  state.auctions.length,
                  (i) => SearchResultCard(
                      withClear: false, auction: state.auctions[i]),
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
