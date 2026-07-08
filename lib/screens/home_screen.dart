import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:get/get.dart';

import '../controllers/home_controller.dart';
import '../widgets/match_card.dart';

import '../widgets/native_ad_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<HomeController>();

    return Column(
      children: [
        // Banner Ad at the top
        Obx(() {
          if (controller.isBannerAdLoaded.value && controller.bannerAd != null) {
            return Container(
              width: controller.bannerAd!.size.width.toDouble(),
              height: controller.bannerAd!.size.height.toDouble(),
              color: Colors.black,
              child: AdWidget(ad: controller.bannerAd!),
            );
          }
          return const SizedBox.shrink();
        }),

        // "Live Matches" header
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 8,
                      height: 8,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 6),
                    const Text(
                      'LIVE',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 10),
              const Text(
                'Matches',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Spacer(),
              TextButton(
                onPressed: () {},
                child: const Text(
                  'See All',
                  style: TextStyle(color: Colors.greenAccent),
                ),
              ),
            ],
          ),
        ),

        // Match cards list with native ad inserted after 2nd match
        Expanded(
          child: Obx(() {
            if (controller.isLoading.value) {
              return const Center(
                child: CircularProgressIndicator(color: Colors.greenAccent),
              );
            }

            // Insert a native ad slot after the 2nd match card
            const int nativeAdPosition = 2;
            final int totalItems = controller.matches.length +
                (controller.matches.length > nativeAdPosition ? 1 : 0);

            return ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: totalItems,
              itemBuilder: (context, index) {
                // Show native ad at position 2
                if (index == nativeAdPosition &&
                    controller.matches.length > nativeAdPosition) {
                  return const NativeAdWidget();
                }

                // Adjust match index after the native ad slot
                final matchIndex = index < nativeAdPosition
                    ? index
                    : index - 1;

                return GestureDetector(
                  onTap: () {
                    controller.showInterstitialAd();
                  },
                  child: MatchCard(match: controller.matches[matchIndex]),
                );
              },
            );
          }),
        ),
      ],
    );
  }
}
