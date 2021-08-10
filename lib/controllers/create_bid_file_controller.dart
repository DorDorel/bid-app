import 'dart:io';

import 'package:bid/models/bid.dart';
import 'package:bid/utility/pdf/pdf_file_system.dart';
import 'package:flutter/services.dart';

import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class CreateBidFile {
  final Bid bid;
  CreateBidFile({required this.bid});

  Future<File> generatePdf() async {
    final theme = pw.ThemeData.withFont(
      base:
          pw.Font.ttf(await rootBundle.load('assets/fonts/ArialUnicodeMS.ttf')),
      bold:
          pw.Font.ttf(await rootBundle.load('assets/fonts/ArialUnicodeMS.ttf')),
      italic:
          pw.Font.ttf(await rootBundle.load('assets/fonts/ArialUnicodeMS.ttf')),
      boldItalic:
          pw.Font.ttf(await rootBundle.load('assets/fonts/ArialUnicodeMS.ttf')),
    );

    final pdf = pw.Document();

    pdf.addPage(pw.MultiPage(
      pageFormat: PdfPageFormat.a4,
      theme: theme,
      textDirection: pw.TextDirection.rtl,
      build: (context) => [
        pw.Center(
            child:
                pw.Text(bid.clientName, textDirection: pw.TextDirection.rtl)),
        pw.Center(
            child: pw.Text(
                bid.selectedProducts.first.finalPricePerUnit.toString(),
                textDirection: pw.TextDirection.rtl)),
      ],
    ));
    return PdfFileSysten(fileName: 'test_file.pdf', pdf: pdf)
        .saveBidFileInLocalDevice();
  }


  
}
