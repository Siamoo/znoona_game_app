import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medaan_almaarifa/core/helpers/znoona.colors.dart';
import 'package:medaan_almaarifa/core/helpers/znoona_texts.dart';
import 'package:medaan_almaarifa/core/language/lang_keys.dart';
import 'package:medaan_almaarifa/core/style/images/app_images.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/services.dart' show Clipboard, ClipboardData;

class ErrorScreen extends StatelessWidget {
  const ErrorScreen({
    super.key,
    this.errorMessage,
    this.onRetry,
  });

  final String? errorMessage;
  final VoidCallback? onRetry;

  Future<void> _copyEmail(BuildContext context) async {
    await Clipboard.setData(const ClipboardData(text: 'walidsyam.f@gmail.com'));
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(ZnoonaTexts.tr(context, LangKeys.emailCopied)),
          duration: const Duration(seconds: 2),
          backgroundColor: Colors.green,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ZnoonaColors.main(context),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Error Image
              Container(
                padding: EdgeInsets.all(20.w),
                decoration: BoxDecoration(
                  color: Colors.red.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Image.asset(
                  AppImages.error,
                  width: 200.w,
                  height: 200.h,
                  errorBuilder: (context, error, stackTrace) {
                    return Icon(
                      Icons.error_outline,
                      size: 80.sp,
                      color: Colors.red.shade300,
                    );
                  },
                ),
              ),

              SizedBox(height: 24.h),

              // Error Title
              Text(
                ZnoonaTexts.tr(context, LangKeys.somethingWentWrong),
                style: GoogleFonts.beiruti(
                  fontSize: 24.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.red.shade700,
                ),
                textAlign: TextAlign.center,
              ),

              SizedBox(height: 12.h),

              // Error Message
              if (errorMessage != null) ...[
                Text(
                  errorMessage!,
                  style: GoogleFonts.beiruti(
                    fontSize: 14.sp,
                    color: Colors.grey.shade600,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 8.h),
              ],

              // Description
              Text(
                ZnoonaTexts.tr(context, LangKeys.errorMessage),
                style: GoogleFonts.beiruti(
                  fontSize: 14.sp,
                  color: Colors.grey.shade600,
                ),
                textAlign: TextAlign.center,
              ),

              SizedBox(height: 32.h),

              // Retry Button
              if (onRetry != null)
                SizedBox(
                  width: double.infinity,
                  height: 50.h,
                  child: ElevatedButton(
                    onPressed: onRetry,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: ZnoonaColors.bluePinkDark(context),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                    ),
                    child: Text(
                      ZnoonaTexts.tr(context, LangKeys.tryAgain),
                      style: GoogleFonts.beiruti(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),

              SizedBox(height: 12.h),

              // Contact Support Button
              SizedBox(
                width: double.infinity,
                height: 50.h,
                child: OutlinedButton(
                  onPressed: () => _copyEmail(context),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: ZnoonaColors.bluePinkDark(context),
                    side: BorderSide(
                      color: ZnoonaColors.bluePinkDark(
                        context,
                      ).withOpacity(0.3),
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                  ),
                  child: Text(
                    ZnoonaTexts.tr(context, LangKeys.copyEmail),
                    style: GoogleFonts.beiruti(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),

              SizedBox(height: 16.h),

              // Email Display
              GestureDetector(
                onTap: () => _copyEmail(context),
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 12.w,
                    vertical: 6.h,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.email,
                        size: 14.sp,
                        color: Colors.grey.shade700,
                      ),
                      SizedBox(width: 4.w),
                      Text(
                        'walidsyam.f@gmail.com',
                        style: GoogleFonts.beiruti(
                          fontSize: 12.sp,
                          color: Colors.grey.shade700,
                        ),
                      ),
                      SizedBox(width: 4.w),
                      Icon(
                        Icons.copy,
                        size: 14.sp,
                        color: Colors.grey.shade700,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
