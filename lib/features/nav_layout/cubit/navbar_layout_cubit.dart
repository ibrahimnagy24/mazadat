import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../home/ui/pages/home_screen.dart';
import '../../more/ui/page/more_screen.dart';
import 'navbar_layout_state.dart';

class NavbarLayoutCubit extends Cubit<NavbarLayoutState> {
  NavbarLayoutCubit() : super(const NavbarLayoutState());
//---------------------------------VARIABLES----------------------------------//
  PageController pageController = PageController(initialPage: 1);
  final List<Widget> pages = [
    const SizedBox(child: Text('test 2')),
    const HomeScreen(),
    const MoreScreen(),
  ];
  int currentIndex = 1;
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
