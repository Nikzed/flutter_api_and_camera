import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:test_task/constants/constants.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class ScanScreen extends StatefulWidget {
  const ScanScreen({Key? key}) : super(key: key);

  @override
  _ScanScreenState createState() => _ScanScreenState();
}

class _ScanScreenState extends State<ScanScreen> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Barcode? result;
  QRViewController? controller;

  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    } else if (Platform.isIOS) {
      controller!.resumeCamera();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/background.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 75, left: 20, right: 20),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Container(
                height: 600,
                color: Colors.white.withOpacity(0.7),
                child: Column(
                  children: [
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 30, vertical: 40),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: 210,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                RichText(
                                  text: const TextSpan(
                                    text: 'Відскануй\n',
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 24),
                                    children: <TextSpan>[
                                      TextSpan(
                                        text: 'QR код\n',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      TextSpan(text: 'на вільному боксі'),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 10),
                                const Text(
                                  'для активації мийки самообслуговування',
                                  style: TextStyle(
                                    color: Color(0xff33C5F4),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SvgPicture.asset('assets/hand_with_qr.svg'),
                        ],
                      ),
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: SizedBox(
                        height: 300,
                        width: 300,
                        child: QRView(
                          key: qrKey,
                          onQRViewCreated: _onQRViewCreated,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    result != null
                        ? Text(
                            'Barcode Type: ${describeEnum(result!.format)}'
                                '   Data: ${result!.code}')
                        : const Text('Відскануйте штрих-код'),
                  ],
                ),
              ),
            ),
          ),
          // Column(
          //   children: [
          //     SizedBox(
          //       height: 500,
          //       width: double.infinity,
          //       child: QRView(
          //         key: qrKey,
          //         onQRViewCreated: _onQRViewCreated,
          //       ),
          //     ),
          //     Expanded(
          //       flex: 1,
          //       child: Center(
          //         child: (result != null)
          //             ? Text(
          //                 'Barcode Type: ${describeEnum(result!.format)}   Data: ${result!.code}')
          //             : const Text('Scan a code'),
          //       ),
          //     ),
          //   ],
          // ),
        ],
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData;
      });
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
