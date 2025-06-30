import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:provider/provider.dart';
import 'package:smartcards/core/base/loading_state.dart';
import 'package:smartcards/res/app_colors.dart';
import 'package:smartcards/res/app_fonts.dart';
import 'package:smartcards/screens/dashboard/dashboard_notifier.dart';
import 'package:smartcards/screens/search/search_screen.dart';
import 'package:smartcards/utils/common/widgets/common_buttons.dart';
import 'package:smartcards/utils/common/widgets/employee_card.dart';
import 'package:smartcards/utils/common/widgets/loading_overlay.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => DashboardNotifier(context),
      child: Consumer<DashboardNotifier>(
        builder: (context, dashboardNotifier, child) {
          return buildBody(context, dashboardNotifier);
        },
      ),
    );
  }

  Widget buildBody(BuildContext context, DashboardNotifier dashboardNotifier) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              10.verticalSpace,
              Text("Scanned Employee", style: AppFonts.textBold20),
              15.verticalSpace,
              scannedCard(context, dashboardNotifier),
              15.verticalSpace,
              Text("Scanned List", style: AppFonts.textBold20),
              15.verticalSpace,
              _buildEmployeeList(dashboardNotifier),
            ],
          ),
        ),
      ),
    );
  }

  Widget scannedCard(BuildContext context, DashboardNotifier dashboardNotifier) {
    return GridView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 10.h,
        crossAxisSpacing: 10.w,
        childAspectRatio: 1.6.w,
      ),
      itemCount: dashboardNotifier.cardData?.length ?? 0,
      itemBuilder: (context, index) {
        return buildScanCard(context, dashboardNotifier.cardData![index]);
      },
    );
  }

  Widget buildScanCard(BuildContext context, DashboardCardData data) {
    return Container(
      decoration: BoxDecoration(color: AppColors.buttonBgColor, borderRadius: BorderRadius.circular(15)),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            top: 10,
            right: 10,
            child: Icon(data.icon, color: AppColors.errorColor.withOpacity(0.2), size: 25),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(data.count.toString(), style: AppFonts.textRegular20),
                5.verticalSpace,
                Text(
                  data.titleKey, // Translate here!
                  style: AppFonts.textSemiBold14,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmployeeList(DashboardNotifier dashboardNotifier) {
    if (dashboardNotifier.loadingState == LoadingState.Busy) {
      return Center(child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          DotCircleSpinner(size: 70, dotSize: 5, color: AppColors.primaryColor),
          5.verticalSpace,
          Text("Fetching Employee Data", style: AppFonts.textRegular16),
        ],
      ));
    }

    if (dashboardNotifier.allEmployees.isEmpty) {
      // Show "no employees found" only when searching
      return Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(LucideIcons.userX2, size: 50, color: AppColors.primaryColor),
            5.verticalSpace,
            Text("No employees found", style: AppFonts.textRegular16),
          ],
        ),
      );
    }

    return ListView.separated(
      itemCount: dashboardNotifier.allEmployees.length,
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      separatorBuilder: (_, __) => const Divider(height: 1),
      itemBuilder: (context, index) {
        final emp = dashboardNotifier.allEmployees[index];
        return EmployeeCard(employee: emp);
      },
    );
  }
}
