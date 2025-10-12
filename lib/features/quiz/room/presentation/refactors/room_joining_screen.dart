import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:znoona_game_app/core/helpers/znoona_navigate.dart';
import 'package:znoona_game_app/features/quiz/room/presentation/cubit/room_cubit.dart';
import 'package:znoona_game_app/features/quiz/room/presentation/refactors/room_lobby_screen.dart';

class RoomJoiningScreen extends StatefulWidget {
  const RoomJoiningScreen({super.key});

  @override
  State<RoomJoiningScreen> createState() => _RoomJoiningScreenState();
}

class _RoomJoiningScreenState extends State<RoomJoiningScreen> {
  final TextEditingController _codeController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _codeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Join Room'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: BlocListener<RoomCubit, RoomState>(
        listener: (context, state) {
          state.whenOrNull(
            joined: (room) {
              // Navigate to room lobby when successfully joined
              ZnoonaNavigate.pushReplacementTo(
                context,
                RoomLobbyPage(room: room),
              );
            },
            error: (message) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(message),
                  backgroundColor: Colors.red,
                ),
              );
            },
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              // Header Illustration
              Expanded(
                flex: 2,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.group_add,
                      size: 100,
                      color: Theme.of(context).primaryColor,
                    ),
                    const SizedBox(height: 24),
                    const Text(
                      'Join a Game Room',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      'Enter the room code provided by your friend to join their game',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),

              // Join Form
              Expanded(
                flex: 1,
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: _codeController,
                        decoration: InputDecoration(
                          labelText: 'Room Code',
                          hintText: 'Enter 6-digit code',
                          prefixIcon: const Icon(Icons.vpn_key),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          filled: true,
                          fillColor: Colors.grey.shade50,
                        ),
                        textInputAction: TextInputAction.done,
                        textCapitalization: TextCapitalization.characters,
                        style: const TextStyle(
                          fontSize: 18,
                          letterSpacing: 2,
                          fontWeight: FontWeight.w600,
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter room code';
                          }
                          if (value.length != 6) {
                            return 'Room code must be 6 characters';
                          }
                          return null;
                        },
                        onChanged: (value) {
                          // Auto-uppercase and limit to 6 characters
                          if (value.length > 6) {
                            _codeController.text = value.substring(0, 6);
                            _codeController.selection =
                                const TextSelection.collapsed(
                                  offset: 6,
                                );
                          }
                          _codeController.text = value.toUpperCase();
                        },
                      ),
                      const SizedBox(height: 24),

                      // Join Button
                      BlocBuilder<RoomCubit, RoomState>(
                        builder: (context, state) {
                          final isLoading = state.maybeMap(
                            loading: (_) => true,
                            orElse: () => false,
                          );

                          return SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: isLoading
                                  ? null
                                  : () {
                                      if (_formKey.currentState!.validate()) {
                                        context.read<RoomCubit>().joinRoom(
                                          code: _codeController.text
                                              .trim()
                                              .toUpperCase(),
                                        );
                                      }
                                    },
                              style: ElevatedButton.styleFrom(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 16,
                                ),
                                backgroundColor: Theme.of(context).primaryColor,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              child: isLoading
                                  ? const SizedBox(
                                      height: 20,
                                      width: 20,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2,
                                        valueColor: AlwaysStoppedAnimation(
                                          Colors.white,
                                        ),
                                      ),
                                    )
                                  : const Text(
                                      'Join Room',
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                            ),
                          );
                        },
                      ),

                      const SizedBox(height: 16),

                      // Quick Actions
                      Row(
                        children: [
                          Expanded(
                            child: OutlinedButton.icon(
                              onPressed: () {
                                // Navigate back to room creation
                                Navigator.pop(context);
                              },
                              icon: const Icon(Icons.add),
                              label: const Text('Create Room'),
                              style: OutlinedButton.styleFrom(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 12,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: OutlinedButton.icon(
                              onPressed: () {
                                // Scan QR code functionality
                                _showQRScannerDialog(context);
                              },
                              icon: const Icon(Icons.qr_code_scanner),
                              label: const Text('Scan QR'),
                              style: OutlinedButton.styleFrom(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 12,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showQRScannerDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Scan QR Code'),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.qr_code_scanner, size: 60, color: Colors.grey),
            SizedBox(height: 16),
            Text('QR Scanner functionality coming soon!'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}
