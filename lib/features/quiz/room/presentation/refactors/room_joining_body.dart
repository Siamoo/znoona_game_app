import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medaan_almaarifa/core/common/animations/animate_do.dart';
import 'package:medaan_almaarifa/core/common/widgets/custom_app_bar.dart';
import 'package:medaan_almaarifa/core/common/widgets/custom_text_filed.dart';
import 'package:medaan_almaarifa/core/helpers/znoona_navigate.dart';
import 'package:medaan_almaarifa/core/helpers/znoona_texts.dart';
import 'package:medaan_almaarifa/core/language/lang_keys.dart';
import 'package:medaan_almaarifa/core/style/images/app_images.dart';
import 'package:medaan_almaarifa/features/quiz/room/presentation/cubit/room_cubit.dart';
import 'package:medaan_almaarifa/features/quiz/room/presentation/screen/room_lobby_screen.dart';
import 'package:medaan_almaarifa/features/quiz/room/presentation/widgets/joining/enter_code_or_scan.dart';
import 'package:medaan_almaarifa/features/quiz/room/presentation/widgets/joining/join_room_button.dart';
import 'package:medaan_almaarifa/features/quiz/room/presentation/widgets/joining/scan_qr_button.dart';

class RoomJoiningBody extends StatefulWidget {
  const RoomJoiningBody({super.key});
  @override
  State<RoomJoiningBody> createState() => _RoomJoiningBodyState();
}

class _RoomJoiningBodyState extends State<RoomJoiningBody> {
  final TextEditingController _codeController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _codeController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _ensureTextFieldVisible() {
    Future.delayed(const Duration(milliseconds: 300), () {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
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
          child: SingleChildScrollView(
            controller: _scrollController,
            padding: EdgeInsets.symmetric(
              vertical: 10.h,
              horizontal: 10.w,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomAppBar(title: ZnoonaTexts.tr(context, LangKeys.joinRoom)),
                SizedBox(height: 50.h),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 14.w,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomFadeInDown(
                        duration: 850,
                        child: Image.asset(
                          AppImages.join,
                          height: 200.h,
                          width: 200.w,
                        ),
                      ),
                      const SizedBox(height: 24),
                      const CustomFadeInDown(
                        duration: 700,
                        child: EnterCodeOrScan(),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20.h),
                Form(
                  key: _formKey,
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 14.w,
                    ),
                    child: Column(
                      children: [
                        CustomFadeInDown(
                          duration: 600,
                          child: CustomTextField(
                            controller: _codeController,
                            hintText: ZnoonaTexts.tr(
                              context,
                              LangKeys.enterRoomCode,
                            ),
                            keyboardType: TextInputType.number,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return ZnoonaTexts.tr(
                                  context,
                                  LangKeys.pleaseEnterRoomCode,
                                );
                              }
                              if (value.length != 6) {
                                return ZnoonaTexts.tr(
                                  context,
                                  LangKeys.roomCodeMustBe6,
                                );
                              }
                              return null;
                            },
                            suffixIcon: const Icon(Icons.key),
                            onTap: _ensureTextFieldVisible, // Add this
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
                              child: CustomFadeInDown(
                                duration: 500,
                                child: JoinRoomButton(
                                  isLoading: isLoading,
                                  formKey: _formKey,
                                  codeController: _codeController,
                                ),
                              ),
                            );
                          },
                        ),
                        SizedBox(height: 10.h),
                        const CustomFadeInDown(
                          duration: 400,
                          child: ScanQrButton(),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 160.h,
                  width: double.infinity,
                  child: Stack(
                    children: [
                      Positioned(
                        left: 0,
                        right: 200.w,
                        bottom: 0,
                        child: FadeInLeft(
                          duration: const Duration(milliseconds: 4000),
                          from: 120,
                          child: Image.asset(
                            AppImages.blackMHand,
                            height: 140.h,
                          ),
                        ),
                      ),
                      Positioned(
                        left: 0,
                        right: 0,
                        bottom: 0,
                        child: FadeInLeft(
                          duration: const Duration(milliseconds: 4000),
                          from: 180.w,
                          child: Image.asset(
                            AppImages.yelloWTraveler,
                            height: 130.h,
                          ),
                        ),
                      ),

                      Positioned(
                        left: 250.w,
                        right: 0,
                        bottom: 0,
                        child: FadeInRight(
                          duration: const Duration(milliseconds: 4000),
                          child: Center(
                            child: Image.asset(
                              AppImages.redWStady,
                              height: 60.h,
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
      ),
    );
  }
}
