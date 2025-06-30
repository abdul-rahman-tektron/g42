import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:smartcards/res/app_colors.dart';
import 'package:smartcards/res/app_fonts.dart';
import 'package:smartcards/res/app_images.dart';

class CommonAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  const CommonAppBar({super.key, this.title});

  @override
  Widget build(BuildContext context) {


    return AppBar(
      backgroundColor: AppColors.appBarBackgroundColor,
      scrolledUnderElevation: 0.0,
      leading: Builder(
        builder: (context) => Padding(
          padding: const EdgeInsets.only(left: 15.0),
          child: InkWell(
              onTap: () => Scaffold.of(context).openDrawer(),
              child: Icon(LucideIcons.menu, color: Colors.white, size: 25.r,)),
        ),
      ),
      title: title != null ? Text(title!, style: AppFonts.textMedium18White,) : null,
      centerTitle: true,
      // title: Image.asset(AppImages.logo, height: 50,),
      actionsPadding: const EdgeInsets.symmetric(horizontal: 24.0),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(65.0);
}
