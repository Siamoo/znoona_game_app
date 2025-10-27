import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:znoona_game_app/core/common/widgets/custom_linear_button.dart';
import 'package:znoona_game_app/core/helpers/znoona.colors.dart';
import 'package:znoona_game_app/core/helpers/znoona_texts.dart';
import 'package:znoona_game_app/core/language/lang_keys.dart';

class ScanQrButton extends StatelessWidget {
  const ScanQrButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CustomLinearButton(
      height: 50.h,
      width: double.infinity,
      onPressed: () async {
        await _showQRScannerDialog(context);
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.qr_code_scanner,
            color: ZnoonaColors.text(context),
          ),
          SizedBox(width: 10.w),
          Text(
            ZnoonaTexts.tr(
              context,
              LangKeys.scanQr,
            ),
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}

Future<void> _showQRScannerDialog(BuildContext context) async {
  await showDialog<dynamic>(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text('Scan QR Code'),
      content: const Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.qr_code_scanner, size: 60, color: Colors.black),
          SizedBox(height: 16),
          Text('QR Scanner functionality coming soon!'),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('OK'),
        ),
      ],
    ),
  );
}
