import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../core/assets/app_svg.dart';
import '../../../../core/theme/colors/styles.dart';
import '../../../../core/theme/radius/app_radius.dart';
import '../../../../core/theme/text_styles/text_styles.dart';
import '../../../../core/utils/constant/app_strings.dart';
import '../../../../core/utils/extensions/extensions.dart';
import '../../../../core/utils/utility.dart';
import '../../../../core/utils/widgets/misc/custom_scaffold_widget.dart';
import '../../../home/data/enum/displayed_types.dart';
import '../../../visitor/ui/pages/visitor_screen.dart';
import '../../logic/my_auctions_cubit.dart';
import '../../logic/my_auctions_state.dart';
import '../widgets/my_auctions_displayed_auctions_widget.dart';
import '../widgets/my_auctions_status_tabs.dart';

class MyAuctionsScreen extends StatelessWidget {
  const MyAuctionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MyAuctionsCubit()..myAuctionsStatesHandled(),
      child: BlocBuilder<MyAuctionsCubit, MyAuctionsState>(
        builder: (context, state) {
          final cubit = context.read<MyAuctionsCubit>();
          return CustomScaffoldWidget(
            backgroundColor: AppColors.scaffoldBackground,
            appbar: AppBar(
              actionsPadding: const EdgeInsets.symmetric(horizontal: 24),
              backgroundColor: AppColors.scaffoldBackground,
              centerTitle: false,
              title: Padding(
                padding: const EdgeInsetsDirectional.only(start: 14),
                child: !Utility.isUserLoggedIn()
                    ? const SizedBox.shrink()
                    : Text(
                        AppStrings.myAuctions.tr,
                        style: AppTextStyles.displayMdBold,
                      ),
              ),
              actions: [
                if (Utility.isUserLoggedIn())
                  BlocBuilder<MyAuctionsCubit, MyAuctionsState>(
                    buildWhen: (previous, current) =>
                        current is MyAuctionsDisplayedTypeChanged,
                    builder: (context, state) {
                      final cubit = context.read<MyAuctionsCubit>();
                      return InkWell(
                        onTap: () => cubit.updateOrToggleDisplayedType(),
                        child: Container(
                          height: 52,
                          width: 52,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 14,
                            vertical: 14,
                          ),
                          decoration: BoxDecoration(
                            color: const Color.fromRGBO(255, 255, 255, 0.5),
                            border: Border.all(
                              color: AppColors.borderNeutralSecondary,
                            ),
                            borderRadius: BorderRadius.circular(AppRadius.rMd),
                          ),
                          child: SvgPicture.asset(
                            cubit.displayedType == HomeDisplayedTypes.grid
                                ? AppSvg.grid
                                : AppSvg.list,
                            width: 20,
                            height: 20,
                            color: AppColors.textSecondaryParagraph,
                          ),
                        ),
                      );
                    },
                  ),
              ],
            ),
            child: !Utility.isUserLoggedIn()
                ? const VisitorScreen()
                : const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24),
                    child: Column(
                      children: [
                        SizedBox(height: 24),
                        MyAuctionsStatusTabs(),
                        SizedBox(height: 24),
                        Expanded(child: MyAuctionsDisplayedAuctionsWidget()),
                      ],
                    ),
                  ),
          );
        },
      ),
    );
  }
}
