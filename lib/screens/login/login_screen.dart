import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:smartcards/core/base/loading_state.dart';
import 'package:smartcards/res/app_colors.dart';
import 'package:smartcards/res/app_fonts.dart';
import 'package:smartcards/screens/login/login_notifier.dart';
import 'package:smartcards/utils/common/widgets/common_buttons.dart';
import 'package:smartcards/utils/common/widgets/common_textfield.dart';
import 'package:smartcards/utils/curved_clipper.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => LoginNotifier(),
      child: Consumer<LoginNotifier>(
        builder: (context, loginNotifier, child) {
          return buildBody(context, loginNotifier);
        },
      ),
    );
  }

  Widget buildBody(BuildContext context, LoginNotifier loginNotifier) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Center(
            child: Form(
              key: loginNotifier.formKey,
              child: Column(
                children: [
                  DoubleWaveHeader(
                    height: screenHeight * 0.35,
                    frontWaveColor: AppColors.primaryColor,
                    backWaveColor: AppColors.buttonBgColor,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.add_chart_rounded, size: 80, color: Colors.white,),
                        10.verticalSpace,
                        Text(
                          'G42',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          // mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Welcome Back", style: AppFonts.textBold24, textAlign: TextAlign.center,),
                            20.verticalSpace,
                            CustomTextField(controller: loginNotifier.emailController, fieldName: "Email"),
                            15.verticalSpace,
                            CustomTextField(controller: loginNotifier.passwordController, fieldName: "Password"),
                            40.verticalSpace,
                            CustomButton(text: "Login",
                              isLoading: loginNotifier.loadingState == LoadingState.Busy,
                              onPressed: () => loginNotifier.loginFunctionality(context),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ],
              ),
            )
              ),
        ),
      )
    );
  }
}
