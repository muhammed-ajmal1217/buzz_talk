import 'dart:developer';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:easy_pdf_viewer/easy_pdf_viewer.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:permission_handler/permission_handler.dart';

class PDFWithDownload extends StatefulWidget {
  final String pdfUrl;

  PDFWithDownload({required this.pdfUrl});

  @override
  _PDFWithDownloadState createState() => _PDFWithDownloadState();
}

class _PDFWithDownloadState extends State<PDFWithDownload> {
  PDFDocument? _pdfDocument;
  bool _isLoading = true;
  String? fileName;
  @override
  void initState() {
    super.initState();
    fileName = Uri.decodeComponent(widget.pdfUrl.split('/').last);
    fileName = fileName?.split('?').first;
    fileName = fileName?.split('/').last;
    log(fileName??'');
    _loadPDF();
  }

  Future<void> _loadPDF() async {
    _pdfDocument = await PDFDocument.fromURL(widget.pdfUrl);
    setState(() {
      _isLoading = false;
    });
  }

  Future<void> _downloadPDF() async {
    var status = await Permission.storage.request();

    if (!status.isGranted) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Storage permission denied'),
      ));
      return;
    }

    try {
      final dio = Dio();
      final dir = Directory('/storage/emulated/0/Download');
      if (!await dir.exists()) {
        await dir.create(recursive: true);
      }
      String fileName = Uri.decodeComponent(widget.pdfUrl.split('/').last);
      fileName = fileName.split('?').first;
      fileName = fileName.split('/').last;
      log('$fileName');
      final filePath = '${dir.path}/$fileName';
      await dio.download(widget.pdfUrl, filePath);
      print('Download successful: $filePath');

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('PDF downloaded to $filePath'),
      ));
    } catch (e) {
      print('Download failed: $e'); 
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Failed to download PDF: $e'),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    String fileName = Uri.decodeComponent(widget.pdfUrl.split('/').last);
    fileName = fileName.split('?').first;
    fileName = fileName.split('/').last;
    log(fileName);
    return Scaffold(
      appBar: AppBar(
        title: Text(fileName,style: GoogleFonts.alata(fontSize: 15,fontWeight: FontWeight.bold),),
        actions: [
          IconButton(
            icon: Icon(Icons.download),
            onPressed: _downloadPDF,
          ),
        ],
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : PDFViewer(
              document: _pdfDocument!,
            ),
    );
  }
}
