import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../core/assets/app_svg.dart';
import '../../../../core/theme/colors/styles.dart';
import '../../../../core/theme/radius/app_radius.dart';
import '../../../../core/utils/constant/app_strings.dart';
import '../../../../core/utils/extensions/extensions.dart';
import '../../../../core/utils/widgets/form_fields/default_form_field.dart';
import '../../data/enum/display_types.dart';
import '../../logic/my_sales_cubit.dart';
import '../../logic/my_sales_state.dart';

class MySalesHeader extends StatefulWidget {
  const MySalesHeader({super.key});

  @override
  State<MySalesHeader> createState() => _MySalesHeaderState();
}

class _MySalesHeaderState extends State<MySalesHeader> {
  Timer? _debounceTimer;
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _debounceTimer?.cancel();
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged(String query, MySalesCubit cubit) {
    _debounceTimer?.cancel();
    _debounceTimer = Timer(const Duration(milliseconds: 750), () {
      if (query.isEmpty) {
        cubit.clearSearch();
      } else {
        cubit.searchAuctions(query);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MySalesCubit, MySalesState>(
      buildWhen: (previous, current) =>
          current is MySalesDisplayTypeChanged ||
          current is MySalesSearchLoading ||
          current is MySalesSearchSuccess ||
          current is MySalesSearchError,
      builder: (context, state) {
        final cubit = context.read<MySalesCubit>();
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              Row(
                spacing: 8,
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        DefaultFormField(
                          controller: _searchController,
                          hintText: '${AppStrings.searchByAuctionName.tr}...',
                          needValidation: false,
                          prefixIcon: Padding(
                            padding: const EdgeInsetsDirectional.only(
                              start: 16,
                              end: 12,
                              top: 12,
                              bottom: 12,
                            ),
                            child: SvgPicture.asset(
                              AppSvg.searchIcon,
                              color: AppColors.iconDefault,
                              width: 20,
                              height: 20,
                            ),
                          ),
                          onChanged: (value) => _onSearchChanged(value, cubit),
                        ),
                        // Linear loading indicator
                        if (state is MySalesSearchLoading)
                          Container(
                            margin: const EdgeInsets.only(top: 2),
                            height: 2,
                            child: const LinearProgressIndicator(
                              backgroundColor: Colors.transparent,
                              valueColor: AlwaysStoppedAnimation<Color>(AppColors.kPrimary),
                            ),
                          ),
                      ],
                    ),
                  ),
                  ///Display Type Toggle Button
                  InkWell(
                    onTap: () => cubit.updateOrToggleDisplayType(),
                    child: Container(
                      height: 48,
                      width: 48,
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
                      decoration: BoxDecoration(
                          color: AppColors.fillColor,
                          border: Border.all(
                            color: AppColors.border,
                          ),
                          borderRadius: BorderRadius.circular(AppRadius.rMd)),
                      child: SvgPicture.asset(
                        cubit.displayType == MySalesDisplayTypes.list
                            ? AppSvg.grid
                            : AppSvg.list,
                        width: 20,
                        height: 20,
                        color: AppColors.iconDefault,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
