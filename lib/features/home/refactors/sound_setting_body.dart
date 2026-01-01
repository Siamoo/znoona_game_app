import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medaan_almaarifa/core/app/app_cubit/app_cubit.dart';
import 'package:medaan_almaarifa/core/common/widgets/custom_app_bar.dart';
import 'package:medaan_almaarifa/core/common/widgets/text_app.dart';
import 'package:medaan_almaarifa/core/di/injcetion_container.dart';
import 'package:medaan_almaarifa/core/helpers/audio_service.dart';
import 'package:medaan_almaarifa/core/helpers/znoona.colors.dart';
import 'package:medaan_almaarifa/core/helpers/znoona_texts.dart';
import 'package:medaan_almaarifa/core/language/lang_keys.dart';

class SoundSettingsScreen extends StatelessWidget {
  const SoundSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: BlocBuilder<AppCubit, AppState>(
            builder: (context, state) {
              final cubit = context.read<AppCubit>();
              final audioService = sl<AudioService>();
              
              return Column(
                children: [
                  CustomAppBar(
                    title: ZnoonaTexts.tr(context, LangKeys.soundSettings),
                  ),
                  SizedBox(height: 30.h),
                  
                  // Sound Effects
                  Card(
                    child: Padding(
                      padding: EdgeInsets.all(16.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.volume_up,
                                color: ZnoonaColors.text(context),
                              ),
                              SizedBox(width: 16.w),
                              Expanded(
                                child: TextApp(
                                  text: ZnoonaTexts.tr(context, LangKeys.soundEffects),
                                  textStyle: TextStyle(
                                    fontSize: 16.sp,
                                    color: ZnoonaColors.text(context),
                                  ),
                                ),
                              ),
                              Switch(
                                value: state.isSoundEnabled,
                                onChanged: (_) => cubit.toggleSound(),
                                activeColor: ZnoonaColors.main(context),
                              ),
                            ],
                          ),
                          if (state.isSoundEnabled) ...[
                            SizedBox(height: 16.h),
                            TextApp(
                              text: ZnoonaTexts.tr(context, LangKeys.volume),
                              textStyle: TextStyle(
                                fontSize: 14.sp,
                                color: ZnoonaColors.text(context).withOpacity(0.7),
                              ),
                            ),
                            SizedBox(height: 8.h),
                            Slider(
                              value: state.soundVolume,
                              onChanged: cubit.setSoundVolume,
                              min: 0.0,
                              max: 1.0,
                              divisions: 10,
                              activeColor: ZnoonaColors.main(context),
                              onChangeEnd: (value) {
                                // Test sound when slider is released
                                audioService.playTestSound();
                              },
                            ),
                          ],
                        ],
                      ),
                    ),
                  ),
                  
                  SizedBox(height: 20.h),
                  
                  // Background Music
                  Card(
                    child: Padding(
                      padding: EdgeInsets.all(16.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.music_note,
                                color: ZnoonaColors.text(context),
                              ),
                              SizedBox(width: 16.w),
                              Expanded(
                                child: TextApp(
                                  text: ZnoonaTexts.tr(context, LangKeys.backgroundMusic),
                                  textStyle: TextStyle(
                                    fontSize: 16.sp,
                                    color: ZnoonaColors.text(context),
                                  ),
                                ),
                              ),
                              Switch(
                                value: state.isBackgroundMusicEnabled,
                                onChanged: (_) => cubit.toggleBackgroundMusic(),
                                activeColor: ZnoonaColors.main(context),
                              ),
                            ],
                          ),
                          if (state.isBackgroundMusicEnabled) ...[
                            SizedBox(height: 16.h),
                            TextApp(
                              text: ZnoonaTexts.tr(context, LangKeys.volume),
                              textStyle: TextStyle(
                                fontSize: 14.sp,
                                color: ZnoonaColors.text(context).withOpacity(0.7),
                              ),
                            ),
                            SizedBox(height: 8.h),
                            Slider(
                              value: state.musicVolume,
                              onChanged: cubit.setMusicVolume,
                              min: 0.0,
                              max: 1.0,
                              divisions: 10,
                              activeColor: ZnoonaColors.main(context),
                            ),
                          ],
                        ],
                      ),
                    ),
                  ),
                  
                  SizedBox(height: 30.h),
                  
                  // Test Sounds Button
                  ElevatedButton(
                    onPressed: () {
                      audioService.playTestSound();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: ZnoonaColors.main(context),
                      minimumSize: Size(double.infinity, 50.h),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                    ),
                    child: TextApp(
                      text: ZnoonaTexts.tr(context, LangKeys.testSound),
                      textStyle: TextStyle(
                        fontSize: 16.sp,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}