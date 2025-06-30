import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'package:smartcards/core/notifier/common_notifier.dart';
import 'package:smartcards/main.dart';
import 'package:smartcards/utils/app_routes.dart';
import 'package:smartcards/utils/common/widgets/common_popup.dart';
import 'package:smartcards/utils/secure_storage.dart';
import 'app_url.dart';
import 'method.dart';

class NetworkProvider {
  static final NetworkProvider _instance = NetworkProvider._internal();
  factory NetworkProvider() => _instance;
  NetworkProvider._internal();

  final Logger logger = Logger(
    printer: PrettyPrinter(
      methodCount: 0,
      errorMethodCount: 5,
      colors: true,
      printEmojis: true,
      printTime: true,
    ),
  );

  final Duration timeout = const Duration(minutes: 2);

  static final BaseOptions _baseOptions = BaseOptions(
    baseUrl: AppUrl.baseUrl, // Always use default base URL
    responseType: ResponseType.json,
    connectTimeout: const Duration(seconds: 60),
    receiveTimeout: const Duration(seconds: 60),
    sendTimeout: const Duration(seconds: 60),
  );

  static final Dio _dio = Dio(_baseOptions)
    ..interceptors.add(_buildInterceptor());

  static InterceptorsWrapper _buildInterceptor() {
    return InterceptorsWrapper(
      onRequest: (options, handler) {
        // options.headers.addAll({
        //   // 'Content-Type': 'application/json',
        //   'Accept': 'application/json',
        // });
        handler.next(options);
      },
      onResponse: (response, handler) {
        handler.next(response);
      },
      onError: (DioError e, handler) async {
        // Report to Crashlytics with context

        if (e.message!.contains("XMLHttpRequest error")) {
          MyApp.navigatorKey.currentState?.pushNamed(AppRoutes.networkError);
        }
        handler.next(e);
      },
    );
  }

  Future<Response?> call({
    required String pathUrl,
    Method method = Method.GET,
    dynamic body,
    String? queryParam,
    Map<String, dynamic>? headers,
    urlEncoded = false,
    ResponseType? responseType,
  }) async {
    final url = _buildUrl(pathUrl, queryParam);
    final options;
    if(urlEncoded) {
      options = Options(headers: {
        'Content-Type': Headers.formUrlEncodedContentType,
      }, responseType: responseType);
    } else {
      options = Options(headers: headers, responseType: responseType);
    }


    //Check internet before making request
    final connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult.contains(ConnectivityResult.none)) {
      // Show internet popup and skip request
      showNoInternetPopup(MyApp.navigatorKey.currentContext!);
      logger.w("📡 No internet connection. Request to $url was not sent.");
      return null;
    }

    try {
      logger.i("📤 Request => ${method.name} $url");
      if (body != null) logger.d("📦 Body: $body");
      log("📦 Body: $body");

      Response response;

      switch (method) {
        case Method.GET:
          response = await _dio.get(url, options: options).timeout(timeout);
          break;
        case Method.POST:
          response = await _dio.post(url, data: body, options: options).timeout(timeout);
          break;
        case Method.PUT:
          response = await _dio.put(url, data: body, options: options).timeout(timeout);
          break;
        case Method.DELETE:
          response = await _dio.delete(url, data: body, options: options).timeout(timeout);
          break;
      }

      logger.i("✅ Response [${response.statusCode}] from $url");
      logger.d("📨 Data: ${jsonEncode(response.data)}");
      log("📨 Data: ${jsonEncode(response.data)}");

      return response;
    } on DioError catch (e, stack) {
      logger.e("❌ DioError [${e.response?.statusCode}] from ${e.requestOptions.path}");
      logger.e("🧾 Error Response: ${e.response?.data}");
      return await _handleError(e);
    } catch (e, stack) {
      logger.e("🚨 Unexpected error during request to $url: $e");
      return null;
    }
  }

  String _buildUrl(String pathUrl, String? queryParam) {
    return Uri.encodeFull('$pathUrl${queryParam ?? ''}');
  }

  Future<Response?> _handleError(DioError error) async {
    final status = error.response?.statusCode ?? 0;
    final url = error.requestOptions.path;

    switch (status) {
      case HttpStatus.unauthorized:
        if (![
          AppUrl.pathLogin,
        ].any(url.contains)) {
          // await SharedPreferencesMobileWeb.instance.removeParticularKey(apiToken);
          try {
            await SecureStorageHelper.clearExceptRememberMe();
          } catch (e, stack) {
            print("SecureStorage deletion error (unauthorized): $e");
            // Optional: notify the user or silently continue
          }
          MyApp.navigatorKey.currentState?.pushNamedAndRemoveUntil(AppRoutes.login, (_) => false);
        }
        break;

      case HttpStatus.forbidden:
        MyApp.navigatorKey.currentState?.pushNamedAndRemoveUntil(AppRoutes.notFound, (_) => false);
        break;

      default:
        break;
    }

    return error.response;
  }
}
