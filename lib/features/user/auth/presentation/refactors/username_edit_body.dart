import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:znoona_game_app/core/common/widgets/custom_app_bar.dart';
import 'package:znoona_game_app/core/common/widgets/custom_linear_button.dart';
import 'package:znoona_game_app/core/common/widgets/text_app.dart';
import 'package:znoona_game_app/core/helpers/znoona.colors.dart';
import 'package:znoona_game_app/core/helpers/znoona_texts.dart';
import 'package:znoona_game_app/core/language/lang_keys.dart';
import 'package:znoona_game_app/features/user/auth/presentation/cubit/auth_cubit.dart';

class UsernameEditBody extends StatefulWidget {
  const UsernameEditBody({super.key});

  @override
  State<UsernameEditBody> createState() => _UsernameEditBodyState();
}

class _UsernameEditBodyState extends State<UsernameEditBody> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  bool _isLoading = false;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();

    final profile = context.read<AuthCubit>().state.whenOrNull(
      authenticated: (profile, authMethod) => profile,
    );

    if (profile != null) {
      _usernameController.text = profile.username ?? '';
    }
  }

  @override
  void dispose() {
    _usernameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(16.w),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomAppBar(
                title: ZnoonaTexts.tr(context, LangKeys.editUsername),
              ),
              // Instructions
              TextApp(
                text: ZnoonaTexts.tr(context, LangKeys.usernameHint),
                textStyle: TextStyle(
                  fontSize: 14.sp,
                  color: ZnoonaColors.text(context)?.withOpacity(0.7),
                ),
              ),
              SizedBox(height: 20.h),

              // Username Input
              TextFormField(
                controller: _usernameController,
                autofocus: true,
                decoration: InputDecoration(
                  labelText: ZnoonaTexts.tr(context, LangKeys.username),
                  prefixText: '@',
                  prefixStyle: TextStyle(
                    color: ZnoonaColors.text(context),
                    fontWeight: FontWeight.bold,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  filled: true,
                  fillColor: ZnoonaColors.main(context)?.withOpacity(0.5),
                  errorText: _errorMessage,
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return ZnoonaTexts.tr(context, LangKeys.usernameRequired);
                  }
                  if (value.length < 3) {
                    return ZnoonaTexts.tr(context, LangKeys.usernameTooShort);
                  }
                  if (value.length > 12) {
                    return ZnoonaTexts.tr(context, LangKeys.usernameTooLong);
                  }
                  if (!RegExp(r'^[a-zA-Z0-9_]+$').hasMatch(value)) {
                    return ZnoonaTexts.tr(
                      context,
                      LangKeys.usernameInvalidChars,
                    );
                  }
                  return null;
                },
              ),
              SizedBox(height: 10.h),

              // Character Counter
              Align(
                alignment: Alignment.centerRight,
                child: Text(
                  '${_usernameController.text.length}/12',
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: _usernameController.text.length > 12
                        ? Colors.red
                        : ZnoonaColors.text(context)?.withOpacity(0.6),
                  ),
                ),
              ),

              SizedBox(height: 20.h),

              // Requirements List
              _buildRequirement(
                ZnoonaTexts.tr(context, LangKeys.usernameRequirement1),
                valid: _usernameController.text.length >= 3,
              ),
              _buildRequirement(
                ZnoonaTexts.tr(context, LangKeys.usernameRequirement2),
                valid: _usernameController.text.length <= 12,
              ),
              _buildRequirement(
                ZnoonaTexts.tr(context, LangKeys.usernameRequirement3),
                valid: RegExp(
                  r'^[a-zA-Z0-9_]+$',
                ).hasMatch(_usernameController.text),
              ),

              Spacer(),

              // Save Button
              if (_isLoading)
                Center(
                  child: CircularProgressIndicator(
                    color: ZnoonaColors.main(context),
                  ),
                )
              else
                CustomLinearButton(
                  height: 50.h,
                  width: double.infinity,
                  onPressed: _saveUsername,
                  child: Text(
                    ZnoonaTexts.tr(context, LangKeys.saveChanges),
                    style: GoogleFonts.beiruti(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRequirement(String text, {required bool valid}) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8.h),
      child: Row(
        children: [
          Icon(
            valid ? Icons.check_circle : Icons.circle,
            size: 16.sp,
            color: valid ? Colors.green : Colors.grey,
          ),
          SizedBox(width: 8.w),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                fontSize: 12.sp,
                color: ZnoonaColors.text(context)?.withOpacity(0.7),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _saveUsername() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final authCubit = context.read<AuthCubit>();
      await authCubit.updateProfile(username: _usernameController.text.trim());

      // Show success message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            ZnoonaTexts.tr(context, LangKeys.usernameUpdated),
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.green,
        ),
      );

      // Navigate back after short delay
      await Future.delayed(Duration(milliseconds: 500));
      Navigator.pop(context);
    } on Exception catch (e) {
      setState(() {
        _errorMessage = e.toString().replaceFirst('Exception: ', '');
        _isLoading = false;
      });
    }
  }
}
