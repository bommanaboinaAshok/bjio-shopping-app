
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:bjio/provider/notification_provider.dart';
import 'package:bjio/models/notification_model.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    final notificationProvider =
        context.watch<NotificationProvider>();

    final notifications =
        notificationProvider.notifications;

    return Scaffold(
      // =====================================================
      // APP BAR
      // =====================================================

      appBar: AppBar(
        title: const Text(
          "Notifications",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,

        actions: [
          // READ ALL
          if (notificationProvider.unreadCount > 0)
            TextButton(
              onPressed: () {
                notificationProvider.markAllAsRead();
              },
              child: const Text(
                "Read all",
              ),
            ),
        ],
      ),

      // =====================================================
      // BODY
      // =====================================================

      body: notifications.isEmpty
          ? _emptyNotifications()
          : ListView.builder(
              padding: const EdgeInsets.all(16),

              itemCount: notifications.length,

              itemBuilder: (context, index) {
                final notification =
                    notifications[index];

                return _notificationCard(
                  context,
                  notification,
                  notificationProvider,
                );
              },
            ),
    );
  }

  // =====================================================
  // NOTIFICATION CARD
  // =====================================================

  Widget _notificationCard(
    BuildContext context,
    NotificationModel notification,
    NotificationProvider provider,
  ) {
    return Dismissible(
      key: ValueKey(notification),

      direction:
          DismissDirection.endToStart,

      // DELETE BACKGROUND
      background: Container(
        margin: const EdgeInsets.only(
          bottom: 12,
        ),

        alignment:
            Alignment.centerRight,

        padding:
            const EdgeInsets.only(
          right: 20,
        ),

        decoration: BoxDecoration(
          color: Colors.red,
          borderRadius:
              BorderRadius.circular(15),
        ),

        child: const Icon(
          Icons.delete,
          color: Colors.white,
        ),
      ),

      // DELETE
      onDismissed: (direction) {
        provider.removeNotification(
          notification,
        );
      },

      child: Card(
        margin: const EdgeInsets.only(
          bottom: 12,
        ),

        color: notification.isRead
            ? null
            : Colors.blue.shade50,

        child: ListTile(
          contentPadding:
              const EdgeInsets.all(12),

          // TAP → MARK AS READ
          onTap: () {
            provider.markAsRead(
              notification,
            );
          },

          // ICON
          leading: CircleAvatar(
            backgroundColor:
                Colors.blue.shade100,

            child: Icon(
              notification.icon,
              color: Colors.blue,
            ),
          ),

          // TITLE + UNREAD DOT
          title: Row(
            children: [
              Expanded(
                child: Text(
                  notification.title,

                  style: TextStyle(
                    fontWeight:
                        notification.isRead
                            ? FontWeight.w500
                            : FontWeight.bold,
                  ),
                ),
              ),

              // UNREAD DOT
              if (!notification.isRead)
                Container(
                  width: 9,
                  height: 9,

                  decoration:
                      const BoxDecoration(
                    color: Colors.blue,
                    shape: BoxShape.circle,
                  ),
                ),
            ],
          ),

          // MESSAGE
          subtitle: Padding(
            padding:
                const EdgeInsets.only(
              top: 5,
            ),

            child: Text(
              notification.message,
            ),
          ),

          // TIME
          trailing: Text(
            notification.time,

            style: const TextStyle(
              fontSize: 11,
              color: Colors.grey,
            ),
          ),
        ),
      ),
    );
  }

  // =====================================================
  // EMPTY NOTIFICATIONS
  // =====================================================

  Widget _emptyNotifications() {
    return const Center(
      child: Column(
        mainAxisAlignment:
            MainAxisAlignment.center,

        children: [
          Icon(
            Icons.notifications_none,
            size: 80,
            color: Colors.grey,
          ),

          SizedBox(height: 15),

          Text(
            "No notifications",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),

          SizedBox(height: 5),

          Text(
            "You're all caught up!",
            style: TextStyle(
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}

