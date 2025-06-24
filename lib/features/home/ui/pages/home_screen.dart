import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/utils/widgets/misc/custom_scaffold_widget.dart';
import '../../../auth/choose_category/logic/category_cubit.dart';
import '../../data/enums/home_enums.dart';
import '../../logic/home_cubit.dart';
import '../../logic/home_state.dart';
import '../widgets/home_appbar_widget.dart';
import '../widgets/home_bundle_auctions_widget.dart';
import '../widgets/home_current_auctions_widget.dart';
import '../widgets/home_featured_auctions_widget.dart';
import '../widgets/home_upcomming_auctions_widget.dart';

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
          create: (context) => HomeCubit()
            ..auctionStatesHandled(HomeAuctionType.featured)
            ..auctionStatesHandled(HomeAuctionType.inProgress)
            ..auctionStatesHandled(HomeAuctionType.upComing),
        ),
      ],
      child: BlocBuilder<HomeCubit, HomeState>(
        buildWhen: (previous, current) => current is HomeTitleTypeChanged,
        builder: (context, state) {
          final isAuctionSelected =
              context.read<HomeCubit>().getHomeTitleType ==
                  HomeTitleType.auction;
          return CustomScaffoldWidget(
            appbar: HomeAppbarWidget(height: isAuctionSelected ? 370 : 270),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: CustomScrollView(
                slivers: isAuctionSelected
                    ? const [
                        //FEATURED
                        HomeFeaturedTitleWidget(),
                        HomeFeaturedWidget(),
                        //CURRENT
                        HomeCurrentAuctionsTitleWidget(),
                        HomeCurrentAuctionsWidget(),
                        //UPCOMING
                        HomeUpComingAuctionsTitleWidget(),
                        HomeUpComingAuctionsWidget(),
                      ]
                    : const [
                        HomeBundleTitleWidget(),
                        HomeBundleAuctionsWidget(),
                      ],
              ),
            ),
          );
        },
      ),
    );
  }
}
