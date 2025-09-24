import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../utils/utility.dart';
import 'notification_pusher_cubit.dart';
import 'notification_pusher_service.dart';
import 'notification_pusher_state.dart';

/// Example of how to use the global notification pusher service
class NotificationPusherUsageExample extends StatefulWidget {
  const NotificationPusherUsageExample({super.key});

  @override
  State<NotificationPusherUsageExample> createState() =>
      _NotificationPusherUsageExampleState();
}

class _NotificationPusherUsageExampleState
    extends State<NotificationPusherUsageExample> {
  @override
  void initState() {
    super.initState();
    // Initialize the notification pusher when the widget is created
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initializeNotificationPusher();
    });
  }

  void _initializeNotificationPusher() async {
    // Option 1: Initialize with a specific user ID
    await NotificationPusherService.initializeGlobal(context, '12345');

    // Option 2: Initialize with current user from mainAppBloc
    // await NotificationPusherService.initializeWithCurrentUser(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notification Pusher Example'),
      ),
      body: NotificationPusherService.createNotificationListener(
        onUserNotification: (state) {
          // Handle user notification
          cprint('📨 User Notification: ${state.notificationData.title}');
          cprint('📄 Body: ${state.notificationData.body}');

          // Show a snackbar or dialog
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content:
                  Text('User Notification: ${state.notificationData.title}'),
              backgroundColor: Colors.blue,
            ),
          );
        },
        onGeneralNotification: (state) {
          // Handle general notification
          cprint('📨 General Notification: ${state.notificationData.title}');
          cprint('📄 Body: ${state.notificationData.body}');

          // Show a snackbar or dialog
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content:
                  Text('General Notification: ${state.notificationData.title}'),
              backgroundColor: Colors.green,
            ),
          );
        },
        onConnectionStateChanged: (state) {
          // Handle connection state changes
          cprint('🔄 Connection State: ${state.state}');
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Connection status indicator
            BlocBuilder<NotificationPusherCubit, NotificationPusherState>(
              builder: (context, state) {
                if (state is NotificationPusherConnectionStateChanged) {
                  return Container(
                    padding: const EdgeInsets.all(16),
                    margin: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: _getConnectionColor(state.state),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          _getConnectionIcon(state.state),
                          color: Colors.white,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'Status: ${state.state.name}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  );
                }
                return const SizedBox.shrink();
              },
            ),

            const SizedBox(height: 20),

            // Control buttons
            ElevatedButton(
              onPressed: () async {
                await NotificationPusherService.initializeWithCurrentUser(
                    context);
              },
              child: const Text('Initialize with Current User'),
            ),

            const SizedBox(height: 10),

            ElevatedButton(
              onPressed: () async {
                await NotificationPusherService.disconnect();
              },
              child: const Text('Disconnect'),
            ),

            const SizedBox(height: 10),

            ElevatedButton(
              onPressed: () async {
                await NotificationPusherService.reinitialize(context, '67890');
              },
              child: const Text('Reinitialize with New User'),
            ),

            const SizedBox(height: 20),

            Text(
              'Service Status: ${NotificationPusherService.isInitialized ? "Initialized" : "Not Initialized"}',
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }

  Color _getConnectionColor(NotificationPusherConnectionState state) {
    switch (state) {
      case NotificationPusherConnectionState.CONNECTED:
        return Colors.green;
      case NotificationPusherConnectionState.CONNECTING:
        return Colors.orange;
      case NotificationPusherConnectionState.DISCONNECTED:
        return Colors.red;
      case NotificationPusherConnectionState.RECONNECTING:
        return Colors.blue;
      case NotificationPusherConnectionState.DISCONNECTING:
        return Colors.grey;
    }
  }

  IconData _getConnectionIcon(NotificationPusherConnectionState state) {
    switch (state) {
      case NotificationPusherConnectionState.CONNECTED:
        return Icons.check_circle;
      case NotificationPusherConnectionState.CONNECTING:
        return Icons.sync;
      case NotificationPusherConnectionState.DISCONNECTED:
        return Icons.error;
      case NotificationPusherConnectionState.RECONNECTING:
        return Icons.refresh;
      case NotificationPusherConnectionState.DISCONNECTING:
        return Icons.close;
    }
  }
}
