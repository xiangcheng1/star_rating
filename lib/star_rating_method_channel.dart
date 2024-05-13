import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'star_rating_platform_interface.dart';

/// An implementation of [StarRatingPlatform] that uses method channels.
class MethodChannelStarRating extends StarRatingPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('star_rating');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
