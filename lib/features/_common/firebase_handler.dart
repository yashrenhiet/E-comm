import 'package:e_comm_app/features/_common/app_state.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';

class FirebaseHandler {
  static init() async {
    await Firebase.initializeApp();

    String? token = await FirebaseMessaging.instance.getToken();

    print("======================> TOKEN  ${token}");

    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {});

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Got a message whilst in the foreground!');
      print('Message data: ${message.data} && ${message.data["clearCart"]}');

      if (message.notification != null) {
        print('Message also contained a notification: ${message.notification}');
      }

      if (message.data["clearCart"] == "true") {
        Get.find<AppState>().clearCart();
      }

      if (message.data["logoutUser"] == "true") {
        Get.find<AppState>().logoutUser();
      }
    });
  }

  static Future<void> _firebaseMessagingBackgroundHandler(
      RemoteMessage message) async {
    // If you're going to use other Firebase services in the background, such as Firestore,
    // make sure you call `initializeApp` before using other Firebase services.
    await Firebase.initializeApp();
    print('Handling a background message ${message.messageId}');
  }
}
