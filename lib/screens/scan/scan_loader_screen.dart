import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smartcards/res/app_colors.dart';
import 'package:smartcards/res/app_fonts.dart';
import 'package:smartcards/utils/common/widgets/loading_overlay.dart';

class ScanLoader extends StatelessWidget {
  const ScanLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const DotCircleSpinner(size: 70, dotSize: 5, color: AppColors.primaryColor),
          20.verticalSpace,
          const Text("Fetching employee details...", style: AppFonts.textRegular18),
        ],
      ),
    );
  }
}
