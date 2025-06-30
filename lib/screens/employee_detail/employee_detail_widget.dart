import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smartcards/core/model/employee/employee_response.dart';
import 'package:smartcards/res/app_fonts.dart';
import 'package:smartcards/utils/encrypt.dart';
import 'package:smartcards/utils/extensions.dart';


class EmployeeDetailsWidget extends StatelessWidget with CommonFunctions{
  final EmployeeResult employee;

  const EmployeeDetailsWidget({
    super.key,
    required this.employee,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.only(top: 5.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.grey),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image(image: employee.photo != null ? MemoryImage(base64Decode(employee.photo!)) : const AssetImage(
                      'assets/images/avatar.png'), height: 100.h,),
                ),
              ),
              10.horizontalSpace,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(employee.fullName ?? "", style: AppFonts.textSemiBold18,),
                    5.verticalSpace,
                    _buildInfoRow("G42 ID:", employee.sG42EmpId ?? ""),

                  ],
                ),
              ),
            ],
          ),
          20.verticalSpace,
          _buildInfoRow("Department:", employee.sBusinessUnitEn ?? ""),
          _buildInfoRow("EID No:", employee.eidNumber ?? ""),
          _buildInfoRow("Passport:", employee.passportNumber ?? ""),
          _buildInfoRow("Hire Date:", employee.hireDate?.formatDate() ?? ""),
          _buildInfoRow("Contract Expiry:", employee.contractExpiryDate?.formatDate() ?? ""),
          20.verticalSpace,
          _buildInfoRow("Mobile:", employee.mobileNo ?? ""),
          _buildInfoRow("Email:", employee.email ?? ""),
          _buildInfoRow("Location:", employee.sLocationNameEn ?? ""),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: 120.w,
            child: Text(
              label,
              style: AppFonts.textSemiBold14,
            ),
          ),
          10.horizontalSpace,
          Expanded(
            child: Text(
              value.toString() ?? '',
              style: AppFonts.textRegular14,
            ),
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
    return "${date.day.toString().padLeft(2, '0')}-${date.month.toString().padLeft(2, '0')}-${date.year}";
  }
}

class SectionTitle extends StatelessWidget {
  final String title;
  const SectionTitle(this.title, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        title,
        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
    );
  }
}
