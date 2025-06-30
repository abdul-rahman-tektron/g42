import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:provider/provider.dart';
import 'package:smartcards/core/model/employee/employee_response.dart';
import 'package:smartcards/res/app_colors.dart';
import 'package:smartcards/res/app_fonts.dart';

// Assuming you have Employee model and sample data
import 'package:smartcards/screens/employee_detail/employee_detail_screen.dart';
import 'package:smartcards/screens/search/search_notifier.dart';
import 'package:smartcards/utils/common/widgets/common_textfield.dart';
import 'package:smartcards/utils/common/widgets/employee_card.dart';
import 'package:smartcards/utils/common/widgets/loading_overlay.dart';

import '../../core/base/loading_state.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => SearchNotifier(context),
      child: Consumer<SearchNotifier>(
        builder: (context, searchNotifier, child) {
          return Scaffold(
            body: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  _buildSearchField(searchNotifier),
                  const SizedBox(height: 16),
                  Expanded(child: _buildEmployeeList(searchNotifier)),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildSearchField(SearchNotifier notifier) {
    return CustomTextField(
      controller: notifier.searchController,
      titleVisibility: false,
      hintText: "Search Employee",
      fieldName: "Search",
      skipValidation: true,
      onChanged: notifier.setSearchQuery,
    );
  }

  Widget _buildEmployeeList(SearchNotifier notifier) {
    if (notifier.loadingState == LoadingState.Busy) {
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

    final filtered = notifier.filteredEmployees;

    if (filtered.isEmpty && notifier.searchController.text.trim().isNotEmpty) {
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

    if (filtered.isEmpty) {
      // No employees loaded yet (initial case), show nothing or placeholder
      return const SizedBox();
    }

    return ListView.separated(
      itemCount: filtered.length,
      separatorBuilder: (_, __) => const Divider(height: 1),
      itemBuilder: (context, index) {
        final emp = filtered[index];
        return EmployeeCard(employee: emp);
      },
    );
  }
}