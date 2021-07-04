import 'package:flutter/material.dart';
import 'package:happy_us/widgets/custom_text.dart';
import 'package:happy_us/utils/constants.dart';
import 'package:native_pdf_view/native_pdf_view.dart';

class Tnc extends StatefulWidget {
  static const id = 'Tnc';

  const Tnc({
    Key? key,
  }) : super(key: key);

  @override
  _TncState createState() => _TncState();
}

class _TncState extends State<Tnc> {
  late final PdfController _pdfController;

  @override
  void initState() {
    _pdfController = PdfController(
      document: PdfDocument.openAsset('assets/docs/tnc.pdf'),
      viewportFraction: 1.2
    );
    super.initState();
  }

  @override
  void dispose() {
    _pdfController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        backgroundColor: kFocusColor,
        title: const CustomText('Terms & Conditions'),
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
        controller: _pdfController
      ),
      bottomNavigationBar: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            onPressed: () {
              _pdfController.previousPage(
                  duration: Duration(milliseconds: 250), curve: Curves.easeOut);
            },
            icon: Icon(Icons.chevron_left),
          ),
          IconButton(
            onPressed: () {
              _pdfController.nextPage(
                  duration: Duration(milliseconds: 250), curve: Curves.easeIn);
            },
            icon: Icon(Icons.chevron_right),
          )
        ],
      ),
    );
  }
}
