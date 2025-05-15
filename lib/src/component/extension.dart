import 'package:flutter/material.dart';

extension ExtensionNotificationListener on Widget {
  Widget interceptNotificationListener<T extends Notification>({
    NotificationListenerCallback<T>? onNotification,
  }) => NotificationListener<T>(
    onNotification: (T notification) {
      if (onNotification != null) onNotification(notification);
      return true;
    },
    child: this,
  );
}
