import 'dart:html' as html;

void sendBrowserNotification(String title, String body) {
  if (html.Notification.permission != 'granted') {
    html.Notification.requestPermission().then((permission) {
      if (permission == 'granted') {
        html.Notification(title, body: body);
        print('Notification permission granted. Notification sent.');
      } else {
        print('Notification permission denied.');
      }
    });
  } else {
    html.Notification(title, body: body);
    print('Notification sent directly.');
  }
}
