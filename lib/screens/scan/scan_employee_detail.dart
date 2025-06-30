import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smartcards/res/app_colors.dart';
import 'package:smartcards/screens/employee_detail/employee_detail_widget.dart';
import 'package:smartcards/screens/scan/scan_notifier.dart';
import 'package:smartcards/utils/common/widgets/common_buttons.dart';

class ScanEmployeeDetails extends StatelessWidget {
  final ScanNotifier scanNotifier;

  const ScanEmployeeDetails({super.key, required this.scanNotifier});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.w),
          padding: EdgeInsets.all(0), // padding handled inside stack
          decoration: BoxDecoration(
            color: AppColors.surfaceColor,
            border: Border.all(color: Colors.grey.shade100),
            borderRadius: BorderRadius.circular(10.r),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.shade400,
                offset: const Offset(0, 2),
                spreadRadius: 2,
                blurRadius: 10,
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10.r),
            child: Stack(
              children: [
                // Background circles inside the container
                Positioned(
                  top: -30,
                  left: -50,
                  child: Container(
                    width: 270.w,
                    height: 270.w,
                    decoration: BoxDecoration(
                      color: AppColors.primaryColor.withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
                Positioned(
                  top: -50,
                  right: 50,
                  child: Container(
                    width: 150.w,
                    height: 150.w,
                    decoration: BoxDecoration(
                      color: AppColors.primaryColor.withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
                Positioned(
                  bottom: -40,
                  right: -40,
                  child: Container(
                    width: 150.w,
                    height: 150.w,
                    decoration: BoxDecoration(
                      color: AppColors.primaryColor.withOpacity(0.07),
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
                // Actual content with padding
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.w),
                  child: Column(
                    children: [
                      EmployeeDetailsWidget(employee: scanNotifier.matchedEmployee!),
                      20.verticalSpace,
                      CustomButton(
                        text: "Scan again",
                        onPressed: () => scanNotifier.clear(),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
