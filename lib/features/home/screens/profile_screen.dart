import 'package:flutter/material.dart';
import 'package:medaan_almaarifa/features/home/refactors/profile_body.dart';
import 'package:medaan_almaarifa/features/user/auth/domain/entities/profile.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({required this.profile, super.key});

  final Profile profile;

  @override
  Widget build(BuildContext context) {
    return  ProfileBody(profile: profile);
  }
}
