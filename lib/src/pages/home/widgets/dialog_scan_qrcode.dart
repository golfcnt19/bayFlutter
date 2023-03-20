import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class DialogScanQRCode extends StatefulWidget {
  const DialogScanQRCode({Key? key}) : super(key: key);

  @override
  _DialogScanQRCodeState createState() => _DialogScanQRCodeState();
}

class _DialogScanQRCodeState extends State<DialogScanQRCode> {
  final GlobalKey _qrKey = GlobalKey(debugLabel: 'QR');
  String code = '';

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(code),
            SizedBox(height: 12),
            Stack(children: [
              _buildQRView(),
              // horizontal line
              Positioned(
                left: 0,
                right: 0,
                top: 300 / 2,
                child: Padding(
                  padding: const EdgeInsets.only(left: 50, right: 50),
                  child: Container(
                    height: 1,
                    color: Colors.green,
                  ),
                ),
              ),
              // vertical line
              Positioned(
                top: 0,
                bottom: 0,
                left: 140,
                child: Padding(
                  padding: const EdgeInsets.only(top: 50, bottom: 50),
                  child: Container(
                    width: 1,
                    color: Colors.green,
                  ),
                ),
              )
            ]),
            Container(
              margin: EdgeInsets.only(top: 12),
              width: double.infinity,
              child: TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text('close'),
              ),
            )
          ],
        ),
      ),
    );
  }

  SizedBox _buildQRView() => SizedBox(
        height: 300,
        child: QRView(
          key: _qrKey,
          onQRViewCreated: (QRViewController controller) {
            controller.scannedDataStream.listen((scanData) {
              controller.stopCamera();
              setState(() {
                code = scanData.code!;
              });
            });
          },
        ),
      );
}
