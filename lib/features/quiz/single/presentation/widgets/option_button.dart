import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:znoona_game_app/core/helpers/znoona.colors.dart';

class OptionButton extends StatefulWidget {
  const OptionButton({
    required this.option,
    required this.isSelected,
    required this.isCorrect,
    required this.selectedAnswer,
    required this.onTap,
    required this.remainingTime,
    super.key,
  });

  final String option;
  final bool isSelected;
  final bool isCorrect;
  final String? selectedAnswer;
  final VoidCallback? onTap;
  final int remainingTime;

  @override
  State<OptionButton> createState() => _OptionButtonState();
}

class _OptionButtonState extends State<OptionButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _offsetAnimation;
  bool hasShaken = false;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 350),
    );

    _offsetAnimation = TweenSequence<double>([
      TweenSequenceItem(tween: Tween(begin: 0, end: -8), weight: 1),
      TweenSequenceItem(tween: Tween(begin: -8, end: 8), weight: 1),
      TweenSequenceItem(tween: Tween(begin: 8, end: -8), weight: 1),
      TweenSequenceItem(tween: Tween(begin: -8, end: 0), weight: 1),
      TweenSequenceItem(tween: Tween(begin: 8, end: -8), weight: 1),
      TweenSequenceItem(tween: Tween(begin: -8, end: 0), weight: 1),
    ]).animate(CurvedAnimation(parent: _controller, curve: Curves.easeIn));
  }

  @override
  void didUpdateWidget(covariant OptionButton oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.selectedAnswer == null && hasShaken) {
      hasShaken = false;
    }

    if (widget.selectedAnswer != null &&
        widget.isSelected &&
        !widget.isCorrect &&
        !hasShaken) {
      hasShaken = true;
      _controller.forward(from: 0);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Color color;
    if (widget.selectedAnswer != null || widget.remainingTime == 0) {
      if (widget.isCorrect) {
        color = Colors.green;
      } else if (widget.isSelected && !widget.isCorrect) {
        color = Colors.red;
      } else {
        color = ZnoonaColors.bluePinkDark(context);
      }
    } else {
      color = ZnoonaColors.bluePinkDark(context);
    }

    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(_offsetAnimation.value, 0),
          child: child,
        );
      },
      child: GestureDetector(
        onTap: widget.selectedAnswer == null ? widget.onTap : null,
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 8),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            widget.option,
            style: GoogleFonts.beiruti(
              fontSize: 22.sp,
              fontWeight: FontWeight.w800,
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
