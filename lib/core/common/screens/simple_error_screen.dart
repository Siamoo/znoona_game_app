import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class SimpleErrorScreen extends StatelessWidget {
  const SimpleErrorScreen({
    super.key,
    this.errorMessage,
    this.onRetry,
    this.isNetworkError = false,
  });
  final String? errorMessage;
  final VoidCallback? onRetry;
  final bool isNetworkError;

  @override
  Widget build(BuildContext context) {
    // Get screen size for responsive sizing without ScreenUtil
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: const Color(0xFF242C3B), // Dark main color as fallback
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(size.width * 0.06), // 6% of screen width
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                isNetworkError ? Icons.wifi_off : Icons.error_outline,
                size: size.width * 0.2, // 20% of screen width
                color: const Color(0xFF37B6E9), // Blue light as fallback
              ),
              SizedBox(height: size.height * 0.03),
              Text(
                isNetworkError ? 'Connection Error' : 'Initialization Failed',
                style: GoogleFonts.beiruti(
                  fontSize: size.width * 0.06, // 6% of screen width
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: size.height * 0.02),
              Text(
                errorMessage ?? 'An error occurred while initializing the app.',
                style: GoogleFonts.beiruti(
                  fontSize: size.width * 0.04, // 4% of screen width
                  color: Colors.white70,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: size.height * 0.04),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (onRetry != null)
                    _buildButton(
                      context,
                      label: 'Retry',
                      color: const Color(0xFF37B6E9),
                      onTap: onRetry!,
                      size: size,
                    ),
                  if (onRetry != null) SizedBox(width: size.width * 0.04),
                  _buildButton(
                    context,
                    label: 'Close',
                    color: Colors.grey,
                    onTap: SystemNavigator.pop,
                    size: size,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildButton(
    BuildContext context, {
    required String label,
    required Color color,
    required VoidCallback onTap,
    required Size size,
  }) {
    return Expanded(
      child: Container(
        height: size.height * 0.06, // 6% of screen height
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(size.width * 0.03),
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(size.width * 0.03),
            child: Center(
              child: Text(
                label,
                style: GoogleFonts.beiruti(
                  fontSize: size.width * 0.04,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
