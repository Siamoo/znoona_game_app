import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:znoona_game_app/core/helpers/znoona.colors.dart';
import 'package:znoona_game_app/core/helpers/znoona_texts.dart';
import 'package:znoona_game_app/core/language/lang_keys.dart';
import 'package:znoona_game_app/features/quiz/room/domain/entities/room.dart';
import 'package:znoona_game_app/features/quiz/room/presentation/cubit/room_cubit.dart';

class RoomInfoCard extends StatelessWidget {
  const RoomInfoCard({required this.room, super.key});
  final Room room;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      color: ZnoonaColors.bluePinkDark(context),
      child: Padding(
        padding: EdgeInsets.all(16.sp),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  ZnoonaTexts.tr(context, LangKeys.roomCode),
                  style: GoogleFonts.beiruti(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Row(
                  children: [
                    InkWell(
                      onTap: () => _showQRCodeDialog(context, room.code),
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Colors.white),
                        ),
                        child: const Icon(
                          Icons.qr_code_2,
                          size: 24,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    SizedBox(width: 8.w),
                    InkWell(
                      onTap: () {
                        Clipboard.setData(ClipboardData(text: room.code));
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              'Room code ${room.code} copied to clipboard',
                              style: GoogleFonts.beiruti(),
                            ),
                            duration: const Duration(seconds: 2),
                          ),
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Colors.white),
                        ),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.copy,
                              size: 16,
                              color: Colors.white,
                            ),
                            SizedBox(width: 6.w),
                            Text(
                              room.code,
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

                    // QR Code Button
                  ],
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  ZnoonaTexts.tr(context, LangKeys.status),
                  style: GoogleFonts.beiruti(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                BlocBuilder<RoomCubit, RoomState>(
                  builder: (context, state) {
                    final currentRoom = _getCurrentRoom(state) ?? room;
                    return Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: _getStatusColor(currentRoom.status),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        ZnoonaTexts.tr(
                          context,
                          currentRoom.status,
                        ).toUpperCase(),
                        style: GoogleFonts.beiruti(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  ZnoonaTexts.tr(context, LangKeys.players),
                  style: GoogleFonts.beiruti(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                BlocBuilder<RoomCubit, RoomState>(
                  builder: (context, state) {
                    final playersCount = state.maybeWhen(
                      playersUpdated: (players) => players.length,
                      orElse: () => 1, // At least the host
                    );
                    return Padding(
                      padding: EdgeInsets.only(left: 35.w),
                      child: Text(
                        '$playersCount/8',
                        style: GoogleFonts.beiruti(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _showQRCodeDialog(BuildContext context, String roomCode) {
    showDialog<dynamic>(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: ZnoonaColors.bluePinkDark(context),
        title: Text(
          'Room QR Code',
          style: GoogleFonts.beiruti(),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Scan this QR code to join the room',
              style: GoogleFonts.beiruti(),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 16.h),
            Container(
              padding: EdgeInsets.all(16.sp),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(12),
              ),
              child: _buildQRCode(roomCode),
            ),
            SizedBox(height: 16.h),
            Text(
              'Room Code: $roomCode',
              style: GoogleFonts.beiruti(
                fontWeight: FontWeight.bold,
                fontSize: 16.sp,
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Close',
              style: GoogleFonts.beiruti(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQRCode(String data) {
    return SizedBox(
      width: 200.w,
      height: 200.h,
      child: QrImageView(
        data: data,
        version: QrVersions.min,
        backgroundColor: Colors.white,
      ),
    );
  }

  Room? _getCurrentRoom(RoomState state) {
    return state.maybeWhen(
      roomUpdated: (room) => room,
      roomLoaded: (room) => room,
      joined: (room) => room,
      orElse: () => null,
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'waiting':
        return Colors.orange;
      case 'playing':
        return Colors.green;
      case 'finished':
        return Colors.blue;
      default:
        return Colors.grey;
    }
  }
}
