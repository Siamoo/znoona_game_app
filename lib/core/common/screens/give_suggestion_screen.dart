import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medaan_almaarifa/core/common/widgets/custom_linear_button.dart';
import 'package:medaan_almaarifa/core/common/widgets/text_app.dart';
import 'package:medaan_almaarifa/core/helpers/znoona.colors.dart';
import 'package:medaan_almaarifa/core/helpers/znoona_texts.dart';
import 'package:medaan_almaarifa/core/language/lang_keys.dart';
import 'package:medaan_almaarifa/core/style/images/app_images.dart';
import 'package:url_launcher/url_launcher.dart';

class GiveSuggestionScreen extends StatelessWidget {
  const GiveSuggestionScreen({super.key});

  final String whatsappNumber = '201206611795';

  Future<void> _openWhatsApp(BuildContext context) async {
    final message = Uri.encodeComponent(
      'Hello, I Have a suggestion for Medaan AlMaarifa app',
    );
    final url = Uri.parse("https://wa.me/$whatsappNumber?text=$message");

    try {
      if (await canLaunchUrl(url)) {
        await launchUrl(
          url,
          mode: LaunchMode.externalApplication,
        );
      } else {
        if (context.mounted) {
          _showErrorSnackbar(context, 'Could not open WhatsApp');
        }
      }
    } catch (e) {
      if (context.mounted) {
        _showErrorSnackbar(context, 'Error: Could not open WhatsApp');
      }
    }
  }

  void _showErrorSnackbar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ZnoonaColors.main(context),

      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  FadeInDown(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(width: 40.w),
                        Center(
                          child: TextApp(
                            text: ZnoonaTexts.tr(context, LangKeys.suggestions),
                            textStyle: GoogleFonts.beiruti(
                              fontSize: 26.h,
                              fontWeight: FontWeight.bold,
                              color: ZnoonaColors.text(context),
                            ),
                          ),
                        ),
                        IconButton(
                          icon: Icon(
                            Icons.close,
                            size: 30.h,
                            color: ZnoonaColors.text(context),
                          ),
                          onPressed: () => Navigator.of(context).pop(),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20.h),

                  // Header Image
                  FadeInDown(
                    delay: const Duration(milliseconds: 200),
                    child: Center(
                      child: Image.asset(
                        AppImages.puzzle,
                        height: 170.h,
                        width: 170.w,
                        errorBuilder: (context, error, stackTrace) {
                          return Icon(
                            Icons.support_agent,
                            size: 80.h,
                            color: ZnoonaColors.bluePinkDark(context),
                          );
                        },
                      ),
                    ),
                  ),

                  SizedBox(height: 16.h),

                  // Title
                  FadeInDown(
                    delay: const Duration(milliseconds: 300),
                    child: TextApp(
                      text: ZnoonaTexts.tr(context, LangKeys.howCanWeHelp),
                      textStyle: GoogleFonts.beiruti(
                        fontSize: 24.h,
                        fontWeight: FontWeight.bold,
                        color: ZnoonaColors.text(context),
                      ),
                    ),
                  ),

                  SizedBox(height: 8.h),

                  // Subtitle
                  FadeInDown(
                    delay: const Duration(milliseconds: 400),
                    child: TextApp(
                      text: ZnoonaTexts.tr(context, LangKeys.newAppSuggestions),
                      textStyle: GoogleFonts.beiruti(
                        fontSize: 18.h,
                        color: Colors.grey.shade600,
                      ),
                      maxLines: 4,
                      textAlign: TextAlign.center,
                    ),
                  ),

                  SizedBox(height: 30.h),

                  // WhatsApp Button
                  FadeInDown(
                    delay: const Duration(milliseconds: 500),
                    child: CustomLinearButton(
                      borderRadiusNum: 20,
                      colors: [
                        Colors.green.shade600,
                        Colors.green.shade900,
                      ],
                      height: 70.h,
                      width: double.infinity,
                      onPressed: () => _openWhatsApp(context),
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.w),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              AppImages.whatsapp,
                              height: 50.h,
                              width: 50.w,
                              errorBuilder: (context, error, stackTrace) {
                                return Icon(
                                  Icons.message,
                                  color: Colors.white,
                                  size: 30.h,
                                );
                              },
                            ),
                            SizedBox(width: 10.w),
                            TextApp(
                              text: ZnoonaTexts.tr(context, LangKeys.whatsapp),
                              textStyle: GoogleFonts.beiruti(
                                fontSize: 22.h,
                                fontWeight: FontWeight.w800,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 250.h,
                width: double.infinity,
                child: Stack(
                  children: [
                    Positioned(
                      left: 10.w,
                      bottom: 180.h,
                      child: FadeInLeft(
                        duration: const Duration(seconds: 10),
                        from: 50.h,
                        curve: Curves.elasticOut,
                        child: FadeInDown(
                          duration: const Duration(seconds: 10),
                          from: 60.w,
                          child: Image.asset(
                            AppImages.birds,
                            height: 30.h,
                          ),
                        ),
                      ),
                    ),

                    Positioned(
                      right: 100.w,
                      bottom: 150.h,
                      child: FadeInDown(
                        duration: const Duration(seconds: 6),
                        from: 20.h,
                        curve: Curves.elasticInOut,
                        child: FadeInRight(
                          duration: const Duration(seconds: 6),
                          // curve: Curves.elasticOut,
                          from: 150.w,
                          child: Image.asset(
                            AppImages.bird,
                            height: 30.h,
                          ),
                        ),
                      ),
                    ),

                    Positioned(
                      right: 10.w,
                      bottom: 0,
                      child: FadeInRight(
                        duration: const Duration(seconds: 2),
                        from: 120,
                        child: Image.asset(
                          AppImages.blueMSkates,
                          height: 90.h,
                        ),
                      ),
                    ),

                    Positioned(
                      right: 200.w,
                      bottom: 0,
                      child: FadeInLeft(
                        duration: const Duration(milliseconds: 1400),
                        child: Center(
                          child: Image.asset(
                            AppImages.manBirds,
                            height: 110.h,
                          ),
                        ),
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
