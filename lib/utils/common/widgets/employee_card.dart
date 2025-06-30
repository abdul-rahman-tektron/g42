import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:smartcards/core/model/employee/employee_response.dart';
import 'package:smartcards/res/app_fonts.dart';
import 'package:smartcards/screens/employee_detail/employee_detail_screen.dart';

class EmployeeCard extends StatelessWidget {
  final EmployeeResult employee;

  const EmployeeCard({required this.employee});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Image.memory(base64Decode(employee.photo ?? ""), fit: BoxFit.fill),
      ),
      title: Text(employee.fullName ?? "", style: AppFonts.textMedium16, maxLines: 2, overflow: TextOverflow.ellipsis,),
      subtitle: Text(employee.sBusinessUnitEn ?? "", style: AppFonts.textRegular12),
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (_) => EmployeeDetailsScreen(employee: employee)));
      },
    );
  }
}
