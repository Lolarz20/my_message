import 'dart:io';
import 'package:google_mobile_ads/google_mobile_ads.dart';
class AdState {
  Future<InitializationStatus> initialization;

  AdState(this.initialization);

  final bannerAdUnitId='ca-app-pub-4481734767413253/5808332397';

  BannerAdListener get adListener => _adListener;
  BannerAdListener _adListener = BannerAdListener();
}