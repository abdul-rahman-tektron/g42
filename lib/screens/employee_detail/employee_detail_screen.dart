import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smartcards/core/model/employee/employee_response.dart';
import 'package:smartcards/res/app_colors.dart';
import 'package:smartcards/screens/employee_detail/employee_detail_widget.dart';
class EmployeeDetailsScreen extends StatelessWidget {
  final EmployeeResult employee;

  const EmployeeDetailsScreen({Key? key, required this.employee}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.white, //change your color here
        ),
        title: Text(employee.fullName ?? ""),
      ),
      body: Stack(
        children: [
          Positioned(
            top: -30,
            left: -50,
            child: Container(
              width: 250.w,
              height: 250.w,
              decoration: BoxDecoration(
                color: AppColors.primaryColor.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
            ),
          ),
          Positioned(
            top: -70,
            right: 80,
            child: Container(
              width: 150.w,
              height: 150.w,
              decoration: BoxDecoration(
                color: AppColors.primaryColor.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(15.r)                ,
            child: EmployeeDetailsWidget(
              employee: employee,
            ),
          ),
        ],
      ),
    );
  }
}
