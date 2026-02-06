import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medaan_almaarifa/core/common/widgets/custom_app_bar.dart';

class EmptyQuizBody extends StatelessWidget {
  const EmptyQuizBody({
    required this.roomCode,
    super.key,
  });

  final String roomCode;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.w),
        child: Column(
          children: [
            CustomAppBar(title: 'Room $roomCode'),
            SizedBox(height: 300.h),
            const Center(child: Text('No questions found.')),
          ],
        ),
      ),
    );
  }
}
