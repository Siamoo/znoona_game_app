import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medaan_almaarifa/core/app/app_cubit/app_cubit.dart';
import 'package:medaan_almaarifa/core/common/widgets/debounced_slider.dart';
import 'package:medaan_almaarifa/core/common/widgets/text_app.dart';
import 'package:medaan_almaarifa/core/di/injection_container.dart';
import 'package:medaan_almaarifa/core/service/audio/audio_service.dart';
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
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 10.w,
              vertical: 10.h,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildAppBar(context),
                SizedBox(height: 20.h),
                const _SoundEffectsSection(),
                SizedBox(height: 20.h),
                const _BackgroundMusicSection(),
                SizedBox(height: 20.h),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      child: Row(
        children: [
          IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(
              Icons.arrow_back_ios,
              color: ZnoonaColors.text(context),
              size: 20.h,
            ),
          ),
          SizedBox(width: 8.w),
          TextApp(
            text: ZnoonaTexts.tr(context, LangKeys.soundSettings),
            textStyle: TextStyle(
              fontSize: 20.h,
              fontWeight: FontWeight.bold,
              color: ZnoonaColors.text(context),
            ),
          ),
        ],
      ),
    );
  }
}

class _SoundEffectsSection extends StatelessWidget {
  const _SoundEffectsSection();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.w),
          child: const CustomSectionTitle(langkey: LangKeys.soundEffects),
        ),
        SizedBox(height: 10.h),
        BlocBuilder<AppCubit, AppState>(
          buildWhen: (previous, current) =>
              previous.isSoundEnabled != current.isSoundEnabled ||
              previous.soundVolume != current.soundVolume,
          builder: (context, state) {
            final cubit = context.read<AppCubit>();
            return _SoundEffectsCard(
              isEnabled: state.isSoundEnabled,
              volume: state.soundVolume,
              onToggle: cubit.toggleSound,
              onVolumeChanged: cubit.setSoundVolume,
            );
          },
        ),
      ],
    );
  }
}

class _SoundEffectsCard extends StatelessWidget {
  const _SoundEffectsCard({
    required this.isEnabled,
    required this.volume,
    required this.onToggle,
    required this.onVolumeChanged,
  });

  final bool isEnabled;
  final double volume;
  final Future<void> Function() onToggle;
  final Future<void> Function(double) onVolumeChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
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
            color: ZnoonaColors.bluePinkDark(context).withAlpha(200),
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
            _buildHeader(
              context,
              icon: Icons.volume_up,
              title: LangKeys.soundEffects,
              value: isEnabled,
              onToggle: onToggle,
            ),
            if (isEnabled) ...[
              SizedBox(height: 20.h),
              _buildVolumeControl(
                context,
                volume: volume,
                onChanged: onVolumeChanged,
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(
    BuildContext context, {
    required IconData icon,
    required String title,
    required bool value,
    required Future<void> Function() onToggle,
  }) {
    return Row(
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
          child: Icon(icon, color: Colors.white, size: 20.h),
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: TextApp(
            text: ZnoonaTexts.tr(context, title),
            textStyle: TextStyle(
              fontSize: 16.h,
              fontWeight: FontWeight.w500,
              color: ZnoonaColors.text(context),
            ),
          ),
        ),
        Switch(
          value: value,
          onChanged: (_) => onToggle(),
          activeThumbColor: ZnoonaColors.bluePinkLight(context),
          activeTrackColor: ZnoonaColors.containerLinear1(context),
        ),
      ],
    );
  }

  Widget _buildVolumeControl(
    BuildContext context, {
    required double volume,
    required Future<void> Function(double) onChanged,
  }) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextApp(
              text: ZnoonaTexts.tr(context, LangKeys.volume),
              textStyle: TextStyle(
                fontSize: 14.h,
                color: ZnoonaColors.text(context).withOpacity(0.7),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
              decoration: BoxDecoration(
                color: ZnoonaColors.bluePinkLight(context).withOpacity(0.1),
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: TextApp(
                text: '${(volume * 100).toInt()}%',
                textStyle: TextStyle(
                  fontSize: 14.h,
                  fontWeight: FontWeight.w600,
                  color: ZnoonaColors.text(context),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 8.h),
        SliderTheme(
          data: SliderThemeData(
            trackHeight: 4.h,
            thumbShape: RoundSliderThumbShape(enabledThumbRadius: 10.r),
            overlayShape: RoundSliderOverlayShape(overlayRadius: 18.r),
          ),
          child: DebouncedSlider(
            value: volume,
            onChanged: onChanged,
            onChangedEnd: (value) {
              // Only play sound if sound effects are enabled
              if (context.read<AppCubit>().state.isSoundEnabled) {
                sl<AudioService>().playCorrectSound();
              }
            },
            divisions: 10,
            activeColor: ZnoonaColors.bluePinkLight(context),
            inactiveColor: ZnoonaColors.containerLinear1(context),
            // Removed semanticFormatterCallback completely
          ),
        ),
      ],
    );
  }
}

class _BackgroundMusicSection extends StatelessWidget {
  const _BackgroundMusicSection();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.w),
          child: const CustomSectionTitle(langkey: LangKeys.backgroundMusic),
        ),
        SizedBox(height: 10.h),
        BlocBuilder<AppCubit, AppState>(
          buildWhen: (previous, current) =>
              previous.isBackgroundMusicEnabled !=
                  current.isBackgroundMusicEnabled ||
              previous.musicVolume != current.musicVolume,
          builder: (context, state) {
            final cubit = context.read<AppCubit>();
            return _BackgroundMusicCard(
              isEnabled: state.isBackgroundMusicEnabled,
              volume: state.musicVolume,
              onToggle: cubit.toggleBackgroundMusic,
              onVolumeChanged: cubit.setMusicVolume,
            );
          },
        ),
      ],
    );
  }
}

class _BackgroundMusicCard extends StatelessWidget {
  const _BackgroundMusicCard({
    required this.isEnabled,
    required this.volume,
    required this.onToggle,
    required this.onVolumeChanged,
  });

  final bool isEnabled;
  final double volume;
  final Future<void> Function() onToggle;
  final Future<void> Function(double) onVolumeChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
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
            color: ZnoonaColors.bluePinkDark(context).withAlpha(200),
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
            _buildHeader(
              context,
              icon: Icons.music_note,
              title: LangKeys.backgroundMusic,
              value: isEnabled,
              onToggle: onToggle,
            ),
            if (isEnabled) ...[
              SizedBox(height: 20.h),
              _buildVolumeControl(
                context,
                volume: volume,
                onChanged: onVolumeChanged,
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(
    BuildContext context, {
    required IconData icon,
    required String title,
    required bool value,
    required Future<void> Function() onToggle,
  }) {
    return Row(
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
          child: Icon(icon, color: Colors.white, size: 20.h),
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: TextApp(
            text: ZnoonaTexts.tr(context, title),
            textStyle: TextStyle(
              fontSize: 16.h,
              fontWeight: FontWeight.w500,
              color: ZnoonaColors.text(context),
            ),
          ),
        ),
        Switch(
          value: value,
          onChanged: (_) => onToggle(),
          activeThumbColor: ZnoonaColors.bluePinkLight(context),
          activeTrackColor: ZnoonaColors.containerLinear1(context),
        ),
      ],
    );
  }

  Widget _buildVolumeControl(
    BuildContext context, {
    required double volume,
    required Future<void> Function(double) onChanged,
  }) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextApp(
              text: ZnoonaTexts.tr(context, LangKeys.volume),
              textStyle: TextStyle(
                fontSize: 14.h,
                color: ZnoonaColors.text(context).withOpacity(0.7),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
              decoration: BoxDecoration(
                color: ZnoonaColors.bluePinkLight(context).withOpacity(0.1),
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: TextApp(
                text: '${(volume * 100).toInt()}%',
                textStyle: TextStyle(
                  fontSize: 14.h,
                  fontWeight: FontWeight.w600,
                  color: ZnoonaColors.text(context),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 8.h),
        SliderTheme(
          data: SliderThemeData(
            trackHeight: 4.h,
            thumbShape: RoundSliderThumbShape(enabledThumbRadius: 10.r),
            overlayShape: RoundSliderOverlayShape(overlayRadius: 18.r),
          ),
          child: DebouncedSlider(
            value: volume,
            onChanged: onChanged,
            onChangedEnd: (value) {
              // Optional: You could play a soft sound here if desired
            },
            divisions: 10,
            activeColor: ZnoonaColors.bluePinkLight(context),
            inactiveColor: ZnoonaColors.containerLinear1(context),
            // Removed semanticFormatterCallback completely
          ),
        ),
      ],
    );
  }
}