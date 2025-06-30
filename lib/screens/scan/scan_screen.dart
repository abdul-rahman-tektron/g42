import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smartcards/core/base/loading_state.dart';
import 'package:smartcards/screens/scan/scan_employee_detail.dart';
import 'package:smartcards/screens/scan/scan_loader_screen.dart';
import 'package:smartcards/screens/scan/scan_prompt_screen.dart';
import 'package:visibility_detector/visibility_detector.dart';
import 'package:flutter_barcode_listener/flutter_barcode_listener.dart';
import 'scan_notifier.dart';

class ScanScreen extends StatefulWidget {
  const ScanScreen({super.key});

  @override
  State<ScanScreen> createState() => _ScanScreenState();
}

class _ScanScreenState extends State<ScanScreen> {
  bool _visible = true;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ScanNotifier(),
      child: Consumer<ScanNotifier>(
        builder: (context, scanNotifier, child) {
          return Scaffold(
            backgroundColor: Colors.grey.shade100,
            body: VisibilityDetector(
              key: const Key("scan-screen-detector"),
              onVisibilityChanged: (info) {
                _visible = info.visibleFraction > 0;
              },
              child: BarcodeKeyboardListener(
                useKeyDownEvent: Platform.isWindows,
                bufferDuration: const Duration(milliseconds: 200),
                onBarcodeScanned: (barcode) {
                  if (_visible) {
                    scanNotifier.runWithLoadingVoid(
                          () => scanNotifier.processScan(context, barcode),
                    );
                  }
                },
                child: _buildBody(scanNotifier),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildBody(ScanNotifier scanNotifier) {
    if (scanNotifier.loadingState == LoadingState.Busy) {
      return const ScanLoader();
    }
    if (scanNotifier.matchedEmployee == null) {
      return const ScanPrompt();
    }
    return ScanEmployeeDetails(scanNotifier: scanNotifier);
  }
}
