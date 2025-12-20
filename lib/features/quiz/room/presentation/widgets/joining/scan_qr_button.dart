import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medaan_almaarifa/core/common/widgets/custom_linear_button.dart';
import 'package:medaan_almaarifa/core/helpers/znoona_navigate.dart';
import 'package:medaan_almaarifa/core/helpers/znoona_texts.dart';
import 'package:medaan_almaarifa/core/language/lang_keys.dart';
import 'package:medaan_almaarifa/features/quiz/room/presentation/refactors/qr_scanner_body.dart';
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
        // Navigate to QR Scanner Screen

        ZnoonaNavigate.pushTo(context, const QRScannerBody());
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.qr_code_scanner,
            color: Colors.white,
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
