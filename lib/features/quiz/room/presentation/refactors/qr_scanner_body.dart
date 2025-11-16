// features/quiz/room/presentation/screen/qr_scanner_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:znoona_game_app/core/helpers/znoona_texts.dart';
import 'package:znoona_game_app/core/language/lang_keys.dart';
import 'package:znoona_game_app/features/quiz/room/presentation/cubit/room_cubit.dart';

class QRScannerBody extends StatefulWidget {
  const QRScannerBody({super.key});

  @override
  State<QRScannerBody> createState() => _QRScannerBodyState();
}

class _QRScannerBodyState extends State<QRScannerBody> {
  MobileScannerController cameraController = MobileScannerController();
  bool _isScanning = true;
  bool _hasPermission = false;
  bool _isCheckingPermission = false;

  @override
  void initState() {
    super.initState();
    _checkCameraPermission();
  }

  @override
  void dispose() {
    cameraController.dispose();
    super.dispose();
  }

  Future<void> _checkCameraPermission() async {
    setState(() {
      _isCheckingPermission = true;
    });

    final status = await Permission.camera.status;

    if (status.isGranted) {
      setState(() {
        _hasPermission = true;
        _isCheckingPermission = false;
      });
    } else if (status.isDenied) {
      final result = await Permission.camera.request();
      setState(() {
        _hasPermission = result.isGranted;
        _isCheckingPermission = false;
      });
    } else {
      // Permission is permanently denied
      setState(() {
        _hasPermission = false;
        _isCheckingPermission = false;
      });

      if (status.isPermanentlyDenied) {
        _showPermissionDeniedDialog();
      }
    }
  }

  void _showPermissionDeniedDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(ZnoonaTexts.tr(context, LangKeys.cameraPermission)),
        content: Text(
          ZnoonaTexts.tr(context, LangKeys.cameraPermissionRequired),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(ZnoonaTexts.tr(context, LangKeys.cancel)),
          ),
          TextButton(
            onPressed: () async {
              Navigator.pop(context);
              await openAppSettings();
            },
            child: Text(ZnoonaTexts.tr(context, LangKeys.settings)),
          ),
        ],
      ),
    );
  }

  void _onQRCodeDetect(String code) {
    if (!_isScanning) return;

    setState(() {
      _isScanning = false;
    });

    // Validate the code (should be 6 digits)
    if (code.length == 6 && int.tryParse(code) != null) {
      // Join room with the scanned code
      context
          .read<RoomCubit>()
          .joinRoom(code: code)
          .then((_) {
            // Navigator will be handled by the bloc listener
          })
          .catchError((error) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  ZnoonaTexts.tr(context, LangKeys.invalidQrCode),
                ),
                backgroundColor: Colors.red,
              ),
            );
            setState(() {
              _isScanning = true;
            });
          });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            ZnoonaTexts.tr(context, LangKeys.invalidQrCode),
          ),
          backgroundColor: Colors.red,
        ),
      );
      setState(() {
        _isScanning = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: CustomAppBar(
      //   title: ZnoonaTexts.tr(context, LangKeys.scanQr),
      //   showBackButton: true,
      //   onBackPressed: () => ZnoonaNavigate.pop(context),
      // ),
      body: _isCheckingPermission
          ? const Center(child: CircularProgressIndicator())
          : !_hasPermission
          ? _buildPermissionDeniedView()
          : _buildScannerView(),
    );
  }

  Widget _buildScannerView() {
    return BlocListener<RoomCubit, RoomState>(
      listener: (context, state) {
        state.whenOrNull(
          error: (message) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(message),
                backgroundColor: Colors.red,
              ),
            );
            setState(() {
              _isScanning = true;
            });
          },
        );
      },
      child: Column(
        children: [
          Expanded(
            child: Stack(
              children: [
                MobileScanner(
                  controller: cameraController,
                  onDetect: (capture) {
                    final List<Barcode> barcodes = capture.barcodes;
                    for (final barcode in barcodes) {
                      if (barcode.rawValue != null) {
                        _onQRCodeDetect(barcode.rawValue!);
                        break;
                      }
                    }
                  },
                ),
                _buildScannerOverlay(),
              ],
            ),
          ),
          _buildInstructions(),
        ],
      ),
    );
  }

  Widget _buildScannerOverlay() {
    return Center(
      child: Container(
        width: 250,
        height: 250,
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.green,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }

  Widget _buildInstructions() {
    return Container(
      padding: const EdgeInsets.all(20),
      color: Colors.black.withOpacity(0.7),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            ZnoonaTexts.tr(context, LangKeys.scanRoomQr),
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Text(
            ZnoonaTexts.tr(context, LangKeys.alignQrInFrame),
            style: const TextStyle(
              color: Colors.white70,
              fontSize: 14,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildPermissionDeniedView() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.camera_alt_outlined,
              size: 80,
              color: Colors.grey,
            ),
            const SizedBox(height: 20),
            Text(
              ZnoonaTexts.tr(context, LangKeys.cameraPermissionDenied),
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),
            Text(
              ZnoonaTexts.tr(context, LangKeys.enableCameraToScan),
              style: const TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: _checkCameraPermission,
              child: Text(ZnoonaTexts.tr(context, LangKeys.retry)),
            ),
            const SizedBox(height: 10),
            TextButton(
              onPressed: () async {
                await openAppSettings();
              },
              child: Text(ZnoonaTexts.tr(context, LangKeys.openSettings)),
            ),
          ],
        ),
      ),
    );
  }
}
