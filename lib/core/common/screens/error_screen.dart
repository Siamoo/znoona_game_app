import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mailto/mailto.dart';
import 'package:medaan_almaarifa/core/helpers/znoona.colors.dart';
import 'package:medaan_almaarifa/core/helpers/znoona_texts.dart';
import 'package:medaan_almaarifa/core/language/lang_keys.dart';
import 'package:medaan_almaarifa/core/style/images/app_images.dart';
import 'package:url_launcher/url_launcher.dart';

class ErrorScreen extends StatelessWidget {
  const ErrorScreen({
    super.key,
    this.errorMessage,
    this.onRetry,
  });

  final String? errorMessage;
  final VoidCallback? onRetry;

  Future<void> _sendEmail(BuildContext context) async {
    final mailtoLink = Mailto(
      to: ['walidsyam.f@gmail.com'],
      subject: 'App Error Report - Medaan AlMaarifa',
      body:
          'Please describe the issue you encountered:\n\n'
          'Error Details: ${errorMessage ?? 'Unknown error'}\n'
          'Time: ${DateTime.now().toString()}\n\n'
          'Description of what happened:\n'
          '[Please describe the issue here]\n\n'
          'Steps to reproduce:\n'
          '1.\n'
          '2.\n'
          '3.\n',
    );

    final Uri emailUri = Uri.parse(mailtoLink.toString());

    try {
      if (await canLaunchUrl(emailUri)) {
        await launchUrl(
          emailUri,
          mode: LaunchMode.externalApplication,
        );
      } else {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Could not open email app'),
              backgroundColor: Colors.red,
            ),
          );
        }
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Error: Could not open email app'),
            backgroundColor: Colors.red,
          ),
        );
      }
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
                  width: 120.w,
                  height: 120.h,
                  errorBuilder: (context, error, stackTrace) {
                    return Icon(
                      Icons.error_outline,
                      size: 80.h,
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
                  fontSize: 24.h,
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
                    fontSize: 14.h,
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
                  fontSize: 14.h,
                  color: Colors.grey.shade600,
                ),
                textAlign: TextAlign.center,
              ),

              SizedBox(height: 32.h),

              // Try Again Button (optional)
              if (onRetry != null)
                SizedBox(
                  width: double.infinity,
                  height: 50.h,
                  child: ElevatedButton(
                    onPressed: onRetry,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                    ),
                    child: Text(
                      ZnoonaTexts.tr(context, LangKeys.tryAgain),
                      style: GoogleFonts.beiruti(
                        fontSize: 16.h,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),

              if (onRetry != null) SizedBox(height: 12.h),

              // Contact Support Button
              SizedBox(
                width: double.infinity,
                height: 50.h,
                child: ElevatedButton.icon(
                  onPressed: () => _sendEmail(context),
                  icon: Icon(Icons.email, color: Colors.white, size: 20.h),
                  label: Text(
                    ZnoonaTexts.tr(context, LangKeys.contactSupport),
                    style: GoogleFonts.beiruti(
                      fontSize: 16.h,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red.shade400,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                  ),
                ),
              ),

              SizedBox(height: 16.h),

              // Email Display
              Container(
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
                      size: 14.h,
                      color: Colors.grey.shade700,
                    ),
                    SizedBox(width: 4.w),
                    Text(
                      'walidsyam.f@gmail.com',
                      style: GoogleFonts.beiruti(
                        fontSize: 12.h,
                        color: Colors.grey.shade700,
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
}
