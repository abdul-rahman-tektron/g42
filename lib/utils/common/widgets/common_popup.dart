import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:smartcards/res/app_colors.dart';
import 'package:smartcards/res/app_fonts.dart';
import 'package:smartcards/res/app_images.dart';
import 'package:smartcards/res/app_language_text.dart';
import 'package:smartcards/utils/app_routes.dart';
import 'package:smartcards/utils/common/widgets/common_buttons.dart';
import 'package:smartcards/utils/regex.dart';
import 'package:smartcards/utils/secure_storage.dart';
import 'package:smartcards/utils/toast_helper.dart';

registerSuccessPopup(BuildContext context, String heading, String subHeading) {
  return showDialog(
    context: context,
    barrierColor: AppColors.primaryColor.withOpacity(0.4),
    barrierDismissible: false,
    builder: (context) {
      return Dialog(
        backgroundColor: AppColors.surfaceColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        insetPadding: EdgeInsets.symmetric(horizontal: 15),
        child: Container(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Align(
                alignment: Alignment.centerRight,
                child: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);

                    // Then navigate to the login screen
                    Future.delayed(Duration.zero, () {
                      Navigator.pushReplacementNamed(context, AppRoutes.login);
                    });
                  },
                  child: const Icon(Icons.close),
                ),
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.check_box, color: Colors.green, size: 30),
                  SizedBox(width: 10),
                  Text(heading, style: AppFonts.textBold24),
                ],
              ),
              const SizedBox(height: 15),
              Text(
                subHeading,
                style: AppFonts.textMedium18,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 15),
            ],
          ),
        ),
      );
    },
  );
}

commonPopup(BuildContext context,IconData icon, String heading, String subHeading) {
  return showDialog(
    context: context,
    barrierColor: AppColors.primaryColor.withOpacity(0.4),
    barrierDismissible: false,
    builder: (context) {
      return Dialog(
        backgroundColor: AppColors.surfaceColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        insetPadding: EdgeInsets.symmetric(horizontal: 15),
        child: Container(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Align(
                alignment: Alignment.centerRight,
                child: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const Icon(Icons.close),
                ),
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(icon, color: Colors.green, size: 30),
                  SizedBox(width: 15),
                  Expanded(child: Text(heading, style: AppFonts.textBold20)),
                ],
              ),
              const SizedBox(height: 15),
              Text(
                subHeading,
                style: AppFonts.textMedium18,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 15),
            ],
          ),
        ),
      );
    },
  );
}

void showNoInternetPopup(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: false,
    barrierColor: AppColors.primaryColor.withOpacity(0.4),
    builder:
        (popupContext) => Dialog(
          backgroundColor: AppColors.surfaceColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          insetPadding: const EdgeInsets.symmetric(horizontal: 20),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Align(
                  alignment: Alignment.centerRight,
                  child: GestureDetector(
                    onTap: () async {
                      Navigator.pop(popupContext);

                      // Check connectivity again after closing
                      final connectivityResult =
                          await Connectivity().checkConnectivity();
                      if (connectivityResult.contains(
                        ConnectivityResult.none,
                      )) {
                        // Still offline — optionally show a snackbar
                        showNoInternetPopup(context);
                      }
                    },
                    child: Icon(LucideIcons.x),
                  ),
                ),
                const SizedBox(height: 10),
                Icon(
                  LucideIcons.wifiOff,
                  size: 40,
                  color: AppColors.errorColor,
                ),
                const SizedBox(height: 15),
                Text(
                  'No Internet Connection',
                  style: AppFonts.textBold24,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 10),
                Text(
                  'Your internet connection appears to be offline.\nPlease check your connectivity.',
                  style: AppFonts.textMedium18,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 15),
              ],
            ),
          ),
        ),
  );
}