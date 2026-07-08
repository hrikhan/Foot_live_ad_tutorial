import 'dart:io';

import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:flutter/material.dart';

import '../models/match_model.dart';

class HomeController extends GetxController {
  final currentIndex = 0.obs;
  final matches = <MatchModel>[].obs;
  final isLoading = true.obs;

  // Banner Ad
  BannerAd? bannerAd;
  final isBannerAdLoaded = false.obs;

  // Interstitial Ad
  InterstitialAd? interstitialAd;
  final isInterstitialAdLoaded = false.obs;

  // Native Ad
  NativeAd? nativeAd;
  final isNativeAdLoaded = false.obs;

  /// Test ad unit IDs — replace with real IDs before publishing.
  String get bannerAdUnitId {
    if (Platform.isAndroid) {
      return 'ca-app-pub-3940256099942544/6300978111';
    } else if (Platform.isIOS) {
      return 'ca-app-pub-3940256099942544/2934735716';
    } else {
      throw UnsupportedError('Unsupported platform');
    }
  }

  String get interstitialAdUnitId {
    if (Platform.isAndroid) {
      return 'ca-app-pub-3940256099942544/1033173712'; // Android test interstitial
    } else if (Platform.isIOS) {
      return 'ca-app-pub-3940256099942544/4411468910'; // iOS test interstitial
    } else {
      throw UnsupportedError('Unsupported platform');
    }
  }

  String get nativeAdUnitId {
    if (Platform.isAndroid) {
      return 'ca-app-pub-3940256099942544/2247696110'; // Android test native advanced
    } else if (Platform.isIOS) {
      return 'ca-app-pub-3940256099942544/3986624511'; // iOS test native advanced
    } else {
      throw UnsupportedError('Unsupported platform');
    }
  }

  @override
  void onInit() {
    super.onInit();
    _loadBannerAd();
    _loadInterstitialAd();
    _loadNativeAd();
    _loadMatches();
  }

  void changeTab(int index) {
    currentIndex.value = index;
  }

  void _loadBannerAd() {
    bannerAd = BannerAd(
      adUnitId: bannerAdUnitId,
      size: AdSize.banner,
      request: const AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (ad) {
          debugPrint('Banner ad loaded.');
          isBannerAdLoaded.value = true;
        },
        onAdFailedToLoad: (ad, error) {
          debugPrint('Banner ad failed: ${error.message}');
          ad.dispose();
          bannerAd = null;
          isBannerAdLoaded.value = false;
        },
      ),
    )..load();
  }

  void _loadMatches() {
    // Simulated live match data
    Future.delayed(const Duration(seconds: 1), () {
      matches.value = [
        MatchModel(
          id: '1',
          homeTeam: 'Barcelona',
          awayTeam: 'Real Madrid',
          homeFlag: '🇪🇸',
          awayFlag: '🇪🇸',
          homeScore: 2,
          awayScore: 1,
          matchTime: "65'",
          league: 'La Liga',
          isLive: true,
        ),
        MatchModel(
          id: '2',
          homeTeam: 'Man City',
          awayTeam: 'Liverpool',
          homeFlag: '🏴󠁧󠁢󠁥󠁮󠁧󠁿',
          awayFlag: '🏴󠁧󠁢󠁥󠁮󠁧󠁿',
          homeScore: 0,
          awayScore: 0,
          matchTime: "12'",
          league: 'Premier League',
          isLive: true,
        ),
        MatchModel(
          id: '3',
          homeTeam: 'Bayern Munich',
          awayTeam: 'Dortmund',
          homeFlag: '🇩🇪',
          awayFlag: '🇩🇪',
          homeScore: 3,
          awayScore: 2,
          matchTime: "88'",
          league: 'Bundesliga',
          isLive: true,
        ),
        MatchModel(
          id: '4',
          homeTeam: 'PSG',
          awayTeam: 'Marseille',
          homeFlag: '🇫🇷',
          awayFlag: '🇫🇷',
          homeScore: 1,
          awayScore: 1,
          matchTime: "45'+2",
          league: 'Ligue 1',
          isLive: true,
        ),
        MatchModel(
          id: '5',
          homeTeam: 'Juventus',
          awayTeam: 'AC Milan',
          homeFlag: '🇮🇹',
          awayFlag: '🇮🇹',
          homeScore: 0,
          awayScore: 2,
          matchTime: '18:00',
          league: 'Serie A',
          isLive: false,
        ),
        MatchModel(
          id: '6',
          homeTeam: 'Arsenal',
          awayTeam: 'Chelsea',
          homeFlag: '🏴󠁧󠁢󠁥󠁮󠁧󠁿',
          awayFlag: '🏴󠁧󠁢󠁥󠁮󠁧󠁿',
          homeScore: 0,
          awayScore: 0,
          matchTime: '20:30',
          league: 'Premier League',
          isLive: false,
        ),
      ];
      isLoading.value = false;
    });
  }

  void _loadInterstitialAd() {
    InterstitialAd.load(
      adUnitId: interstitialAdUnitId,
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) {
          debugPrint('Interstitial ad loaded.');
          interstitialAd = ad;
          isInterstitialAdLoaded.value = true;

          ad.fullScreenContentCallback = FullScreenContentCallback(
            onAdDismissedFullScreenContent: (ad) {
              debugPrint('Interstitial ad dismissed.');
              ad.dispose();
              interstitialAd = null;
              isInterstitialAdLoaded.value = false;
              // Auto-reload the next interstitial
              _loadInterstitialAd();
            },
            onAdFailedToShowFullScreenContent: (ad, error) {
              debugPrint('Interstitial ad failed to show: ${error.message}');
              ad.dispose();
              interstitialAd = null;
              isInterstitialAdLoaded.value = false;
              _loadInterstitialAd();
            },
          );
        },
        onAdFailedToLoad: (error) {
          debugPrint('Interstitial ad failed to load: ${error.message}');
          isInterstitialAdLoaded.value = false;
        },
      ),
    );
  }

  /// Call this to show the interstitial ad (e.g. on match card tap).
  void showInterstitialAd() {
    if (interstitialAd != null) {
      interstitialAd!.show();
    } else {
      debugPrint('Interstitial ad not ready yet.');
    }
  }

  void _loadNativeAd() {
    nativeAd = NativeAd(
      adUnitId: nativeAdUnitId,
      request: const AdRequest(),
      listener: NativeAdListener(
        onAdLoaded: (ad) {
          debugPrint('Native ad loaded.');
          isNativeAdLoaded.value = true;
        },
        onAdFailedToLoad: (ad, error) {
          debugPrint('Native ad failed to load: ${error.message}');
          ad.dispose();
          nativeAd = null;
          isNativeAdLoaded.value = false;
        },
      ),
      nativeTemplateStyle: NativeTemplateStyle(
        templateType: TemplateType.medium,
        mainBackgroundColor: const Color(0xFF1E1E2E),
        callToActionTextStyle: NativeTemplateTextStyle(
          textColor: Colors.black,
          backgroundColor: Colors.greenAccent,
          style: NativeTemplateFontStyle.bold,
          size: 14.0,
        ),
        primaryTextStyle: NativeTemplateTextStyle(
          textColor: Colors.white,
          style: NativeTemplateFontStyle.bold,
          size: 16.0,
        ),
        secondaryTextStyle: NativeTemplateTextStyle(
          textColor: Colors.white70,
          style: NativeTemplateFontStyle.normal,
          size: 14.0,
        ),
        tertiaryTextStyle: NativeTemplateTextStyle(
          textColor: Colors.white54,
          style: NativeTemplateFontStyle.normal,
          size: 12.0,
        ),
      ),
    )..load();
  }

  @override
  void onClose() {
    bannerAd?.dispose();
    interstitialAd?.dispose();
    nativeAd?.dispose();
    super.onClose();
  }
}
