import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';

class DynamicLinkService {
  Future handleDynamicLinks() async {
    // STARTUP FROM DYNAMIC LINK LOGIC
    // Get initial dynamic link if the app is started using the link
    var data = await FirebaseDynamicLinks.instance.getInitialLink();

    handleDeepLink(data);

    // INTO FOREGROUND FROM DYNAMIC LINK LOGIC
    FirebaseDynamicLinks.instance.onLink(
        onSuccess: (PendingDynamicLinkData? dynamicLinkData) async {
          debugPrint(dynamicLinkData.toString());
          handleDeepLink(dynamicLinkData);
          if (dynamicLinkData != null) {
            debugPrint('HANDLE DYNAMIC LINK --- POSIBLE LINK');
          }
          debugPrint('HANDLE DYNAMIC LINK --- NO LINK FOUND');
    }, onError: (OnLinkErrorException e) async {
      debugPrint('Dynamic Link Failed: ${e.message}');
    });
  }

  void handleDeepLink(PendingDynamicLinkData? data) {
    if (data != null) {
      debugPrint('HANDLE DEEP LINK --- LINK IS NOT NULL'); 
    }
    var deepLink = data?.link;
    debugPrint('handleDeepLink | deepLink: $deepLink');
  }

  Future<void> retrieveDynamicLink (BuildContext context) async {
    debugPrint('DYNAMIC LINK SERVICE --- STARTING CHECK');
    try {
      var data = await FirebaseDynamicLinks.instance.getInitialLink();
      var deepLink = data?.link;

      if (data != null) {
        debugPrint('POSSIBLE DEEP LINK FOUND');
      }

      if (deepLink != null) {
        debugPrint('DYNAMIC LINK SERVICE --- FOUND DEEP LINK');
      }

      FirebaseDynamicLinks.instance.onLink(
        onSuccess: (PendingDynamicLinkData? dynamicLink) async {
          debugPrint('DYNAMIC LINK SERVICE --- POSSIBLE DEEP LINK FOUND');
      });
    } catch (e) {
      debugPrint('DYNAMIC LINK SERVICE --- ERROR');
    }
  }
}
