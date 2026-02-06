import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medaan_almaarifa/core/app/app_cubit/app_cubit.dart';
import 'package:medaan_almaarifa/core/helpers/znoona.colors.dart';
import 'package:medaan_almaarifa/core/helpers/znoona_texts.dart';
import 'package:medaan_almaarifa/core/language/lang_keys.dart';
import 'package:medaan_almaarifa/features/home/widgets/info_card.dart';
import 'package:medaan_almaarifa/features/home/widgets/settings_buttons.dart';
import 'package:medaan_almaarifa/features/home/widgets/stat_card.dart';
import 'package:medaan_almaarifa/features/user/auth/domain/entities/profile.dart';

class ProfileBody extends StatelessWidget {
  const ProfileBody({required this.profile, super.key});

  final Profile profile;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: ZnoonaColors.main(context),
      body: SafeArea(
        child: BlocBuilder<AppCubit, AppState>(
          builder: (context, state) {
            return CustomScrollView(
              slivers: [
                // Header Section
                SliverToBoxAdapter(
                  child: _buildHeaderSection(context),
                ),

                // Stats Grid Section
                SliverToBoxAdapter(
                  child: _buildStatsSection(context),
                ),

                // Info Grid Section (ADDED)
                SliverToBoxAdapter(
                  child: _buildInfoSection(context),
                ),

                // Settings Section
                SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 16.w,
                      vertical: 24.h,
                    ),
                    child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.all(16.w),
                          decoration: BoxDecoration(
                            color: theme.cardColor,
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: [
                              BoxShadow(
                                color: ZnoonaColors.text(
                                  context,
                                ).withOpacity(0.1),
                                blurRadius: 10,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: const SettingsButtons(),
                        ),
                        SizedBox(height: 20.h),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildHeaderSection(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            ZnoonaColors.main(context),
            ZnoonaColors.bluePinkDark(context),
          ],
        ),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(24.r),
          bottomRight: Radius.circular(24.r),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.only(
          top: 20.h,
          bottom: 30.h,
          left: 16.w,
          right: 16.w,
        ),
        child: Column(
          children: [
            // Custom App Bar
            Row(
              children: [
                IconButton(
                  icon: Icon(
                    Icons.arrow_back,
                    color: ZnoonaColors.text(context),
                    size: 24.h,
                  ),
                  onPressed: () => Navigator.pop(context),
                ),
                Expanded(
                  child: Center(
                    child: Text(
                      ZnoonaTexts.tr(context, LangKeys.profile),
                      style: GoogleFonts.beiruti(
                        fontSize: 22.h,
                        fontWeight: FontWeight.bold,
                        color: ZnoonaColors.text(context),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 48.w), // For balance
              ],
            ),

            SizedBox(height: 20.h),

            // Profile Card
            Container(
              padding: EdgeInsets.all(30.w),
              decoration: BoxDecoration(
                color: theme.cardColor,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.15),
                    blurRadius: 15,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: Column(
                children: [
                  // Avatar with Streak
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        width: 140.w,
                        height: 140.h,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: LinearGradient(
                            colors: [
                              ZnoonaColors.main(context),
                              ZnoonaColors.bluePinkDark(context),
                            ],
                          ),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(4.w),
                          child: Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: theme.cardColor,
                            ),
                            child: ClipOval(
                              child:
                                  profile.avatarUrl != null &&
                                      profile.avatarUrl!.isNotEmpty
                                  ? CachedNetworkImage(
                                      imageUrl: profile.avatarUrl!,
                                      fit: BoxFit.cover,
                                      errorWidget: (context, url, error) =>
                                          Icon(
                                            Icons.person,
                                            size: 40.h,
                                            color: ZnoonaColors.text(context),
                                          ),
                                    )
                                  : Icon(
                                      Icons.person,
                                      size: 40.h,
                                      color: ZnoonaColors.text(context),
                                    ),
                            ),
                          ),
                        ),
                      ),

                      // Streak Badge
                      if (profile.streakDays > 0)
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 8.w,
                              vertical: 4.h,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.orange,
                              borderRadius: BorderRadius.circular(12),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.orange.withOpacity(0.3),
                                  blurRadius: 8,
                                  spreadRadius: 2,
                                ),
                              ],
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  '${profile.streakDays}',
                                  style: GoogleFonts.beiruti(
                                    fontSize: 12.h,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                SizedBox(width: 4.w),
                                Icon(
                                  Icons.local_fire_department,
                                  size: 14.h,
                                  color: Colors.white,
                                ),
                              ],
                            ),
                          ),
                        ),
                    ],
                  ),

                  SizedBox(height: 16.h),

                  // Username
                  if (profile.username != null && profile.username!.isNotEmpty)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '@${profile.username}',
                          style: GoogleFonts.beiruti(
                            fontSize: 16.h,
                            fontWeight: FontWeight.w600,
                            color: ZnoonaColors.bluePinkDark(context),
                          ),
                        ),
                      ],
                    ),

                  // Full Name
                  Text(
                    profile.fullName,
                    style: GoogleFonts.beiruti(
                      fontSize: 24.h,
                      fontWeight: FontWeight.bold,
                      color: ZnoonaColors.bluePinkDark(context),
                    ),
                    textAlign: TextAlign.center,
                  ),

                  SizedBox(height: 8.h),

                  // Level Badge
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 16.w,
                      vertical: 6.h,
                    ),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.blue.shade400,
                          Colors.blue.shade600,
                        ],
                      ),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      '${ZnoonaTexts.tr(context, LangKeys.level)}  ${profile.level}',
                      style: GoogleFonts.beiruti(
                        fontSize: 14.h,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatsSection(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 24.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            ZnoonaTexts.tr(context, LangKeys.statistics),
            style: GoogleFonts.beiruti(
              fontSize: 20.h,
              fontWeight: FontWeight.bold,
              color: ZnoonaColors.text(context),
            ),
          ),
          SizedBox(height: 16.h),
          GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 3,
            childAspectRatio: .95,
            crossAxisSpacing: 8.w,
            mainAxisSpacing: 8.h,
            children: [
              StatCard(
                title: ZnoonaTexts.tr(context, LangKeys.totalCups),
                value: '${profile.allCups}',
                icon: Icons.emoji_events,
                color: Colors.teal,
              ),
              StatCard(
                title: ZnoonaTexts.tr(context, LangKeys.monthlyCups),
                value: '${profile.cupsByMonth}',
                icon: Icons.calendar_month,
                color: Colors.teal,
              ),
              StatCard(
                title: ZnoonaTexts.tr(context, LangKeys.gamesPlayed),
                value: '${profile.gamesPlayed}',
                icon: Icons.sports_esports,
                color: Colors.teal,
              ),
              StatCard(
                title: ZnoonaTexts.tr(context, LangKeys.winRate),
                value: '${profile.winRate.toStringAsFixed(1)}%',
                icon: Icons.trending_up,
                color: Colors.teal,
              ),
              StatCard(
                title: ZnoonaTexts.tr(context, LangKeys.averageScore),
                value: '${profile.averageScore.toStringAsFixed(0)}',
                icon: Icons.score,
                color: Colors.teal,
              ),
              StatCard(
                title: ZnoonaTexts.tr(context, LangKeys.gamesWon),
                value: '${profile.gamesWon}',
                icon: Icons.verified,
                color: Colors.teal,
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ADDED: Info Section
  Widget _buildInfoSection(BuildContext context) {
    final infoItems = <Map<String, dynamic>>[];

    // Add last played if available
    if (profile.lastPlayed != null) {
      infoItems.add({
        'title': ZnoonaTexts.tr(context, LangKeys.lastPlayed),
        'value': _formatDateTime(profile.lastPlayed!),
        'icon': Icons.access_time,
        'color': ZnoonaColors.bluePinkLight(context),
      });
    }

    // Add monthly reset if available
    if (profile.lastMonthReset != null) {
      infoItems.add({
        'title': ZnoonaTexts.tr(context, LangKeys.monthlyReset),
        'value': _formatDateTime(profile.lastMonthReset!),
        'icon': Icons.calendar_today,
        'color': ZnoonaColors.bluePinkLight(context),
      });
    }

    // If no info items, return empty container
    if (infoItems.isEmpty) {
      return const SizedBox.shrink();
    }

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 24.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            ZnoonaTexts.tr(context, LangKeys.playerInfo),
            style: GoogleFonts.beiruti(
              fontSize: 20.h,
              fontWeight: FontWeight.bold,
              color: ZnoonaColors.text(context),
            ),
          ),
          SizedBox(height: 16.h),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: infoItems.length <= 2 ? 2 : 3,
              childAspectRatio: 1.5,
              crossAxisSpacing: 8.w,
              mainAxisSpacing: 8.h,
            ),
            itemCount: infoItems.length,
            itemBuilder: (context, index) {
              final item = infoItems[index];
              return InfoCard(
                title: item['title'] as String,
                value: item['value'] as String,
                icon: item['icon'] as IconData,
                color: item['color'] as Color,
              );
            },
          ),
        ],
      ),
    );
  }

  String _formatDateTime(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inDays == 0) {
      return 'Today';
    } else if (difference.inDays == 1) {
      return 'Yesterday';
    } else if (difference.inDays < 7) {
      return '${difference.inDays}d ago';
    } else {
      return '${date.day}/${date.month}';
    }
  }
}
