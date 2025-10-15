import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:znoona_game_app/core/common/widgets/custom_app_bar.dart';
import 'package:znoona_game_app/core/helpers/znoona.colors.dart';
import 'package:znoona_game_app/core/helpers/znoona_navigate.dart';
import 'package:znoona_game_app/core/language/lang_keys.dart';
import 'package:znoona_game_app/features/quiz/room/domain/entities/room.dart';
import 'package:znoona_game_app/features/quiz/room/domain/entities/room_player.dart';
import 'package:znoona_game_app/features/quiz/room/presentation/cubit/room_cubit.dart';
import 'package:znoona_game_app/features/quiz/room/presentation/refactors/game_playing_screen.dart';

class RoomLobbyBody extends StatefulWidget {
  const RoomLobbyBody({required this.room, super.key});
  final Room room;

  @override
  State<RoomLobbyBody> createState() => _RoomLobbyBodyState();
}

class _RoomLobbyBodyState extends State<RoomLobbyBody> {
  @override
  void initState() {
    super.initState();
    _startWatching();
  }

  void _startWatching() {
    context.read<RoomCubit>().watchRoom(widget.room.id);
    context.read<RoomCubit>().watchRoomPlayers(widget.room.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<RoomCubit, RoomState>(
        listener: (context, state) {
          state.whenOrNull(
            gameStarted: () {
              _navigateToGameScreen();
            },
            roomUpdated: (room) {
              if (room != null && room.status == 'playing') {
                _navigateToGameScreen();
              }
            },
            left: () {
              Navigator.pop(context);
            },
            error: (message) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(message)),
              );
            },
          );
        },
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const CustomAppBar(title: LangKeys.room),
                _RoomInfoCard(room: _getCurrentRoom(state) ?? widget.room),

                const SizedBox(height: 24),

                // Players List
                Expanded(
                  child: _PlayersList(roomId: widget.room.id),
                ),

                const SizedBox(height: 16),

                // Start Game Button (only for host)
                _StartGameButton(room: _getCurrentRoom(state) ?? widget.room),
              ],
            ),
          );
        },
      ),
    );
  }

  Room? _getCurrentRoom(RoomState state) {
    return state.maybeWhen(
      roomUpdated: (room) => room,
      roomLoaded: (room) => room,
      joined: (room) => room,
      orElse: () => null,
    );
  }

  void _navigateToGameScreen() {
    // Use a small delay to ensure the state is properly updated
    Future.delayed(const Duration(milliseconds: 100), () {
      if (mounted) {
        ZnoonaNavigate.pushReplacementTo(
          context,
          GamePlayingScreen(room: widget.room),
        );
      }
    });
  }

}

class _RoomInfoCard extends StatelessWidget {
  const _RoomInfoCard({required this.room});
  final Room room;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      color: ZnoonaColors.bluePinkDark(context),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Room Code',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.white),
                  ),
                  child: Text(
                    room.code,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      letterSpacing: 2,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Status',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
                BlocBuilder<RoomCubit, RoomState>(
                  builder: (context, state) {
                    final currentRoom = _getCurrentRoom(state) ?? room;
                    return Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: _getStatusColor(currentRoom.status),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        currentRoom.status.toUpperCase(),
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Players',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
                BlocBuilder<RoomCubit, RoomState>(
                  builder: (context, state) {
                    final playersCount = state.maybeWhen(
                      playersUpdated: (players) => players.length,
                      orElse: () => 1, // At least the host
                    );
                    return Text(
                      '$playersCount/8',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Room? _getCurrentRoom(RoomState state) {
    return state.maybeWhen(
      roomUpdated: (room) => room,
      roomLoaded: (room) => room,
      joined: (room) => room,
      orElse: () => null,
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'waiting':
        return Colors.orange;
      case 'playing':
        return Colors.green;
      case 'finished':
        return Colors.blue;
      default:
        return Colors.grey;
    }
  }
}

class _PlayersList extends StatelessWidget {
  const _PlayersList({required this.roomId});
  final String roomId;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Players',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 12),
        Expanded(
          child: BlocBuilder<RoomCubit, RoomState>(
            builder: (context, state) {
              final players = state.maybeWhen(
                playersUpdated: (players) => players,
                orElse: () => <RoomPlayer>[],
              );

              if (players.isEmpty) {
                return const Center(
                  child: Text('Waiting for players to join...'),
                );
              }

              return ListView.builder(
                itemCount: players.length,
                itemBuilder: (context, index) {
                  final player = players[index];
                  return _PlayerListItem(player: player);
                },
              );
            },
          ),
        ),
      ],
    );
  }
}

class _PlayerListItem extends StatelessWidget {
  const _PlayerListItem({required this.player});
  final RoomPlayer player;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: Stack(
          children: [
            CircleAvatar(
              backgroundColor: player.isHost
                  ? Theme.of(context).primaryColor
                  : Colors.grey.shade300,
              child: Icon(
                player.isHost ? Icons.star : Icons.person,
                color: player.isHost ? Colors.white : Colors.grey.shade600,
              ),
            ),
            if (player.isHost)
              Positioned(
                right: 0,
                bottom: 0,
                child: Container(
                  padding: const EdgeInsets.all(2),
                  decoration: const BoxDecoration(
                    color: Colors.amber,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.star,
                    color: Colors.white,
                    size: 12,
                  ),
                ),
              ),
          ],
        ),
        title: Row(
          children: [
            Text(
              player.username,
              style: TextStyle(
                fontWeight: player.isHost ? FontWeight.bold : FontWeight.normal,
              ),
            ),
            if (player.isHost) ...[
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  'HOST',
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ),
            ],
          ],
        ),
        subtitle: Text(
          player.isHost ? 'Room Host' : 'Player',
          style: TextStyle(
            color: player.isHost
                ? ZnoonaColors.main(context).withAlpha(150)
                : ZnoonaColors.main(context).withAlpha(150),
          ),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: player.isConnected
                    ? Colors.green.shade100
                    : Colors.red.shade100,
                shape: BoxShape.circle,
              ),
              child: Icon(
                player.isConnected ? Icons.wifi : Icons.wifi_off,
                color: player.isConnected ? Colors.green : Colors.red,
                size: 16,
              ),
            ),
            const SizedBox(width: 8),
            // Score (if any)
            Text(
              '${player.score} pts',
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }
}

class _StartGameButton extends StatelessWidget {
  const _StartGameButton({required this.room});
  final Room room;

  @override
  Widget build(BuildContext context) {
    final currentUserId = _getCurrentUserId();
    final isHost = room.hostId == currentUserId;

    if (room.status == 'playing') {
      return Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.green.shade50,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.green.shade200),
        ),
        child: Column(
          children: [
            const Icon(Icons.play_arrow, color: Colors.green, size: 40),
            const SizedBox(height: 8),
            const Text(
              'Game is in progress!',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
            ),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: () {
                ZnoonaNavigate.pushReplacementTo(
                  context,
                  GamePlayingScreen(room: room),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
              ),
              child: const Text(
                'Join Game',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      );
    }

    if (!isHost) {
      return const Padding(
        padding: EdgeInsets.symmetric(vertical: 16),
        child: Column(
          children: [
            Icon(Icons.hourglass_empty, size: 40, color: Colors.grey),
            SizedBox(height: 8),
            Text(
              'Waiting for host to start the game...',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
          ],
        ),
      );
    }

    return BlocBuilder<RoomCubit, RoomState>(
      builder: (context, state) {
        final players = state.maybeWhen(
          playersUpdated: (players) => players,
          orElse: () => <RoomPlayer>[],
        );

        final canStart =
            players.length >= 1 &&
            players.length <= 8; // At least 1 player (host) to start

        return Column(
          children: [
            if (players.length < 2)
              Container(
                padding: const EdgeInsets.all(12),
                margin: const EdgeInsets.only(bottom: 16),
                decoration: BoxDecoration(
                  color: Colors.orange.shade50,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.orange.shade200),
                ),
                child: Row(
                  children: [
                    Icon(Icons.info, color: Colors.orange.shade600),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        'Invite more players for better competition!',
                        style: TextStyle(
                          color: Colors.orange.shade800,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

            ElevatedButton(
              onPressed: canStart
                  ? () {
                      _showStartGameDialog(context, players.length);
                    }
                  : null,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
                backgroundColor: Theme.of(context).primaryColor,
                foregroundColor: Colors.white,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.play_arrow),
                  const SizedBox(width: 8),
                  Text(
                    canStart
                        ? 'Start Game (${players.length} player${players.length > 1 ? 's' : ''})'
                        : 'Need at least 2 player to start',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  String _getCurrentUserId() {
    // Implement this based on your auth system
    final user = Supabase.instance.client.auth.currentUser;
    return user?.id ?? '';
  }

  void _showStartGameDialog(BuildContext context, int playerCount) {
    showDialog<dynamic>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Start Game?'),
        content: Text(
          'Start the game with $playerCount player${playerCount > 1 ? 's' : ''}?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              context.read<RoomCubit>().startGame(room.id);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).primaryColor,
            ),
            child: const Text(
              'Start Game',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
