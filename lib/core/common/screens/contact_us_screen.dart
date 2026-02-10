import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mailto/mailto.dart';
import 'package:medaan_almaarifa/core/common/widgets/custom_linear_button.dart';
import 'package:medaan_almaarifa/core/common/widgets/text_app.dart';
import 'package:medaan_almaarifa/core/helpers/znoona.colors.dart';
import 'package:medaan_almaarifa/core/helpers/znoona_texts.dart';
import 'package:medaan_almaarifa/core/language/lang_keys.dart';
import 'package:medaan_almaarifa/core/style/images/app_images.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactUsScreen extends StatelessWidget {
  const ContactUsScreen({super.key});

  final phoneNumber = '+201206611795';
  final email = 'medaanalmaarifa@gmail.com';
  final whatsappNumber = '201206611795';
  final facebookUrl = 'https://www.facebook.com/walidA.siam?locale=ar_AR';

  Future<void> _callUs(BuildContext context) async {
    final Uri phoneUri = Uri(scheme: 'tel', path: phoneNumber);

    try {
      if (await canLaunchUrl(phoneUri)) {
        await launchUrl(phoneUri);
      } else {
        if (context.mounted) {
          _showErrorSnackbar(context, 'Could not open phone dialer');
        }
      }
    } catch (e) {
      if (context.mounted) {
        _showErrorSnackbar(context, 'Error: Could not make phone call');
      }
    }
  }

  Future<void> _sendEmail(BuildContext context) async {
    final mailtoLink = Mailto(
      to: [email],
      subject: 'Contact Us - Medaan AlMaarifa',
      body: 'Hello,\n\nI would like to inquire about...\n\n',
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
          _showErrorSnackbar(context, 'Could not open email app');
        }
      }
    } catch (e) {
      if (context.mounted) {
        _showErrorSnackbar(context, 'Error: Could not open email app');
      }
    }
  }

  Future<void> _openWhatsApp(BuildContext context) async {
    final message = Uri.encodeComponent(
      "Hello, I need help with Medaan AlMaarifa app",
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

  Future<void> _openFacebook(BuildContext context) async {
    final Uri facebookUri = Uri.parse(facebookUrl);

    try {
      if (await canLaunchUrl(facebookUri)) {
        await launchUrl(
          facebookUri,
          mode: LaunchMode.externalApplication,
        );
      } else {
        if (context.mounted) {
          _showErrorSnackbar(context, 'Could not open Facebook');
        }
      }
    } catch (e) {
      if (context.mounted) {
        _showErrorSnackbar(context, 'Error: Could not open Facebook');
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
          child: SingleChildScrollView(
            child: Column(
              children: [
                FadeInLeft(
                  duration: const Duration(milliseconds: 2200),
                  child: FadeInDown(
                    duration: const Duration(milliseconds: 1500),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(width: 40.w),
                        Center(
                          child: TextApp(
                            text: ZnoonaTexts.tr(context, LangKeys.contactUs),
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
                ),
                SizedBox(height: 20.h),

                // Header Image
                FadeInLeft(
                  duration: const Duration(milliseconds: 2100),
                  child: FadeInDown(
                    duration: const Duration(milliseconds: 1500),
                    child: Center(
                      child: Image.asset(
                        AppImages.callUs,
                        height: 150.h,
                        width: 150.w,
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
                ),

                SizedBox(height: 16.h),

                // Title
                FadeInLeft(
                  duration: const Duration(milliseconds: 2000),
                  child: FadeInDown(
                    duration: const Duration(milliseconds: 1300),
                    child: TextApp(
                      text: ZnoonaTexts.tr(context, LangKeys.howCanWeHelp),
                      textStyle: GoogleFonts.beiruti(
                        fontSize: 24.h,
                        fontWeight: FontWeight.bold,
                        color: ZnoonaColors.text(context),
                      ),
                    ),
                  ),
                ),

                SizedBox(height: 8.h),

                // Subtitle
                FadeInLeft(
                  duration: const Duration(milliseconds: 1900),
                  child: FadeInDown(
                    duration: const Duration(milliseconds: 1200),
                    child: TextApp(
                      text: ZnoonaTexts.tr(context, LangKeys.chooseOptionBelow),
                      textStyle: GoogleFonts.beiruti(
                        fontSize: 18.h,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ),
                ),

                SizedBox(height: 30.h),

                // Call Button
                FadeInLeft(
                  duration: const Duration(milliseconds: 1700),
                  child: FadeInDown(
                    duration: const Duration(milliseconds: 1000),
                    child: CustomLinearButton(
                      borderRadiusNum: 20,
                      colors: [
                        Colors.deepPurpleAccent.shade200,
                        Colors.deepPurple.shade800,
                      ],
                      height: 70.h,
                      width: double.infinity,
                      onPressed: () => _callUs(context),
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.w),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              AppImages.callUs,
                              height: 50.h,
                              width: 50.w,
                              errorBuilder: (context, error, stackTrace) {
                                return Icon(
                                  Icons.phone,
                                  color: Colors.white,
                                  size: 30.h,
                                );
                              },
                            ),
                            SizedBox(width: 10.w),
                            TextApp(
                              text: ZnoonaTexts.tr(context, LangKeys.callUs),
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
                ),

                SizedBox(height: 10.h),

                // Email Button
                FadeInLeft(
                  duration: const Duration(milliseconds: 1500),
                  child: FadeInDown(
                    duration: const Duration(milliseconds: 900),
                    child: CustomLinearButton(
                      borderRadiusNum: 20,
                      colors: [
                        Colors.yellow.shade700,
                        Colors.deepOrange.shade700,
                      ],
                      height: 70.h,
                      width: double.infinity,
                      onPressed: () => _sendEmail(context),
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.w),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              AppImages.email,
                              height: 50.h,
                              width: 50.w,
                              errorBuilder: (context, error, stackTrace) {
                                return Icon(
                                  Icons.email,
                                  color: Colors.white,
                                  size: 30.h,
                                );
                              },
                            ),
                            SizedBox(width: 10.w),
                            TextApp(
                              text: ZnoonaTexts.tr(context, LangKeys.emailUs),
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
                ),

                SizedBox(height: 10.h),

                // WhatsApp Button
                FadeInLeft(
                  duration: const Duration(milliseconds: 1300),
                  child: FadeInDown(
                    duration: const Duration(milliseconds: 700),
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
                ),

                SizedBox(height: 10.h),

                // Facebook Button
                FadeInLeft(
                  duration: const Duration(milliseconds: 1100),

                  child: FadeInDown(
                    duration: const Duration(milliseconds: 500),
                    child: CustomLinearButton(
                      borderRadiusNum: 20,
                      colors: [
                        Colors.blue.shade700,
                        Colors.blue.shade900,
                      ],
                      height: 70.h,
                      width: double.infinity,
                      onPressed: () => _openFacebook(context),
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.w),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              AppImages.facebook,
                              height: 50.h,
                              width: 50.w,
                              errorBuilder: (context, error, stackTrace) {
                                return Icon(
                                  Icons.facebook,
                                  color: Colors.white,
                                  size: 30.h,
                                );
                              },
                            ),
                            SizedBox(width: 10.w),
                            TextApp(
                              text: ZnoonaTexts.tr(context, LangKeys.facebook),
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
                ),

                SizedBox(height: 20.h),

                // App Version
                TextApp(
                  text: '${ZnoonaTexts.tr(context, LangKeys.appVersion)} 1.0.0',
                  textStyle: GoogleFonts.beiruti(
                    fontSize: 12.h,
                    color: ZnoonaColors.text(context).withOpacity(0.7),
                  ),
                ),

                SizedBox(height: 20.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
