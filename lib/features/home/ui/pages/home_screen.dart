import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/theme/colors/styles.dart';
import '../../../../core/utils/widgets/misc/custom_scaffold_widget.dart';
import '../../data/enum/home_data_type.dart';
import '../../logic/home_cubit.dart';
import '../../logic/home_state.dart';
import '../widgets/home_appbar.dart';
import '../widgets/home_categories_list_widget.dart';
import '../widgets/home_displayed_auctions_widget.dart';
import '../widgets/home_displayed_bundles_widget.dart';
import '../widgets/home_search_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit()..getSuitableData(),
      child: CustomScaffoldWidget(
        appbar: const HomeAppbar(),
        backgroundColor: AppColors.surfaceBackground,
        child: Column(
          children: [
            const SizedBox(height: 16),
            const Padding(
              padding: EdgeInsetsDirectional.only(start: 12),
              child: HomeCategoriesListWidget(),
            ),
            const SizedBox(height: 16),
            const HomeSearchCard(),
            const SizedBox(height: 24),
            Expanded(
              child: BlocBuilder<HomeCubit, HomeState>(
                buildWhen: (previous, current) =>
                    current is HomeDataTypeChanged,
                builder: (context, state) {
                  final cubit = context.read<HomeCubit>();

                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: cubit.homeDataType == HomeDataType.auctions
                        ? const HomeDisplayedAuctionsWidget()
                        : const HomeDisplayedBundlesWidget(),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
