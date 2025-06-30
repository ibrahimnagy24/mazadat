import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/utils/widgets/misc/custom_scaffold_widget.dart';
import '../../../auctions/data/params/auction_params.dart';
import '../../../auctions/logic/auctions_cubit.dart';
import '../../../auctions/ui/page/auctions_page.dart';
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
            create: (context) => AuctionsCubit()..auctionStatesHandled()),
      ],
      child: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          final cubit = context.read<HomeCubit>();
          return CustomScaffoldWidget(
            appbar: const HomeAppbar(),
            child: CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: AnimatedOpacity(
                    opacity: 1.0,
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 400),
                      curve: Curves.easeOutQuad,
                      child: CategoriesSection(
                        onTap: (v) => context
                            .read<AuctionsCubit>()
                            .auctionStatesHandled(
                                params: AuctionParams(categoryId: v.id)),
                      ),
                    ),
                  ),
                ),
                const HomeSearchCard(),
                StreamBuilder(
                    stream: context.read<HomeCubit>().listingStream,
                    builder: (c, snapshot) {
                      return AuctionsPage(isListing: snapshot.data == true);
                    }),
                // //CURRENT
                // HomeCurrentAuctionsTitleWidget(),
                // HomeCurrentAuctionsWidget(),
                // //UPCOMING
                // HomeUpComingAuctionsTitleWidget(),
                // HomeUpComingAuctionsWidget(),
              ],

              // isAuctionSelected
              //     ? const [
              //         HomeBundleTitleWidget(),
              //         HomeBundleAuctionsWidget(),
              //       ],
            ),
          );
        },
      ),
    );
  }
}
