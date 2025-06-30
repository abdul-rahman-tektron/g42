import 'package:flutter/material.dart';
import 'package:smartcards/res/app_colors.dart';

class FieldBorderStyles {
  static OutlineInputBorder fieldBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(10),
    borderSide: const BorderSide(color: AppColors.surfaceColor),
  );

  static OutlineInputBorder enabledFieldBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(10),
    borderSide: const BorderSide(color: AppColors.surfaceColor),
  );

  static OutlineInputBorder focusedFieldBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(10),
    borderSide: const BorderSide(color: AppColors.surfaceColor),
  );
}
