import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:musicplayer/Controller/search_controller.dart';
import 'package:musicplayer/UI/BottomNavigatorBar/homescreen.dart';

import '../UI/BottomNavigatorBar/favourite_screen.dart';
import '../UI/BottomNavigatorBar/searchscreen.dart';

class BottomNavigationController extends GetxController {
  final SearchingController searchController = Get.put(SearchingController());

  RxInt selectedIndex = 0.obs;
  List<Widget> tabPage = [
    HomeScreen(),
    SearchScreen(),
    FavouriteScreen(),
  ];

  // var tabs = [
  //   BottomNavigationBarItem(
  //       activeIcon: SvgPicture.asset("assets/icons/home.svg", color:green),
  //       icon: SvgPicture.asset("assets/icons/homeoutline.svg", color:Get.theme.iconTheme.color),
  //       label: ''),
  //   BottomNavigationBarItem(
  //       activeIcon: SvgPicture.asset("assets/icons/search.svg", color: green),
  //       icon: SvgPicture.asset("assets/icons/searchoutline.svg", color: Get.theme.iconTheme.color),
  //       label: ''),
  //   BottomNavigationBarItem(
  //       activeIcon: SvgPicture.asset("assets/icons/like.svg", color: green, height: 25.h),
  //       icon: SvgPicture.asset("assets/icons/likeoutline.svg", color: Get.theme.iconTheme.color),
  //       label: ''),
  // ];

  @override
  void dispose() {
    searchController.search.value.clear();
    super.dispose();
  }
}
