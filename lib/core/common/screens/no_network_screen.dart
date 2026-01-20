import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medaan_almaarifa/core/helpers/znoona.colors.dart';
import 'package:medaan_almaarifa/core/helpers/znoona_texts.dart';
import 'package:medaan_almaarifa/core/language/lang_keys.dart';
import 'package:medaan_almaarifa/core/style/images/app_images.dart';
import 'package:google_fonts/google_fonts.dart';

class NoNetworkScreen extends StatelessWidget {
  const NoNetworkScreen({super.key, this.onRetry});

  final VoidCallback? onRetry;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Scaffold(
      backgroundColor: ZnoonaColors.main(context),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Image Section with nice animation effect
              TweenAnimationBuilder(
                tween: Tween<double>(begin: 0.8, end: 1.0),
                duration: const Duration(milliseconds: 800),
                curve: Curves.elasticOut,
                builder: (context, double scale, child) {
                  return Transform.scale(
                    scale: scale,
                    child: Container(
                      padding: EdgeInsets.all(20.w),
                      decoration: BoxDecoration(
                        color: theme.cardColor.withOpacity(0.1),
                        shape: BoxShape.circle,
                      ),
                      child: Image.asset(
                        AppImages.noNetwork,
                        width: 200.w,
                        height: 200.h,
                        fit: BoxFit.contain,
                      ),
                    ),
                  );
                },
              ),
              
              SizedBox(height: 40.h),
              
              // Title
              Text(
                ZnoonaTexts.tr(context, LangKeys.noConnection),
                style: GoogleFonts.beiruti(
                  fontSize: 28.sp,
                  fontWeight: FontWeight.bold,
                  color: ZnoonaColors.bluePinkDark(context),
                ),
                textAlign: TextAlign.center,
              ),
              
              SizedBox(height: 16.h),
              
              // Description
              Text(
                ZnoonaTexts.tr(context, LangKeys.noConnectionMessage),
                style: GoogleFonts.beiruti(
                  fontSize: 16.sp,
                  color: ZnoonaColors.text(context).withOpacity(0.7),
                  height: 1.5,
                ),
                textAlign: TextAlign.center,
              ),
              
              SizedBox(height: 48.h),
              
              // Retry Button (if provided)
              if (onRetry != null)
                _buildRetryButton(context),
              
              // Check settings suggestion
              SizedBox(height: 24.h),
              
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.settings,
                    size: 16.sp,
                    color: ZnoonaColors.text(context).withOpacity(0.5),
                  ),
                  SizedBox(width: 8.w),
                  Text(
                    ZnoonaTexts.tr(context, LangKeys.checkNetworkSettings),
                    style: GoogleFonts.beiruti(
                      fontSize: 14.sp,
                      color: ZnoonaColors.text(context).withOpacity(0.5),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRetryButton(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 56.h,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            ZnoonaColors.main(context),
            ZnoonaColors.bluePinkDark(context),
          ],
        ),
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: ZnoonaColors.bluePinkDark(context).withOpacity(0.3),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onRetry,
          borderRadius: BorderRadius.circular(16.r),
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.refresh,
                  color: Colors.white,
                  size: 24.sp,
                ),
                SizedBox(width: 8.w),
                Text(
                  ZnoonaTexts.tr(context, LangKeys.tryAgain),
                  style: GoogleFonts.beiruti(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}