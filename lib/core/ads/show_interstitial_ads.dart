import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

void showInterstitialAd() {
  InterstitialAd.load(
    adUnitId: dotenv.env['AD_UNIT_ID'] ?? "",
    request: const AdRequest(),
    adLoadCallback: InterstitialAdLoadCallback(
      onAdLoaded: (InterstitialAd ad) {
        ad.fullScreenContentCallback = FullScreenContentCallback(
          onAdDismissedFullScreenContent: (InterstitialAd ad) {
            ad.dispose();
          },
        );
        ad.show();
      },
      onAdFailedToLoad: (_) {
      },
    ),
  );
}
