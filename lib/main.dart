import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:smartcards/res/app_colors.dart';
import 'package:smartcards/res/app_theme.dart';
import 'package:smartcards/screens/bottom_bar/bottom_bar_screen.dart';
import 'package:smartcards/screens/login/login_screen.dart';
import 'package:smartcards/utils/app_routes.dart';
import 'package:smartcards/utils/secure_storage.dart';
import 'package:toastification/toastification.dart';

import 'core/notifier/common_notifier.dart';

void main() async {

    // Initialize Flutter bindings **inside the zone**
    WidgetsFlutterBinding.ensureInitialized();

    // Lock orientation
    await SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: AppColors.primaryColor, //or set color with: Color(0xFF0000FF)
    ));

    // Initialize secure storage
    await SecureStorageHelper.init();

    final token = await SecureStorageHelper.getToken();

    // Run the app
    runApp(MyApp(token: token));
}

class MyApp extends StatelessWidget {
  final String? token;
  const MyApp({super.key, required this.token});

  // This widget is the root of your application.
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<CommonNotifier>(
          create: (_) => CommonNotifier(),
        ),
      ],
      child: Builder(
          builder: (context) {
            return ScreenUtilInit(
              designSize: const Size(375, 812),
              minTextAdapt: true,               // adapt text for smaller screens
              splitScreenMode: true,
              child: ToastificationWrapper(
                child: MaterialApp(
                  debugShowCheckedModeBanner: false,
                  navigatorKey: navigatorKey,
                  onGenerateRoute: AppRouter.onGenerateRoute,
                  // initialRoute: snapshot.data == true ? AppRoutes.home : AppRoutes.login,
                  home: token != null ?  BottomBarScreen() : const LoginScreen(),
                  theme: AppTheme.getTheme(
                     'DroidKufi',
                  ),
                  title: 'Smart Cards',
                ),
              ),
            );
          }
      ),
    );
  }
}

class HandheldScannerPage extends StatefulWidget {
  const HandheldScannerPage({super.key});

  @override
  State<HandheldScannerPage> createState() => _HandheldScannerPageState();
}

class _HandheldScannerPageState extends State<HandheldScannerPage> {
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    // Automatically focus the field on start
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _focusNode.requestFocus();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text("Scan Barcode with Handheld Device")),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              TextField(
                controller: _controller,
                focusNode: _focusNode,
                decoration: const InputDecoration(
                  labelText: "Scanned Barcode",
                  border: OutlineInputBorder(),
                ),
                onSubmitted: (value) {
                  // Handle scanned value (e.g., search in DB)
                  debugPrint("Scanned: $value");
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  _controller.clear();
                  _focusNode.requestFocus(); // Re-focus after clearing
                },
                child: const Text("Clear & Focus"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
