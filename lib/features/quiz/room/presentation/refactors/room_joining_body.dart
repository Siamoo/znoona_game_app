import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:znoona_game_app/core/common/animations/animate_do.dart';
import 'package:znoona_game_app/core/common/widgets/custom_app_bar.dart';
import 'package:znoona_game_app/core/common/widgets/custom_linear_button.dart';
import 'package:znoona_game_app/core/common/widgets/custom_text_filed.dart';
import 'package:znoona_game_app/core/common/widgets/text_app.dart';
import 'package:znoona_game_app/core/helpers/znoona.colors.dart';
import 'package:znoona_game_app/core/helpers/znoona_navigate.dart';
import 'package:znoona_game_app/core/helpers/znoona_texts.dart';
import 'package:znoona_game_app/core/language/lang_keys.dart';
import 'package:znoona_game_app/core/style/images/app_images.dart';
import 'package:znoona_game_app/features/quiz/room/presentation/cubit/room_cubit.dart';
import 'package:znoona_game_app/features/quiz/room/presentation/screen/room_lobby_screen.dart';

class RoomJoiningBody extends StatefulWidget {
  const RoomJoiningBody({super.key});

  @override
  State<RoomJoiningBody> createState() => _RoomJoiningBodyState();
}

class _RoomJoiningBodyState extends State<RoomJoiningBody> {
  final TextEditingController _codeController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _codeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<RoomCubit, RoomState>(
        listener: (context, state) async {
          await state.whenOrNull(
            joined: (room) async {
              await ZnoonaNavigate.pushReplacementTo(
                context,
                RoomLobbyScreen(room: room),
              );
            },
            error: (message) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(message),
                  backgroundColor: Colors.red,
                ),
              );
            },
          );
        },
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 24.w,
            ),
            child: Column(
              children: [
                CustomAppBar(title: ZnoonaTexts.tr(context, LangKeys.joinRoom)),
                SizedBox(height: 50.h),
                SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomFadeInDown(
                        duration: 700,
                        child: Image.asset(
                          AppImages.join,
                          height: 250.h,
                          width: 250.w,
                        ),
                      ),
                      const SizedBox(height: 24),
                      CustomFadeInRight(
                        duration: 450,
                        child: TextApp(
                          text: ZnoonaTexts.tr(
                            context,
                            LangKeys.enterCodeOrScan,
                          ),
                          textStyle: GoogleFonts.beiruti(
                            fontSize: 24.sp,
                            fontWeight: FontWeight.bold,
                            color: ZnoonaColors.text(context),
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20.h),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      CustomFadeInRight(
                        duration: 550,
                        child: CustomTextField(
                          controller: _codeController,
                          hintText: ZnoonaTexts.tr(
                            context,
                            LangKeys.enterRoomCode,
                          ),
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              //todo : localization , and handle when open keyboard 
                              return 'Please enter room code';
                            }
                            if (value.length != 6) {
                              return 'Room code must be 6 characters';
                            }
                            return null;
                          },
                          suffixIcon: const Icon(Icons.key),
                        ),
                      ),
                      SizedBox(height: 10.h),
                      BlocBuilder<RoomCubit, RoomState>(
                        builder: (context, state) {
                          final isLoading = state.maybeMap(
                            loading: (_) => true,
                            orElse: () => false,
                          );
                          return SizedBox(
                            width: double.infinity,
                            child: CustomFadeInRight(
                              duration: 650,
                              child: CustomLinearButton(
                                height: 50.h,
                                onPressed: isLoading
                                    ? null
                                    : () {
                                        if (_formKey.currentState!.validate()) {
                                          context.read<RoomCubit>().joinRoom(
                                            code: _codeController.text.trim(),
                                          );
                                        }
                                      },

                                child: isLoading
                                    ? const SizedBox(
                                        height: 20,
                                        width: 20,
                                        child: CircularProgressIndicator(
                                          strokeWidth: 2,
                                          valueColor: AlwaysStoppedAnimation(
                                            Colors.white,
                                          ),
                                        ),
                                      )
                                    : Text(
                                        ZnoonaTexts.tr(
                                          context,
                                          LangKeys.joinRoom,
                                        ),
                                        style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                              ),
                            ),
                          );
                        },
                      ),

                      SizedBox(height: 10.h),
                      CustomFadeInRight(
                        duration: 750,
                        child: CustomLinearButton(
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
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: ZnoonaColors.text(context),
                                ),
                              ),
                            ],
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
      ),
    );
  }

  Future<void> _showQRScannerDialog(BuildContext context) async {
    await showDialog<dynamic>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Scan QR Code'),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.qr_code_scanner, size: 60, color: Colors.grey),
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
}
