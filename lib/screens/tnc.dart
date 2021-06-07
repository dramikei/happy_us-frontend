import 'package:flutter/material.dart';
import 'package:happy_us/utils/constants.dart';
import 'package:native_pdf_view/native_pdf_view.dart';

class Tnc extends StatelessWidget {
  static const id = 'Tnc';

  const Tnc({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        backgroundColor: kFocusColor,
        title: const Text('Terms and conditions'),
      ),
      body: PdfView(
        physics: const BouncingScrollPhysics(),
        documentLoader: Center(
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
          ),
        ),
        pageLoader: Center(
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
          ),
        ),
        controller: PdfController(
          document: PdfDocument.openAsset('assets/docs/tnc.pdf'),
        ),
      ),
    );
  }
}
