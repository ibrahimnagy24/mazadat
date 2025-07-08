import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../../../../core/services/pagination/pagination_service.dart';
import '../../../../core/utils/constant/app_constant.dart';
import '../../logic/my_purchases_cubit.dart';
import 'my_purchases_mobile_design.dart';

class MyPurchasesScreen extends StatelessWidget {
  const MyPurchasesScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          MyPurchasesCubit()..myPurchasesStatesHandled(SearchEngine()),
      child: ScreenTypeLayout.builder(
        breakpoints: AppConstant.breakpoints,
        mobile: (_) => OrientationLayoutBuilder(
          portrait: (context) => const MyPurchasesMobileDesign(),
          landscape: (context) => const MyPurchasesMobileDesign(),
        ),
        tablet: (_) => OrientationLayoutBuilder(
          portrait: (context) => const MyPurchasesMobileDesign(),
          landscape: (context) => const MyPurchasesMobileDesign(),
        ),
      ),
    );
  }
}
