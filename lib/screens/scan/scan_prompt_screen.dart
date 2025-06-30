import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smartcards/res/app_colors.dart';
import 'package:smartcards/res/app_fonts.dart';

class ScanPrompt extends StatelessWidget {
  const ScanPrompt({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.qr_code_scanner_rounded, size: 80, color: AppColors.primaryColor),
        20.verticalSpace,
        Text("Ready to scan QR code", style: AppFonts.textSemiBold22),
        10.verticalSpace,
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 32.0),
          child: Text(
            "Please scan the employee QR code to retrieve details automatically.",
            textAlign: TextAlign.center,
            style: AppFonts.textRegular16,
          ),
        ),
      ],
    );
  }
}
