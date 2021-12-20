import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class ScanScreen extends StatefulWidget {
  const ScanScreen({Key? key}) : super(key: key);

  @override
  _ScanScreenState createState() => _ScanScreenState();
}

class _ScanScreenState extends State<ScanScreen> {
  final GlobalKey _qrKey = GlobalKey(debugLabel: 'QR');
  Barcode? _result;
  QRViewController? _controller;

  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      _controller!.pauseCamera();
    } else if (Platform.isIOS) {
      _controller!.resumeCamera();
    }
    _controller!.resumeCamera();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30, vertical: 40),
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
                          key: _qrKey,
                          onQRViewCreated: _onQRViewCreated,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    _result != null
                        ? Text(
                            'Ви відсканували штрих-код!\n${_result!.code}',
                            textAlign: TextAlign.center,
                          )
                        : const Text('Відскануйте штрих-код'),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    _controller = controller;
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        _result = scanData;
      });
    });
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }
}
