import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../../../../core/services/pagination/pagination_service.dart';
import '../../../../core/utils/constant/app_constant.dart';
import '../../logic/my_sales_cubit.dart';
import 'my_sales_mobile_design.dart';

class MySalesScreen extends StatelessWidget {
  const MySalesScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          MySalesCubit()..mySalesStatesHandled(SearchEngine()),
      child: ScreenTypeLayout.builder(
        breakpoints: AppConstant.breakpoints,
        mobile: (_) => OrientationLayoutBuilder(
          portrait: (context) => const MySalesMobileDesign(),
          landscape: (context) => const MySalesMobileDesign(),
        ),
        tablet: (_) => OrientationLayoutBuilder(
          portrait: (context) => const MySalesMobileDesign(),
          landscape: (context) => const MySalesMobileDesign(),
        ),
      ),
    );
  }
}
