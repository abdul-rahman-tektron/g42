import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smartcards/res/app_colors.dart';
import 'package:smartcards/screens/bottom_bar/bottom_bar_notifier.dart';
import 'package:smartcards/utils/common/widgets/common_app_bar.dart';
import 'package:smartcards/utils/common/widgets/common_bottom_bar.dart';
import 'package:smartcards/utils/common/widgets/common_drawer.dart';


class BottomBarScreen extends StatelessWidget {
  final int? currentIndex;
  const BottomBarScreen({super.key, this.currentIndex = 0});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => BottomBarNotifier(currentIndex),
      child: Consumer<BottomBarNotifier>(
        builder: (context, bottomBarNotifier, child) {
          return buildBody(context, bottomBarNotifier);
        },
      ),
    );
  }

  Widget buildBody(BuildContext context, BottomBarNotifier bottomBarNotifier) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        bottomBarNotifier.changeTab(0);
      },
      child: Scaffold(
        backgroundColor: AppColors.scaffoldBackgroundColor,
        appBar: CommonAppBar(
            title: _getTitle(bottomBarNotifier.currentIndex)),
        drawer: CommonDrawer(),
        body: bottomBarNotifier.currentScreen,
        bottomNavigationBar: CustomBottomNavBar(
          currentIndex: bottomBarNotifier.currentIndex,
          onTap: bottomBarNotifier.changeTab,
        ),
      ),
    );
  }

  String? _getTitle(int index) {
    switch (index) {
      case 0:
        return "Dashboard";
      case 1:
        return "Scan";
      case 2:
        return "Search";
      default:
        return null;
    }
  }
}
