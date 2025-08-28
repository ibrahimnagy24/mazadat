import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/navigation/custom_navigation.dart';
import '../../../core/utils/utility.dart';
import '../../favourites/ui/page/favourites_screen.dart';
import '../../home/ui/pages/home_screen.dart';
import '../../visitor/ui/pages/visitor_screen.dart';
import '../../wallet/view_wallet/ui/pages/view_wallet_screen.dart';
import 'navbar_layout_state.dart';

class NavbarLayoutCubit extends Cubit<NavbarLayoutState> {
  NavbarLayoutCubit() : super(const NavbarLayoutState());
//---------------------------------VARIABLES----------------------------------//

  static NavbarLayoutCubit get instance =>
      BlocProvider.of(CustomNavigator.navigatorState.currentContext!);

  PageController pageController = PageController(initialPage: 0);
  final List<Widget> pages = [
    const HomeScreen(),
    Utility.isUserLoggedIn() ? const FavouritesScreen() : const VisitorScreen(),
    Utility.isUserLoggedIn() ? const ViewWalletScreen() : const VisitorScreen(),
    Utility.isUserLoggedIn() ? const SizedBox() : const VisitorScreen(),
  ];
  int currentIndex = 0;
//---------------------------------FUNCTIONS----------------------------------//

  void onItemTapped(int index) {
    if (pageController.hasClients) {
      currentIndex = index;
      pageController.animateToPage(
        index,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );

      emit(state.copyWith(currentIndex: index));
    }
  }

  void onPageInit() {
    if (pageController.hasClients) {
      pageController.jumpToPage(currentIndex);
    }
  }

  @override
  Future<void> close() {
    pageController.dispose();
    return super.close();
  }

//----------------------------------REQUEST-----------------------------------//
}
