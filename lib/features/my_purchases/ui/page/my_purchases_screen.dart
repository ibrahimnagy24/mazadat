import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../logic/my_purchases_cubit.dart';
import 'my_purchases_mobile_design.dart';

class MyPurchasesScreen extends StatelessWidget {
  const MyPurchasesScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MyPurchasesCubit()..getShipments(),
      child: const MyPurchasesMobileDesign(),
    );
  }
}
