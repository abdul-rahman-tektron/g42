import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';



extension FormatApiDateTime on String {
  /// Converts a datetime string like "7/11/2025 3:00:20 PM"
  /// to "11/07/2025 ,03:00 PM"
  ///
  String formatDate() {
    // Parse the original string
    final parsedDate = DateFormat("MM/dd/yyyy HH:mm:ss").parse(this);

    // Format to desired output
    return DateFormat("dd MMM yyyy").format(parsedDate);
  }
}

extension FileBase64Extension on File {
  /// Converts this File to a base64-encoded string
  Future<String> toBase64() async {
    try {
      if (!await exists()) return "";
      final bytes = await readAsBytes();
      if (bytes.isEmpty) return "";
      return base64Encode(bytes);
    } catch (e) {
      // In case of any read/encoding errors, return an empty string
      return "";
    }
  }
}

extension Base64ByteExtension on String? {
  /// Converts this File to a base64-encoded string
  Uint8List? decodeBase64OrNull() {
    if (this == null) return null;
    try {
      return Uint8List.fromList(base64Decode(this!));
    } catch (e) {
      // Optionally log or handle the decoding error
      return null;
    }
  }
}

extension Base64ToFileExtension on String {
  /// Converts a base64 string back to a File at the given [fileName]
  Future<File> toFile({required String fileName}) async {
    final bytes = base64Decode(this);
    final dir = await getApplicationDocumentsDirectory();
    final filePath = path.join(dir.path, fileName);
    final file = File(filePath);
    return await file.writeAsBytes(bytes);
  }
}
