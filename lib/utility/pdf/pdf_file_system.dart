import 'dart:io';

import 'package:flutter/services.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';

class PdfFileSysten {
  final String fileName;
  final Document pdf;

  PdfFileSysten({required this.fileName, required this.pdf});

  Future<File> saveBidFileInLocalDevice() async {
    final bytes = await pdf.save();

    // save in local divice
    final dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/$fileName');

    await file.writeAsBytes(bytes);

    openFile(file);
    return file;
  }

  static Future openFile(File file) async {
    final url = file.path;
    await OpenFile.open(url);
  }
}
