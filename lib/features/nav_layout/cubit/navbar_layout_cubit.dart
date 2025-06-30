import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../home/ui/pages/home_screen.dart';
import 'navbar_layout_state.dart';

class NavbarLayoutCubit extends Cubit<NavbarLayoutState> {
  NavbarLayoutCubit() : super(const NavbarLayoutState());
//---------------------------------VARIABLES----------------------------------//
  PageController pageController = PageController(initialPage: 0);
  final List<Widget> pages = [
    const HomeScreen(),
    const SizedBox(),
    const SizedBox(),
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
