import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';

class DynamicLinkService {
  Future handleDynamicLinks() async {
    // STARTUP FROM DYNAMIC LINK LOGIC
    // Get initial dynamic link if the app is started using the link
    var data = await FirebaseDynamicLinks.instance.getInitialLink();

    handleDeepLink(data);

    // INTO FOREGROUND FROM DYNAMIC LINK LOGIC
  }

  void handleDeepLink(PendingDynamicLinkData? data) {
    var deepLink = data?.link;
    debugPrint('handleDeepLink | deepLink: $deepLink');
  }
}
