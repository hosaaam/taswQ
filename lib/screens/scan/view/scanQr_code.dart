import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:taswqly/components/custom_text.dart';
import 'package:taswqly/components/style/size.dart';
import 'package:taswqly/screens/product_details/view/product_details_view.dart';

class ScanQrCode extends StatefulWidget {
  const ScanQrCode({super.key});


  @override
  State<StatefulWidget> createState() => _ScanQrCodeState();
}

class _ScanQrCodeState extends State<ScanQrCode> {
  Barcode? result;
  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    }
    controller!.resumeCamera();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(flex: 5, child: _buildQrView(context)),
          Container(
            color: Colors.black,
            padding: EdgeInsets.symmetric(vertical: width(context) * 0.03),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(width: width(context) * 0.04),
                InkWell(
                  onTap: () async {
                    await controller?.toggleFlash();
                    setState(() {});
                  },
                  child: FutureBuilder(
                    future: controller?.getFlashStatus(),
                    builder: (context, snapshot) {
                      return Icon(
                          snapshot.data == false
                              ? Icons.flash_off
                              : Icons.flash_on,
                          size: 30,
                          color: Colors.white);
                    },
                  ),
                ),
                const Spacer(),
                InkWell(
                  onTap: () async {
                    await controller?.flipCamera();
                    setState(() {});
                  },
                  child: FutureBuilder(
                    future: controller?.getCameraInfo(),
                    builder: (context, snapshot) {
                      if (snapshot.data != null) {
                        return const Icon(Icons.cameraswitch_outlined, color: Colors.white, size: 30);
                      } else {
                        return CustomText(
                            text: "Loading",
                            fontSize: AppFonts.t5,
                            color: Colors.white);
                      }
                    },
                  ),
                ),
                const Spacer(),
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: CustomText(
                      text: "Cancel",
                      color: Colors.white,
                      fontSize: AppFonts.t4),
                ),
                SizedBox(width: width(context) * 0.04),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildQrView(BuildContext context) {
    var scanArea = (MediaQuery.of(context).size.width < 400 || MediaQuery.of(context).size.height < 400) ? 200.0 : 350.0;
    return QRView(
      key: qrKey,
      onQRViewCreated: _onQRViewCreated,
      overlay: QrScannerOverlayShape(
          borderColor: Colors.white,
          borderRadius: 10,
          borderLength: 30,
          borderWidth: 10,
          cutOutSize: scanArea),
      onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    controller.resumeCamera();
    setState(() {
      this.controller = controller;
    });
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData;
      });
    }).onData((data) {
      setState(() {
        print(data.code.toString() + "   --------------");
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => ProductDetailsScreen(id: data.code,)));
        controller.dispose();
        controller.stopCamera();

      });
    });
  }

  void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    log('${DateTime.now().toIso8601String()}_onPermissionSet $p');
    if (!p) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('no Permission')),
      );
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}