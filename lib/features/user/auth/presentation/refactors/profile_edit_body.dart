import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:medaan_almaarifa/core/common/widgets/custom_app_bar.dart';
import 'package:medaan_almaarifa/core/common/widgets/custom_linear_button.dart';
import 'package:medaan_almaarifa/core/common/widgets/text_app.dart';
import 'package:medaan_almaarifa/core/helpers/znoona.colors.dart';
import 'package:medaan_almaarifa/core/helpers/znoona_texts.dart';
import 'package:medaan_almaarifa/core/language/lang_keys.dart';
import 'package:medaan_almaarifa/features/user/auth/domain/entities/profile.dart';
import 'package:medaan_almaarifa/features/user/auth/presentation/cubit/auth_cubit.dart';

class ProfileEditBody extends StatefulWidget {
  const ProfileEditBody({super.key});

  @override
  State<ProfileEditBody> createState() => _ProfileEditBodyState();
}

class _ProfileEditBodyState extends State<ProfileEditBody> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _fullNameController = TextEditingController();
  final ImagePicker _picker = ImagePicker();

  File? _selectedImage;
  bool _isLoading = false;
  bool _isUploadingImage = false;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();

    final profile = context.read<AuthCubit>().state.whenOrNull(
      authenticated: (profile, authMethod) => profile,
    );

    if (profile != null) {
      _usernameController.text = profile.username ?? '';
      _fullNameController.text = profile.fullName;
    }
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _fullNameController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    final result = await showModalBottomSheet<ImageSource?>(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Container(
          decoration: BoxDecoration(
            color: ZnoonaColors.main(context),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.r),
              topRight: Radius.circular(20.r),
            ),
          ),
          padding: EdgeInsets.all(20.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                ZnoonaTexts.tr(context, LangKeys.chooseImageSource),
                style: GoogleFonts.beiruti(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                  color: ZnoonaColors.text(context),
                ),
              ),
              SizedBox(height: 20.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildImageSourceButton(
                    icon: Icons.camera_alt,
                    label: ZnoonaTexts.tr(context, LangKeys.camera),
                    source: ImageSource.camera,
                  ),
                  _buildImageSourceButton(
                    icon: Icons.photo_library,
                    label: ZnoonaTexts.tr(context, LangKeys.gallery),
                    source: ImageSource.gallery,
                  ),
                ],
              ),
              SizedBox(height: 10.h),
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text(
                  ZnoonaTexts.tr(context, LangKeys.cancel),
                  style: TextStyle(
                    fontSize: 16.sp,
                    color: ZnoonaColors.bluePinkDark(context),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );

    if (result != null) {
      try {
        final XFile? pickedFile = await _picker.pickImage(
          source: result,
          maxWidth: 800,
          maxHeight: 800,
          imageQuality: 85,
        );

        if (pickedFile != null) {
          setState(() {
            _selectedImage = File(pickedFile.path);
          });
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Failed to pick image: ${e.toString()}',
              style: TextStyle(color: Colors.white),
            ),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  Widget _buildImageSourceButton({
    required IconData icon,
    required String label,
    required ImageSource source,
  }) {
    return Column(
      children: [
        Container(
          width: 70.w,
          height: 70.h,
          decoration: BoxDecoration(
            color: ZnoonaColors.bluePinkLight(context).withOpacity(0.2),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: ZnoonaColors.bluePinkLight(context),
              width: 2,
            ),
          ),
          child: IconButton(
            icon: Icon(
              icon,
              size: 32.sp,
              color: ZnoonaColors.bluePinkLight(context),
            ),
            onPressed: () => Navigator.pop(context, source),
          ),
        ),
        SizedBox(height: 8.h),
        Text(
          label,
          style: TextStyle(
            fontSize: 12.sp,
            color: ZnoonaColors.text(context),
          ),
        ),
      ],
    );
  }

  Widget _buildAvatarSection() {
    final theme = Theme.of(context);
    final profile = context.read<AuthCubit>().state.whenOrNull(
      authenticated: (profile, authMethod) => profile,
    );

    return Column(
      children: [
        SizedBox(height: 20.h),

        // Profile Image Section
        Stack(
          alignment: Alignment.center,
          children: [
            Container(
              width: 150.w,
              height: 150.h,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: ZnoonaColors.text(context),
              ),
              child: Padding(
                padding: EdgeInsets.all(2.w),
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: theme.cardColor,
                  ),
                  child: ClipOval(
                    child: _buildAvatarContent(profile),
                  ),
                ),
              ),
            ),

            // Upload Button
            Positioned(
              bottom: 0,
              right: 0,
              child: GestureDetector(
                onTap: _isUploadingImage ? null : _pickImage,
                child: Container(
                  width: 50.w,
                  height: 50.h,
                  decoration: BoxDecoration(
                    color: ZnoonaColors.bluePinkDark(context),
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.white,
                      width: 2.w,
                    ),
                  ),
                  child: _isUploadingImage
                      ? Padding(
                          padding: EdgeInsets.all(12.w),
                          child: const CircularProgressIndicator(
                            strokeWidth: 3,
                            color: Colors.white,
                          ),
                        )
                      : Icon(
                          Icons.camera_alt,
                          color: Colors.white,
                          size: 24.sp,
                        ),
                ),
              ),
            ),
          ],
        ),

        SizedBox(height: 16.h),

        // Instructions
        Text(
          ZnoonaTexts.tr(context, LangKeys.tapToChangePhoto),
          style: TextStyle(
            fontSize: 14.sp,
            color: ZnoonaColors.text(context).withOpacity(0.7),
          ),
        ),
      ],
    );
  }

  Widget _buildAvatarContent(Profile? profile) {
    if (_isUploadingImage) {
      return Center(
        child: CircularProgressIndicator(
          color: ZnoonaColors.bluePinkDark(context),
        ),
      );
    }

    if (_selectedImage != null) {
      return Image.file(
        _selectedImage!,
        fit: BoxFit.cover,
      );
    }

    if (profile?.avatarUrl != null && profile!.avatarUrl!.isNotEmpty) {
      return Image.network(
        profile.avatarUrl!,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) => _buildDefaultAvatar(),
      );
    }

    return _buildDefaultAvatar();
  }

  Widget _buildDefaultAvatar() {
    return Icon(
      Icons.person,
      size: 60.sp,
      color: ZnoonaColors.bluePinkDark(context).withOpacity(0.5),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
          child: Form(
            key: _formKey,
            child: LayoutBuilder(
              builder: (context, constraints) {
                return SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: constraints.maxHeight,
                    ),
                    child: IntrinsicHeight(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // App Bar
                          CustomAppBar(
                            title: ZnoonaTexts.tr(
                              context,
                              LangKeys.editProfile,
                            ),
                          ),

                          // Profile Image Section
                          Center(child: _buildAvatarSection()),

                          SizedBox(height: 30.h),

                          // Full Name Section
                          TextApp(
                            text: ZnoonaTexts.tr(context, LangKeys.fullName),
                            textStyle: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w600,
                              color: ZnoonaColors.text(context),
                            ),
                          ),
                          SizedBox(height: 8.h),
                          TextFormField(
                            controller: _fullNameController,
                            style: TextStyle(
                              color: ZnoonaColors.text(context),
                            ),
                            decoration: InputDecoration(
                              labelText: ZnoonaTexts.tr(
                                context,
                                LangKeys.fullNameHint,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              filled: true,
                              fillColor: ZnoonaColors.main(
                                context,
                              ).withOpacity(0.5),
                            ),
                            keyboardType: TextInputType.name,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return ZnoonaTexts.tr(
                                  context,
                                  LangKeys.fullNameRequired,
                                );
                              }
                              if (value.length < 3) {
                                return ZnoonaTexts.tr(
                                  context,
                                  LangKeys.fullNameTooShort,
                                );
                              }
                              if (value.length > 25) {
                                return ZnoonaTexts.tr(
                                  context,
                                  LangKeys.fullNameTooLong,
                                );
                              }
                              return null;
                            },
                          ),

                          SizedBox(height: 24.h),

                          // Username Section
                          TextApp(
                            text: ZnoonaTexts.tr(context, LangKeys.username),
                            textStyle: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w600,
                              color: ZnoonaColors.text(context),
                            ),
                          ),
                          TextApp(
                            text: ZnoonaTexts.tr(
                              context,
                              LangKeys.usernameHint,
                            ),
                            textStyle: TextStyle(
                              fontSize: 14.sp,
                              color: ZnoonaColors.text(
                                context,
                              ).withOpacity(0.7),
                            ),
                          ),
                          SizedBox(height: 8.h),

                          // Username Input
                          TextFormField(
                            controller: _usernameController,
                            style: TextStyle(
                              color: ZnoonaColors.text(context),
                            ),
                            decoration: InputDecoration(
                              labelText: ZnoonaTexts.tr(
                                context,
                                LangKeys.username,
                              ),
                              prefixText: '@',
                              prefixStyle: TextStyle(
                                color: ZnoonaColors.text(context),
                                fontWeight: FontWeight.bold,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              filled: true,
                              fillColor: ZnoonaColors.main(
                                context,
                              ).withOpacity(0.5),
                              errorText: _errorMessage,
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return ZnoonaTexts.tr(
                                  context,
                                  LangKeys.usernameRequired,
                                );
                              }
                              if (value.length < 3) {
                                return ZnoonaTexts.tr(
                                  context,
                                  LangKeys.usernameTooShort,
                                );
                              }
                              if (value.length > 12) {
                                return ZnoonaTexts.tr(
                                  context,
                                  LangKeys.usernameTooLong,
                                );
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

                          SizedBox(height: 20.h),

                          // Requirements List
                          _buildRequirement(
                            ZnoonaTexts.tr(
                              context,
                              LangKeys.usernameRequirement1,
                            ),
                            valid: _usernameController.text.length >= 3,
                          ),
                          _buildRequirement(
                            ZnoonaTexts.tr(
                              context,
                              LangKeys.usernameRequirement2,
                            ),
                            valid: _usernameController.text.length <= 12,
                          ),
                          _buildRequirement(
                            ZnoonaTexts.tr(
                              context,
                              LangKeys.usernameRequirement3,
                            ),
                            valid: RegExp(
                              r'^[a-zA-Z0-9_]+$',
                            ).hasMatch(_usernameController.text),
                          ),

                          // Flexible spacer to push button to bottom
                          Expanded(
                            child: SizedBox.shrink(),
                          ),

                          SizedBox(height: 20.h),

                          // Save Button
                          if (_isLoading)
                            Center(
                              child: Padding(
                                padding: EdgeInsets.symmetric(vertical: 20.h),
                                child: CircularProgressIndicator(
                                  color: ZnoonaColors.main(context),
                                ),
                              ),
                            )
                          else
                            CustomLinearButton(
                              height: 50.h,
                              width: double.infinity,
                              onPressed: _saveProfile,
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
              },
            ),
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
                color: ZnoonaColors.text(context).withOpacity(0.7),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<String?> _uploadImageToSupabase(File imageFile) async {
    try {
      // Get current user profile
      final authCubit = context.read<AuthCubit>();
      Profile? currentProfile;

      authCubit.state.whenOrNull(
        authenticated: (profile, authMethod) {
          currentProfile = profile;
        },
      );

      if (currentProfile == null) {
        throw Exception('User not authenticated');
      }

      final userId = currentProfile!.id;

      // Generate unique filename with user folder structure
      final timestamp = DateTime.now().millisecondsSinceEpoch;
      final extension = imageFile.path.split('.').last.toLowerCase();
      final filename = '$userId/${timestamp}_avatar.$extension';

      // Upload to Supabase Storage
      final supabase = Supabase.instance.client;

      // Method 1: Pass the File object directly (simplest)
      await supabase.storage
          .from('avatars')
          .upload(
            filename,
            imageFile, // Pass the File object directly
            fileOptions: FileOptions(
              upsert: true,
              contentType: 'image/$extension',
            ),
          );

      // Get public URL
      final publicUrl = supabase.storage.from('avatars').getPublicUrl(filename);

      print('✅ Image uploaded successfully: $publicUrl');
      return publicUrl;
    } catch (e) {
      print('❌ Image upload error: $e');

      // More specific error messages
      if (e.toString().contains('Bucket not found')) {
        throw Exception(
          'Storage bucket "avatars" not found. Please create it in Supabase Storage.',
        );
      } else if (e.toString().contains('permission denied')) {
        throw Exception('Permission denied. Please check storage policies.');
      } else if (e.toString().contains('404')) {
        throw Exception('Storage service error (404).');
      }

      rethrow;
    }
  }

  Future<void> _saveProfile() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final authCubit = context.read<AuthCubit>();
      String? imageUrl;

      // Upload image if selected
      if (_selectedImage != null) {
        setState(() => _isUploadingImage = true);

        try {
          imageUrl = await _uploadImageToSupabase(_selectedImage!);
        } catch (e) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                'Failed to upload image: ${e.toString()}',
                style: TextStyle(color: Colors.white),
              ),
              backgroundColor: Colors.orange,
            ),
          );
        } finally {
          setState(() => _isUploadingImage = false);
        }
      }

      await authCubit.updateProfile(
        username: _usernameController.text.trim(),
        fullName: _fullNameController.text.trim(),
        avatarUrl:
            imageUrl, // Will be null if no image selected or upload failed
      );

      // Show success message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            ZnoonaTexts.tr(context, LangKeys.profileUpdated),
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.green,
          duration: Duration(seconds: 2),
        ),
      );

      // Navigate back after short delay
      await Future<void>.delayed(const Duration(milliseconds: 800));
      Navigator.pop(context);
    } on Exception catch (e) {
      setState(() {
        _errorMessage = e.toString().replaceFirst('Exception: ', '');
        _isLoading = false;
      });
    }
  }
}
