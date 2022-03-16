import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:majascan/majascan.dart';

import 'package:permission_handler/permission_handler.dart';
import 'package:qrapps/pages/redirect_page.dart';
import 'package:qrscan/qrscan.dart' as qrscan;

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Demo'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextButton(
              onPressed: () async {
                await Permission.camera.request();
                String? barcode = await qrscan.scan();
                if (barcode != null) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => RedirectPage(barcode: barcode),
                    ),
                  );
                }
              },
              child: const Text('qrscan'),
            ),
            TextButton(
              child: const Text('majascan'),
              onPressed: () async {
                try {
                  await Permission.camera.request();
                  String? qrResult = await MajaScan.startScan(
                      title: "QRcode scanner",
                      titleColor: Colors.amberAccent[700],
                      qRCornerColor: Colors.orange,
                      qRScannerColor: Colors.orange);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => RedirectPage(barcode: qrResult),
                    ),
                  );
                } catch (e) {
                  // ignore: avoid_print
                  print(e);
                }
              },
            ),
            TextButton(
                child: const Text('flutter_barcode_scanner'),
                onPressed: () async {
                  try {
                    await Permission.camera.request();
                    String? barcodeScanRes =
                        await FlutterBarcodeScanner.scanBarcode(
                            '#ff6666', 'Cancel', true, ScanMode.QR);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => RedirectPage(barcode: barcodeScanRes),
                      ),
                    );
                  } catch (e) {
                    // ignore: avoid_print
                    print(e);
                  }
                })
          ],
        ),
      ),
    );
  }
}
