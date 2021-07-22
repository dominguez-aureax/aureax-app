import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';

class DynamicLinkService {
  Future<Uri> createReferralLink(String referralCode) async {
    var dynamicLinkParameters = DynamicLinkParameters(
      uriPrefix: 'https://aureaxapp.page.link',
      link: Uri.parse('https://myaureax.com/refer?=$referralCode'),
    );

    return await dynamicLinkParameters.buildUrl();
  }

  Future handleDynamicLinks(BuildContext context) async {
    FirebaseDynamicLinks.instance.onLink(
        onSuccess: (PendingDynamicLinkData? dynamicLink) async {
      var deepLink = dynamicLink?.link;

      if (deepLink != null) {
        debugPrint('HANDLE DYNAMIC LINK --- a dynamic link has been found.');
        await Navigator.pushNamed(context, '/referral');
      }
    }, onError: (OnLinkErrorException e) async {
      debugPrint('HANDLE DYNAMIC LINK --- an error has been found.');
      debugPrint(e.message);
    });

    var data = await FirebaseDynamicLinks.instance.getInitialLink();
    var deepLink = data?.link;

    if (deepLink != null) {
      debugPrint(
          'HANDLE DYNAMIC LINK --- an initial dynamic link has been found.');
      await Navigator.pushNamed(context, '/referral');
    }
  }

  void handleDeepLink(PendingDynamicLinkData? data) {
    if (data != null) {
      debugPrint('HANDLE DEEP LINK --- LINK IS NOT NULL');
    }
    var deepLink = data?.link;
    debugPrint('handleDeepLink | deepLink: $deepLink');
  }

  Future<void> retrieveDynamicLink(BuildContext context) async {
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
