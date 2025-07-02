import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/services/pagination/pagination_service.dart';
import '../../../../core/utils/enums/enums.dart';
import '../../../../core/utils/widgets/misc/custom_scaffold_widget.dart';
import '../../../auctions/logic/auctions_cubit.dart';
import '../../../auctions/ui/page/auctions_page.dart';
import '../../../bundles/logic/bundles_cubit.dart' show BundlesCubit;
import '../../../bundles/ui/page/bundles_page.dart';
import '../../../category/logic/category_cubit.dart';
import '../../../category/ui/widgets/categories_section.dart';
import '../../logic/home_cubit.dart';
import '../../logic/home_state.dart';
import '../widgets/home_appbar.dart';
import '../widgets/home_search_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => CategoryCubit()..categoriesStatesHandled(),
        ),
        BlocProvider(
            create: (context) =>
                BundlesCubit()..bundlesStatesHandled(SearchEngine())),
        BlocProvider(
            create: (context) =>
                AuctionsCubit()..auctionStatesHandled(SearchEngine())),
      ],
      child: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          final cubit = context.read<HomeCubit>();
          return StreamBuilder(
              stream: context.read<HomeCubit>().categoryTypeStream,
              builder: (c, categorySnapshot) {
                return CustomScaffoldWidget(
                  appbar: const HomeAppbar(),
                  child: StreamBuilder(
                      stream: context.read<HomeCubit>().listingStream,
                      builder: (c, listSnapshot) {
                        return Column(
                          children: [
                            AnimatedOpacity(
                              opacity: 1.0,
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeInOut,
                              child: AnimatedContainer(
                                duration: const Duration(milliseconds: 400),
                                curve: Curves.easeOutQuad,
                                child: CategoriesSection(
                                  onTap: (v) {
                                    if (v?.categoryType !=
                                        CategoryTypes.bundle) {
                                      context
                                          .read<AuctionsCubit>()
                                          .auctionStatesHandled(SearchEngine(
                                              query: {'categoryIds': v?.id}));
                                    }
                                    if (categorySnapshot.data !=
                                        v?.categoryType) {
                                      context
                                          .read<HomeCubit>()
                                          .updateCategoryType(v?.categoryType ??
                                              CategoryTypes.auction);
                                    }
                                  },
                                ),
                              ),
                            ),
                            const HomeSearchCard(),
                            StreamBuilder(
                                stream: context.read<HomeCubit>().listingStream,
                                builder: (c, listSnapshot) {
                                  return categorySnapshot.data ==
                                          CategoryTypes.bundle
                                      ? BundlesPage(
                                          isListing: listSnapshot.data == true)
                                      : AuctionsPage(
                                          isListing: listSnapshot.data == true);
                                }),
                          ],
                        );
                      }),
                );
              });
        },
      ),
    );
  }
}
