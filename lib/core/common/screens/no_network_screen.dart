import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medaan_almaarifa/core/helpers/znoona.colors.dart';
import 'package:medaan_almaarifa/core/helpers/znoona_texts.dart';
import 'package:medaan_almaarifa/core/language/lang_keys.dart';
import 'package:medaan_almaarifa/core/style/images/app_images.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class NoNetworkScreen extends StatefulWidget {
  const NoNetworkScreen({super.key, this.onRetry});

  final VoidCallback? onRetry;

  @override
  State<NoNetworkScreen> createState() => _NoNetworkScreenState();
}

class _NoNetworkScreenState extends State<NoNetworkScreen> {
  bool _isRetrying = false;
  bool _themeAvailable = true;
  bool _screenUtilInitialized = false;

  @override
  void initState() {
    super.initState();
    _initializeScreenUtil();
  }

  void _initializeScreenUtil() {
    try {
      // Try to initialize ScreenUtil
      // We can check if it's initialized by trying to access a property
      // If it throws, it's not initialized
      try {
        // Attempt to access a property to check if initialized
        final _ = ScreenUtil().screenWidth;
        _screenUtilInitialized = true;
      } catch (e) {
        // Not initialized, so initialize it
        final mediaQuery = MediaQuery.of(context);
        ScreenUtil.init(
          context,
          designSize: Size(mediaQuery.size.width, mediaQuery.size.height),
          minTextAdapt: true,
          splitScreenMode: true,
        );
        _screenUtilInitialized = true;
      }
    } catch (e) {
      _screenUtilInitialized = false;
      debugPrint('Failed to initialize ScreenUtil: $e');
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Check if theme extensions are available
    try {
      ZnoonaColors.main(context);
      _themeAvailable = true;
    } catch (e) {
      _themeAvailable = false;
    }
    
    // Re-initialize ScreenUtil if needed
    if (!_screenUtilInitialized) {
      _initializeScreenUtil();
    }
  }

  Future<void> _handleRetry() async {
    if (_isRetrying) return;
    
    setState(() {
      _isRetrying = true;
    });

    try {
      final results = await Connectivity().checkConnectivity();
      final hasConnection = results.any((r) =>
          r == ConnectivityResult.mobile ||
          r == ConnectivityResult.wifi ||
          r == ConnectivityResult.ethernet);

      if (hasConnection) {
        if (widget.onRetry != null) {
          widget.onRetry!();
        }
      } else {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Still no internet connection'),
              backgroundColor: Colors.red,
            ),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error checking connection: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isRetrying = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // If ScreenUtil isn't initialized or theme isn't available, use fallback
    if (!_screenUtilInitialized || !_themeAvailable) {
      return _buildFallbackScreen();
    }

    return Scaffold(
      backgroundColor: ZnoonaColors.main(context),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TweenAnimationBuilder(
                tween: Tween<double>(begin: 0.8, end: 1.0),
                duration: const Duration(milliseconds: 800),
                curve: Curves.elasticOut,
                builder: (context, double scale, child) {
                  return Transform.scale(
                    scale: scale,
                    child: Container(
                      padding: EdgeInsets.all(20.w),
                      decoration: BoxDecoration(
                        color: Theme.of(context).cardColor.withOpacity(0.1),
                        shape: BoxShape.circle,
                      ),
                      child: Image.asset(
                        AppImages.noNetwork,
                        width: 200.w,
                        height: 200.h,
                        fit: BoxFit.contain,
                        errorBuilder: (context, error, stackTrace) {
                          return Icon(
                            Icons.wifi_off,
                            size: 100.h,
                            color: ZnoonaColors.bluePinkDark(context),
                          );
                        },
                      ),
                    ),
                  );
                },
              ),

              SizedBox(height: 40.h),

              Text(
                ZnoonaTexts.tr(context, LangKeys.noConnection),
                style: GoogleFonts.beiruti(
                  fontSize: 28.h,
                  fontWeight: FontWeight.bold,
                  color: ZnoonaColors.bluePinkDark(context),
                ),
                textAlign: TextAlign.center,
              ),

              SizedBox(height: 16.h),

              Text(
                ZnoonaTexts.tr(context, LangKeys.noConnectionMessage),
                style: GoogleFonts.beiruti(
                  fontSize: 16.h,
                  color: ZnoonaColors.text(context).withOpacity(0.7),
                  height: 1.5,
                ),
                textAlign: TextAlign.center,
              ),

              SizedBox(height: 48.h),

              _buildRetryButton(context),

              SizedBox(height: 24.h),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.settings,
                    size: 16.h,
                    color: ZnoonaColors.text(context).withOpacity(0.5),
                  ),
                  SizedBox(width: 8.w),
                  Text(
                    ZnoonaTexts.tr(context, LangKeys.checkNetworkSettings),
                    style: GoogleFonts.beiruti(
                      fontSize: 14.h,
                      color: ZnoonaColors.text(context).withOpacity(0.5),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFallbackScreen() {
    // Get screen size for manual sizing
    final size = MediaQuery.of(context).size;
    
    return Scaffold(
      backgroundColor: const Color(0xFF242C3B),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.wifi_off,
                size: 100,
                color: Color(0xFF37B6E9),
              ),
              const SizedBox(height: 40),
              Text(
                'No Internet Connection',
                style: GoogleFonts.beiruti(
                  fontSize: size.width * 0.07, // 7% of screen width
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              Text(
                'Please check your internet connection and try again.',
                style: GoogleFonts.beiruti(
                  fontSize: size.width * 0.04, // 4% of screen width
                  color: Colors.white70,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 48),
              _buildFallbackRetryButton(size),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFallbackRetryButton(Size size) {
    return Container(
      width: double.infinity,
      height: size.height * 0.07, // 7% of screen height
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF242C3B), Color(0xFF176B87)],
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: _isRetrying ? null : _handleRetry,
          borderRadius: BorderRadius.circular(16),
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (_isRetrying)
                  const SizedBox(
                    width: 24,
                    height: 24,
                    child: CircularProgressIndicator(
                      color: Colors.white,
                      strokeWidth: 2,
                    ),
                  )
                else
                  const Icon(
                    Icons.refresh,
                    color: Colors.white,
                    size: 24,
                  ),
                const SizedBox(width: 8),
                Text(
                  _isRetrying ? 'Checking...' : 'Try Again',
                  style: GoogleFonts.beiruti(
                    fontSize: size.width * 0.045, // 4.5% of screen width
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildRetryButton(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 56.h,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            ZnoonaColors.main(context),
            ZnoonaColors.bluePinkDark(context),
          ],
        ),
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: ZnoonaColors.bluePinkDark(context).withOpacity(0.3),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: _isRetrying ? null : _handleRetry,
          borderRadius: BorderRadius.circular(16.r),
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (_isRetrying)
                  SizedBox(
                    width: 24.h,
                    height: 24.h,
                    child: CircularProgressIndicator(
                      color: Colors.white,
                      strokeWidth: 2.w,
                    ),
                  )
                else
                  Icon(
                    Icons.refresh,
                    color: Colors.white,
                    size: 24.h,
                  ),
                SizedBox(width: 8.w),
                Text(
                  _isRetrying 
                      ? 'Checking...' 
                      : ZnoonaTexts.tr(context, LangKeys.tryAgain),
                  style: GoogleFonts.beiruti(
                    fontSize: 18.h,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}