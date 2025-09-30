import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:znoona_game_app/core/common/widgets/text_app.dart';
import 'package:znoona_game_app/core/helpers/znoona.colors.dart';
import 'package:znoona_game_app/core/helpers/znoona_navigate.dart';
import 'package:znoona_game_app/core/helpers/znoona_texts.dart';
import 'package:znoona_game_app/core/language/lang_keys.dart';
import 'package:znoona_game_app/features/user/auth/domain/entities/profile.dart';
import 'package:znoona_game_app/features/user/auth/presentation/screens/login_screen.dart';

class HomeBody extends StatelessWidget {
  const HomeBody({
    required this.profile,
    super.key,
  });
  final Profile profile;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 10,
          ),
          child: Column(
            children: [
              Row(
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 20,
                        backgroundImage: NetworkImage(profile.avatarUrl!),
                        backgroundColor: Colors.transparent,
                      ),
                      SizedBox(width: 10.w),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextApp(
                            text: ZnoonaTexts.tr(context, LangKeys.hello),
                            textStyle: GoogleFonts.beiruti(
                              fontSize: 20.sp,
                              fontWeight: FontWeight.w400,
                              color: ZnoonaColors.text(context).withAlpha(100),
                            ),
                            textAlign: TextAlign.center,
                          ),
                          TextApp(
                            text: profile.fullName,
                            textStyle: GoogleFonts.beiruti(
                              fontSize: 20.sp,
                              fontWeight: FontWeight.w400,
                              color: ZnoonaColors.text(context),
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ],
                  ),
                  const Spacer(),
                  Icon(
                    Icons.control_point_sharp,
                  ),
                ],
              ),
              const Spacer(),

              ElevatedButton(
                onPressed: () async {
                  await Supabase.instance.client.auth.signOut();
                  ZnoonaNavigate.pushReplacementTo(
                    context,
                    const LoginScreen(),
                  );
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 60),
                ),
                child: const Text('Logout'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
