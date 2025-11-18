import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/navigation/custom_navigation.dart';
import '../../../../../core/services/pagination/pagination_service.dart';
import '../../../../../core/theme/text_styles/text_styles.dart';
import '../../../../../core/utils/constant/app_strings.dart';
import '../../../../../core/utils/extensions/extensions.dart';
import '../../../../../core/utils/widgets/animated/animated_widget.dart';
import '../../../../../core/utils/widgets/buttons/default_button.dart';
import '../../../../category/logic/category_cubit.dart';
import 'categories_filter_section.dart';
import '../../../../selectors/auction_statuses/logic/auction_statuses_cubit.dart';
import '../../../../selectors/auction_statuses/ui/page/auction_statuses_filter.dart';
import '../../data/params/filter_params.dart';
import '../../logic/search_cubit.dart';
import 'search_opening_price_filter.dart';
import 'search_order_filter.dart';

class SearchFilterView extends StatelessWidget {
  const SearchFilterView({super.key, required this.blocContext});
  final BuildContext blocContext;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => CategoryCubit()..categoriesStatesHandled(),
        ),
        BlocProvider(
          create: (context) =>
              AuctionStatusesCubit()..auctionStatusesStatesHandled(),
        ),
      ],
      child: StreamBuilder<FilterParams>(
          stream: blocContext.read<SearchCubit>().filterStream,
          builder: (context, snapshot) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                spacing: 12,
                children: [
                  Flexible(
                    child: ListAnimator(
                      data: [
                        ///Categories Filter
                        CategoriesFilterSection(
                          initialValues: snapshot.data?.categories,
                          onTap: (v) => blocContext
                              .read<SearchCubit>()
                              .updateFilter(
                                  snapshot.data!.copyWith(categories: v)),
                        ),

                        ///Auction Statuses Filter
                        AuctionStatusFilterSection(
                          initialValue: snapshot.data?.auctionStatus,
                          onTap: (v) => blocContext
                              .read<SearchCubit>()
                              .updateFilter(snapshot.data!.copyWith(
                                  auctionStatus: v,
                                  clearAuctionStatus: v == null)),
                        ),

                        ///Opening Price Filter
                        SearchOpeningPriceFilter(
                          initialValue: snapshot.data?.openingPriceRange,
                          onTap: (v) => blocContext
                              .read<SearchCubit>()
                              .updateFilter(snapshot.data!
                                  .copyWith(openingPriceRange: v)),
                        ),
                        12.sbH,
                        const Divider(color: Color.fromRGBO(232, 232, 232, 1)),

                        ///Search Order
                        SearchOrderFilter(
                          initialValue: snapshot.data?.order,
                          onTap: (v) => blocContext
                              .read<SearchCubit>()
                              .updateFilter(snapshot.data!.copyWith(order: v)),
                        ),
                      ],
                    ),
                  ),

                  ///Apply Button
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 16.w),
                    child: DefaultButton(
                      text: AppStrings.apply.tr,
                      textStyle: AppTextStyles.textXLBold.copyWith(
                          color: const Color.fromRGBO(255, 255, 255, 1)),
                      onPressed: () {
                        blocContext
                            .read<SearchCubit>()
                            .searchStatesHandled(SearchEngine());
                        CustomNavigator.pop();
                      },
                    ),
                  ),
                ],
              ),
            );
          }),
    );
  }
}
