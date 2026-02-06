// features/quiz/room/presentation/screen/qr_scanner_screen.dart
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medaan_almaarifa/core/helpers/znoona.colors.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:medaan_almaarifa/core/helpers/znoona_navigate.dart';
import 'package:medaan_almaarifa/core/helpers/znoona_texts.dart';
import 'package:medaan_almaarifa/core/language/lang_keys.dart';
import 'package:medaan_almaarifa/core/style/images/app_images.dart';
import 'package:medaan_almaarifa/features/quiz/room/presentation/cubit/room_cubit.dart';

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
  bool _isFlashOn = false;
  double _scanLinePosition = 0.0;
  Timer? _scanLineTimer;

  @override
  void initState() {
    super.initState();
    _checkCameraPermission();
    _startScanLineAnimation();
  }

  void _startScanLineAnimation() {
    _scanLineTimer = Timer.periodic(const Duration(milliseconds: 20), (timer) {
      if (mounted) {
        setState(() {
          _scanLinePosition = (_scanLinePosition + 0.01) % 1.0;
        });
      }
    });
  }

  @override
  void dispose() {
    cameraController.dispose();
    _scanLineTimer?.cancel();
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
    showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: ZnoonaColors.bluePinkDark(context),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        title: Text(
          ZnoonaTexts.tr(context, LangKeys.cameraPermission),
          style: TextStyle(
            color: Colors.white,
            fontSize: 20.h,
            fontWeight: FontWeight.bold,
          ),
        ),
        content: Text(
          ZnoonaTexts.tr(context, LangKeys.cameraPermissionRequired),
          style: TextStyle(
            color: Colors.white70,
            fontSize: 16.h,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              ZnoonaTexts.tr(context, LangKeys.cancel),
              style: TextStyle(
                color: Colors.grey[400],
                fontSize: 16.h,
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () async {
              Navigator.pop(context);
              await openAppSettings();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: ZnoonaColors.main(context),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Text(
              ZnoonaTexts.tr(context, LangKeys.settings),
              style: TextStyle(
                color: Colors.white,
                fontSize: 16.h,
              ),
            ),
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
      // Show success feedback
      _showScanSuccessFeedback();

      // Join room with the scanned code
      context.read<RoomCubit>().joinRoom(code: code).catchError((error) {
        _showErrorFeedback();
      });
    } else {
      _showErrorFeedback();
    }
  }

  void _showScanSuccessFeedback() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.check_circle, color: Colors.white),
            SizedBox(width: 10.w),
            Expanded(
              child: Text(
                ZnoonaTexts.tr(context, LangKeys.roomCodeScannedSuccess),
                style: TextStyle(
                  fontSize: 16.h,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
        backgroundColor: Colors.green,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }

  void _showErrorFeedback() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.error, color: Colors.white),
            SizedBox(width: 10.w),
            Expanded(
              child: Text(
                ZnoonaTexts.tr(context, LangKeys.invalidQrCode),
                style: TextStyle(
                  fontSize: 16.h,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
        backgroundColor: Colors.red,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
    setState(() {
      _isScanning = true;
    });
  }

  void _toggleFlash() {
    setState(() {
      _isFlashOn = !_isFlashOn;
    });
    cameraController.toggleTorch();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Container(
            padding: EdgeInsets.all(8.w),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.5),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.arrow_back_ios_new_rounded,
              color: Colors.white,
              size: 20.w,
            ),
          ),
          onPressed: () => ZnoonaNavigate.pop(context),
        ),
        centerTitle: true,
        title: Text(
          ZnoonaTexts.tr(context, LangKeys.scanQr),
          style: TextStyle(
            color: Colors.white,
            fontSize: 22.h,
            fontWeight: FontWeight.bold,
            shadows: [
              Shadow(
                color: Colors.black.withOpacity(0.3),
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
        ),
        actions: [
          if (_hasPermission)
            IconButton(
              onPressed: _toggleFlash,
              icon: Container(
                padding: EdgeInsets.all(8.w),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.5),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  _isFlashOn ? Icons.flash_on : Icons.flash_off,
                  color: _isFlashOn ? Colors.yellow : Colors.white,
                  size: 22.w,
                ),
              ),
            ),
        ],
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return Stack(
      children: [
        // Background
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.black.withOpacity(0.9),
                Colors.black.withOpacity(0.95),
                Colors.black,
              ],
            ),
          ),
        ),

        // Main Content
        _isCheckingPermission
            ? _buildLoadingView()
            : !_hasPermission
            ? _buildPermissionDeniedView()
            : _buildScannerView(),

        // Bottom Instructions
        if (_hasPermission) _buildBottomInstructions(),
      ],
    );
  }

  Widget _buildLoadingView() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            AppImages.qrScanner,
            height: 120.h,
            width: 120.w,
            color: Colors.white,
          ),
          SizedBox(height: 20.h),
          Text(
            ZnoonaTexts.tr(context, LangKeys.settingUpScanner),
            style: TextStyle(
              color: Colors.white,
              fontSize: 18.h,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 20.h),
          const CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation(Colors.white),
            strokeWidth: 2,
          ),
        ],
      ),
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
      child: Stack(
        children: [
          // Camera Preview
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

          // Scanner Overlay
          _buildScannerOverlay(),

          // Corner Decorations
          _buildScannerCorners(),
        ],
      ),
    );
  }

  Widget _buildScannerOverlay() {
    return Container(
      decoration: BoxDecoration(
        gradient: RadialGradient(
          center: Alignment.center,
          radius: 1.0,
          colors: [
            Colors.transparent,
            Colors.black.withOpacity(0.7),
          ],
          stops: const [0.4, 1.0],
        ),
      ),
      child: Center(
        child: Container(
          width: 280.w,
          height: 280.h,
          decoration: BoxDecoration(
            border: Border.all(
              color: ZnoonaColors.main(context).withOpacity(0.8),
              width: 2.5,
            ),
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: ZnoonaColors.main(context).withOpacity(0.3),
                blurRadius: 20,
                spreadRadius: 5,
              ),
            ],
          ),
          child: Stack(
            children: [
              // Scan Line
              AnimatedPositioned(
                duration: const Duration(milliseconds: 20),
                top: _scanLinePosition * 280.w,
                left: 0,
                right: 0,
                child: Container(
                  height: 3,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.transparent,
                        ZnoonaColors.main(context),
                        Colors.transparent,
                      ],
                      stops: const [0.0, 0.5, 1.0],
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: ZnoonaColors.main(context).withOpacity(0.8),
                        blurRadius: 8,
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                ),
              ),

              // Corner Paints
              _buildCorner(
                top: 0,
                left: 0,
                isTopLeft: true,
              ),
              _buildCorner(
                top: 0,
                right: 0,
                isTopRight: true,
              ),
              _buildCorner(
                bottom: 0,
                left: 0,
                isBottomLeft: true,
              ),
              _buildCorner(
                bottom: 0,
                right: 0,
                isBottomRight: true,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCorner({
    double? top,
    double? bottom,
    double? left,
    double? right,
    bool isTopLeft = false,
    bool isTopRight = false,
    bool isBottomLeft = false,
    bool isBottomRight = false,
  }) {
    return Positioned(
      top: top,
      bottom: bottom,
      left: left,
      right: right,
      child: Container(
        width: 25.w,
        height: 25.h,
        child: CustomPaint(
          painter: _CornerPainter(
            color: ZnoonaColors.main(context),
            isTopLeft: isTopLeft,
            isTopRight: isTopRight,
            isBottomLeft: isBottomLeft,
            isBottomRight: isBottomRight,
          ),
        ),
      ),
    );
  }

  Widget _buildScannerCorners() {
    return Positioned.fill(
      child: IgnorePointer(
        child: Container(
          padding: EdgeInsets.all(20.w),
          child: Column(
            children: [
              SizedBox(height: 100.h),
              Expanded(
                child: Row(
                  children: [
                    _buildCornerIcon(Icons.qr_code_2),
                    const Spacer(),
                    _buildCornerIcon(Icons.qr_code_scanner),
                  ],
                ),
              ),
              SizedBox(height: 280.h),
              Expanded(
                child: Row(
                  children: [
                    _buildCornerIcon(Icons.radio_button_checked),
                    const Spacer(),
                    _buildCornerIcon(Icons.verified),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCornerIcon(IconData icon) {
    return Icon(
      icon,
      color: Colors.white.withOpacity(0.2),
      size: 30.w,
    );
  }

  Widget _buildBottomInstructions() {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(20.w),
          child: Column(
            children: [
              Text(
                ZnoonaTexts.tr(context, LangKeys.scanRoomQr),
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18.h,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.5,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 8.h),
              Text(
                ZnoonaTexts.tr(context, LangKeys.alignQrInFrame),
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 14.h,
                  fontWeight: FontWeight.w400,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20.h),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 20.w,
                  vertical: 10.h,
                ),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: Colors.white.withOpacity(0.2),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.info_outline,
                      color: Colors.white.withOpacity(0.7),
                      size: 16.w,
                    ),
                    SizedBox(width: 8.w),
                    Text(
                      ZnoonaTexts.tr(context, LangKeys.scanSixDigitCode),
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.7),
                        fontSize: 12.h,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPermissionDeniedView() {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(24.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              AppImages.permission,
              height: 150.h,
              width: 150.w,
              color: Colors.white70,
            ),
            SizedBox(height: 30.h),
            Text(
              ZnoonaTexts.tr(context, LangKeys.cameraPermissionDenied),
              style: TextStyle(
                fontSize: 22.h,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 16.h),
            Text(
              ZnoonaTexts.tr(context, LangKeys.enableCameraToScan),
              style: TextStyle(
                fontSize: 16.h,
                color: Colors.white70,
                height: 1.5,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 40.h),
            Column(
              children: [
                ElevatedButton(
                  onPressed: _checkCameraPermission,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ZnoonaColors.main(context),
                    foregroundColor: Colors.white,
                    minimumSize: Size(double.infinity, 56.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    elevation: 4,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.refresh),
                      SizedBox(width: 10.w),
                      Text(
                        ZnoonaTexts.tr(context, LangKeys.retry),
                        style: TextStyle(
                          fontSize: 16.h,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 16.h),
                OutlinedButton(
                  onPressed: () async {
                    await openAppSettings();
                  },
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.white,
                    minimumSize: Size(double.infinity, 56.h),
                    side: BorderSide(
                      color: Colors.white.withOpacity(0.3),
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.settings),
                      SizedBox(width: 10.w),
                      Text(
                        ZnoonaTexts.tr(context, LangKeys.openSettings),
                        style: TextStyle(
                          fontSize: 16.h,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _CornerPainter extends CustomPainter {
  final Color color;
  final bool isTopLeft;
  final bool isTopRight;
  final bool isBottomLeft;
  final bool isBottomRight;

  _CornerPainter({
    required this.color,
    this.isTopLeft = false,
    this.isTopRight = false,
    this.isBottomLeft = false,
    this.isBottomRight = false,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 4
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    final path = Path();

    if (isTopLeft) {
      path.moveTo(0, size.height * 0.5);
      path.lineTo(0, 0);
      path.lineTo(size.width * 0.5, 0);
    } else if (isTopRight) {
      path.moveTo(size.width * 0.5, 0);
      path.lineTo(size.width, 0);
      path.lineTo(size.width, size.height * 0.5);
    } else if (isBottomLeft) {
      path.moveTo(0, size.height * 0.5);
      path.lineTo(0, size.height);
      path.lineTo(size.width * 0.5, size.height);
    } else if (isBottomRight) {
      path.moveTo(size.width * 0.5, size.height);
      path.lineTo(size.width, size.height);
      path.lineTo(size.width, size.height * 0.5);
    }

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
