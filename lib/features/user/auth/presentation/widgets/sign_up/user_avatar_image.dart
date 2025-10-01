import 'package:flutter/material.dart';
import 'package:znoona_game_app/core/common/animations/animate_do.dart';
import 'package:znoona_game_app/core/style/images/app_images.dart';

class UserAvatarImage extends StatelessWidget {
  const UserAvatarImage({super.key});

  @override
  Widget build(BuildContext context) {
    return const CustomFadeInDown(
      duration: 500,
      child: CircleAvatar(
        radius: 38,
        backgroundImage: AssetImage(AppImages.userAvatar),
        backgroundColor: Colors.transparent,
      ),
    );
  }
}
