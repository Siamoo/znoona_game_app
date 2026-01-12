import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medaan_almaarifa/core/app/app_cubit/app_cubit.dart';
import 'package:medaan_almaarifa/core/common/widgets/text_app.dart';
import 'package:medaan_almaarifa/core/di/injcetion_container.dart';
import 'package:medaan_almaarifa/core/helpers/audio_service.dart';
import 'package:medaan_almaarifa/core/helpers/znoona.colors.dart';
import 'package:medaan_almaarifa/core/helpers/znoona_texts.dart';
import 'package:medaan_almaarifa/core/language/lang_keys.dart';
import 'package:medaan_almaarifa/features/home/widgets/custom_section_title.dart';

class SoundSettingsScreen extends StatelessWidget {
  const SoundSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 10.w,
              vertical: 10.h,
            ),
            child: BlocBuilder<AppCubit, AppState>(
              builder: (context, state) {
                final cubit = context.read<AppCubit>();
                final audioService = sl<AudioService>();

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Custom App Bar
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.w),
                      child: Row(
                        children: [
                          IconButton(
                            onPressed: () => Navigator.pop(context),
                            icon: Icon(
                              Icons.arrow_back_ios,
                              color: ZnoonaColors.text(context),
                              size: 20.sp,
                            ),
                          ),
                          SizedBox(width: 8.w),
                          TextApp(
                            text: ZnoonaTexts.tr(
                              context,
                              LangKeys.soundSettings,
                            ),
                            textStyle: TextStyle(
                              fontSize: 20.sp,
                              fontWeight: FontWeight.bold,
                              color: ZnoonaColors.text(context),
                            ),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: 20.h),

                    // Sound Effects Section
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.w),
                      child: const CustomSectionTitle(
                        langkey: LangKeys.soundEffects,
                      ),
                    ),
                    SizedBox(height: 10.h),

                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 10.w),
                      decoration: BoxDecoration(
                        color: ZnoonaColors.main(context),
                        borderRadius: BorderRadius.circular(16.r),
                        border: Border.all(
                          color: ZnoonaColors.textFormBorder(context),
                          width: 1.w,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: ZnoonaColors.bluePinkDark(
                              context,
                            ).withAlpha(200),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(16.w),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Container(
                                  padding: EdgeInsets.all(8.w),
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: [
                                        ZnoonaColors.bluePinkDark(context),
                                        ZnoonaColors.bluePinkLight(context),
                                      ],
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                    ),
                                    borderRadius: BorderRadius.circular(12.r),
                                  ),
                                  child: Icon(
                                    Icons.volume_up,
                                    color: Colors.white,
                                    size: 20.sp,
                                  ),
                                ),
                                SizedBox(width: 12.w),
                                Expanded(
                                  child: TextApp(
                                    text: ZnoonaTexts.tr(
                                      context,
                                      LangKeys.soundEffects,
                                    ),
                                    textStyle: TextStyle(
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w500,
                                      color: ZnoonaColors.text(context),
                                    ),
                                  ),
                                ),
                                Switch(
                                  value: state.isSoundEnabled,
                                  onChanged: (_) => cubit.toggleSound(),
                                  activeThumbColor: ZnoonaColors.bluePinkLight(
                                    context,
                                  ),
                                  activeTrackColor:
                                      ZnoonaColors.containerLinear1(
                                        context,
                                      ),
                                ),
                              ],
                            ),
                            if (state.isSoundEnabled) ...[
                              SizedBox(height: 20.h),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  TextApp(
                                    text: ZnoonaTexts.tr(
                                      context,
                                      LangKeys.volume,
                                    ),
                                    textStyle: TextStyle(
                                      fontSize: 14.sp,
                                      color: ZnoonaColors.text(
                                        context,
                                      ).withOpacity(0.7),
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 8.w,
                                      vertical: 4.h,
                                    ),
                                    decoration: BoxDecoration(
                                      color: ZnoonaColors.bluePinkLight(
                                        context,
                                      ).withOpacity(0.1),
                                      borderRadius: BorderRadius.circular(8.r),
                                    ),
                                    child: TextApp(
                                      text:
                                          '${(state.soundVolume * 100).toInt()}%',
                                      textStyle: TextStyle(
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w600,
                                        color: ZnoonaColors.text(
                                          context,
                                        ).withAlpha(200),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 8.h),
                              SliderTheme(
                                data: SliderThemeData(
                                  trackHeight: 4.h,
                                  thumbShape: RoundSliderThumbShape(
                                    enabledThumbRadius: 10.r,
                                  ),
                                  overlayShape: RoundSliderOverlayShape(
                                    overlayRadius: 18.r,
                                  ),
                                ),
                                child: Slider(
                                  value: state.soundVolume,
                                  onChanged: cubit.setSoundVolume,
                                  onChangeEnd: (value) {
                                    audioService.playTestSound();
                                  },
                                  min: 0.0,
                                  max: 1.0,
                                  divisions: 10,
                                  activeColor: ZnoonaColors.bluePinkLight(
                                    context,
                                  ),
                                  inactiveColor: ZnoonaColors.containerLinear1(
                                    context,
                                  ),
                                ),
                              ),
                            ],
                          ],
                        ),
                      ),
                    ),

                    SizedBox(height: 20.h),

                    // Background Music Section
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.w),
                      child: const CustomSectionTitle(
                        langkey: LangKeys.backgroundMusic,
                      ),
                    ),
                    SizedBox(height: 10.h),

                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 10.w),
                      decoration: BoxDecoration(
                        color: ZnoonaColors.main(context),
                        borderRadius: BorderRadius.circular(16.r),
                        border: Border.all(
                          color: ZnoonaColors.textFormBorder(context),
                          width: 1.w,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: ZnoonaColors.bluePinkDark(
                              context,
                            ).withAlpha(200),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(16.w),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Container(
                                  padding: EdgeInsets.all(8.w),
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: [
                                        ZnoonaColors.bluePinkDark(context),
                                        ZnoonaColors.bluePinkLight(context),
                                      ],
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                    ),
                                    borderRadius: BorderRadius.circular(12.r),
                                  ),
                                  child: Icon(
                                    Icons.music_note,
                                    color: Colors.white,
                                    size: 20.sp,
                                  ),
                                ),
                                SizedBox(width: 12.w),
                                Expanded(
                                  child: TextApp(
                                    text: ZnoonaTexts.tr(
                                      context,
                                      LangKeys.backgroundMusic,
                                    ),
                                    textStyle: TextStyle(
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w500,
                                      color: ZnoonaColors.text(context),
                                    ),
                                  ),
                                ),
                                Switch(
                                  value: state.isBackgroundMusicEnabled,
                                  onChanged: (_) =>
                                      cubit.toggleBackgroundMusic(),
                                  activeThumbColor: ZnoonaColors.bluePinkLight(
                                    context,
                                  ),
                                  activeTrackColor:
                                      ZnoonaColors.containerLinear1(
                                        context,
                                      ),
                                ),
                              ],
                            ),
                            if (state.isBackgroundMusicEnabled) ...[
                              SizedBox(height: 20.h),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  TextApp(
                                    text: ZnoonaTexts.tr(
                                      context,
                                      LangKeys.volume,
                                    ),
                                    textStyle: TextStyle(
                                      fontSize: 14.sp,
                                      color: ZnoonaColors.text(
                                        context,
                                      ).withOpacity(0.7),
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 8.w,
                                      vertical: 4.h,
                                    ),
                                    decoration: BoxDecoration(
                                      color: ZnoonaColors.bluePinkLight(
                                        context,
                                      ).withOpacity(0.1),
                                      borderRadius: BorderRadius.circular(8.r),
                                    ),
                                    child: TextApp(
                                      text:
                                          '${(state.musicVolume * 100).toInt()}%',
                                      textStyle: TextStyle(
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w600,
                                        color: ZnoonaColors.text(
                                          context,
                                        ).withAlpha(200),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 8.h),
                              SliderTheme(
                                data: SliderThemeData(
                                  trackHeight: 4.h,
                                  thumbShape: RoundSliderThumbShape(
                                    enabledThumbRadius: 10.r,
                                  ),
                                  overlayShape: RoundSliderOverlayShape(
                                    overlayRadius: 18.r,
                                  ),
                                ),
                                child: Slider(
                                  value: state.musicVolume,
                                  onChanged: cubit.setMusicVolume,
                                  min: 0.0,
                                  max: 1.0,
                                  divisions: 10,
                                  activeColor: ZnoonaColors.bluePinkLight(
                                    context,
                                  ),
                                  inactiveColor: ZnoonaColors.containerLinear1(
                                    context,
                                  ),
                                ),
                              ),
                            ],
                          ],
                        ),
                      ),
                    ),

                    SizedBox(height: 30.h),

                    // Test Sound Button
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.w),
                      child: Container(
                        width: double.infinity,
                        height: 50.h,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              ZnoonaColors.bluePinkDark(context),
                              ZnoonaColors.bluePinkLight(context),
                            ],
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                          ),
                          borderRadius: BorderRadius.circular(12.r),
                          boxShadow: [
                            BoxShadow(
                              color: ZnoonaColors.bluePinkDark(
                                context,
                              ).withOpacity(0.3),
                              blurRadius: 8,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: () {
                              audioService.playTestSound();
                            },
                            borderRadius: BorderRadius.circular(12.r),
                            child: Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    padding: EdgeInsets.all(4.w),
                                    decoration: BoxDecoration(
                                      color: Colors.white.withOpacity(0.2),
                                      shape: BoxShape.circle,
                                    ),
                                    child: Icon(
                                      Icons.volume_up,
                                      color: Colors.white,
                                      size: 18.sp,
                                    ),
                                  ),
                                  SizedBox(width: 8.w),
                                  TextApp(
                                    text: ZnoonaTexts.tr(
                                      context,
                                      LangKeys.testSound,
                                    ),
                                    textStyle: TextStyle(
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),

                    SizedBox(height: 20.h),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
