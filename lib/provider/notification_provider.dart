
import 'package:flutter/material.dart';
import 'package:bjio/models/notification_model.dart';

class NotificationProvider extends ChangeNotifier {
  final List<NotificationModel> _notifications = [
    NotificationModel(
      title: "Special Offer",
      message: "Get 30% off on selected products.",
      time: "2 hours ago",
      icon: Icons.local_offer_outlined,
    ),

    NotificationModel(
      title: "Order Update",
      message: "Your order has been shipped.",
      time: "5 hours ago",
      icon: Icons.shopping_bag_outlined,
    ),

    NotificationModel(
      title: "Wishlist Update",
      message: "Your favorite product is back in stock.",
      time: "Yesterday",
      icon: Icons.favorite_border,
      isRead: true,
    ),
  ];

  // Get all notifications
  List<NotificationModel> get notifications =>
      _notifications;

  // Get unread notifications count
  int get unreadCount {
    return _notifications
        .where((notification) => !notification.isRead)
        .length;
  }

  // Add notification
  void addNotification(
    NotificationModel notification,
  ) {
    _notifications.insert(
      0,
      notification,
    );

    notifyListeners();
  }

  // Mark one notification as read
  void markAsRead(
    NotificationModel notification,
  ) {
    notification.isRead = true;

    notifyListeners();
  }

  // Mark all notifications as read
  void markAllAsRead() {
    for (final notification in _notifications) {
      notification.isRead = true;
    }

    notifyListeners();
  }

  // Remove notification
  void removeNotification(
    NotificationModel notification,
  ) {
    _notifications.remove(notification);

    notifyListeners();
  }

  // Clear all notifications
  void clearNotifications() {
    _notifications.clear();

    notifyListeners();
  }
}

