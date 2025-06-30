import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lucide_icons/lucide_icons.dart';

import 'package:provider/provider.dart';
import 'package:smartcards/res/app_colors.dart';
import 'package:smartcards/res/app_fonts.dart';

import 'package:smartcards/utils/app_routes.dart';
import 'package:smartcards/utils/secure_storage.dart';

class CommonDrawer extends StatelessWidget {
  final Function(int)? onItemSelected;

  const CommonDrawer({Key? key, this.onItemSelected}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: 250,
      backgroundColor: AppColors.surfaceColor,
      child: Column(
        children: [
          DrawerHeader(
            decoration: BoxDecoration(color: AppColors.appBarBackgroundColor),
            child: SizedBox(
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Image.asset(AppImages.logo, height: 80,),
                  15 .verticalSpace,
                  Text(
                    "Hello",
                    style: AppFonts.textMedium18White,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                _buildDrawerItem(context, LucideIcons.layoutDashboard, "Dashboard", 0),
                _buildDrawerItem(context, LucideIcons.scanLine, "Scan", 1),
                _buildDrawerItem(context, LucideIcons.search, "Search", 2),
              ],
            ),
          ),
          _buildDrawerItem(context, LucideIcons.logOut, "Logout", 3),
          15.verticalSpace,
        ],
      ),
    );
  }

  Widget _buildDrawerItem(BuildContext context, IconData icon, String title, int value) {
    return ListTile(
      leading: Icon(icon, size: 25,),
      title: Text(title, style: AppFonts.textMedium16,),
      onTap: () {
        Navigator.pop(context); // Close the drawer
        switch (value) {
          case 0:
            Navigator.pushNamedAndRemoveUntil(context, AppRoutes.bottomBar, arguments: 0, (Route<dynamic> route) => false);
            break;
          case 1:
            Navigator.pushNamedAndRemoveUntil(context, AppRoutes.bottomBar, arguments: 1, (Route<dynamic> route) => false);
            break;
          case 2:
            Navigator.pushNamedAndRemoveUntil(context, AppRoutes.bottomBar, arguments: 2, (Route<dynamic> route) => false);
            break;
          case 3:
            logoutFunctionality(context);
            break;
        }
      },
    );
  }

  void logoutFunctionality(BuildContext context) async {
    try {
      await SecureStorageHelper.clearExceptRememberMe();
    } catch (e, stack) {
      print("Logout: error during clearing secure storage: $e");
    }

    Navigator.pushNamedAndRemoveUntil(
      context,
      AppRoutes.login,
          (Route<dynamic> route) => false,
    );
  }

}
