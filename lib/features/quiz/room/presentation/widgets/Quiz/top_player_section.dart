
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medaan_almaarifa/core/helpers/znoona.colors.dart';
import 'package:medaan_almaarifa/features/quiz/room/domain/entities/room_player.dart';

class TopPlayerSection extends StatelessWidget {
  const TopPlayerSection({
    required this.context,
    required this.topPlayer,
    required this.isCurrentUser,
    super.key,
  });

  final BuildContext context;
  final RoomPlayer topPlayer;
  final bool isCurrentUser;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(12.sp),
      decoration: BoxDecoration(
        color: ZnoonaColors.bluePinkLight(context).withOpacity(0.1),
        borderRadius: BorderRadius.circular(12.sp),
        border: Border.all(
          color: ZnoonaColors.bluePinkLight(context).withOpacity(0.3),
          width: 1.sp,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Top Player Info
          Row(
            children: [
              // Crown Icon
              Icon(
                Icons.emoji_events,
                color: Colors.amber,
                size: 24.sp,
              ),
              SizedBox(width: 8.sp),

              // Avatar
              Container(
                width: 40.sp,
                height: 40.sp,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: ZnoonaColors.bluePinkLight(context),
                    width: 2.sp,
                  ),
                ),
                child: ClipOval(
                  child:
                      topPlayer.avatarUrl != null &&
                          topPlayer.avatarUrl!.isNotEmpty
                      ? Image.network(
                          topPlayer.avatarUrl!,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Icon(
                              Icons.person,
                              size: 20.sp,
                              color: ZnoonaColors.bluePinkLight(context),
                            );
                          },
                        )
                      : Icon(
                          Icons.person,
                          size: 20.sp,
                          color: ZnoonaColors.bluePinkLight(context),
                        ),
                ),
              ),
              SizedBox(width: 12.sp),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '🎯 Top Player',
                    style: GoogleFonts.beiruti(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.bold,
                      color: ZnoonaColors.bluePinkLight(context),
                    ),
                  ),
                  Text(
                    isCurrentUser ? 'You!' : topPlayer.username,
                    style: GoogleFonts.beiruti(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.bold,
                      color: ZnoonaColors.text(context),
                    ),
                  ),
                ],
              ),
            ],
          ),

          // Score
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12.sp, vertical: 6.sp),
            decoration: BoxDecoration(
              color: ZnoonaColors.bluePinkLight(context),
              borderRadius: BorderRadius.circular(20.sp),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.star,
                  color: Colors.white,
                  size: 16.sp,
                ),
                SizedBox(width: 4.sp),
                Text(
                  '${topPlayer.score}',
                  style: GoogleFonts.beiruti(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
