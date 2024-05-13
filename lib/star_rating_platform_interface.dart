import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'star_rating_method_channel.dart';

abstract class StarRatingPlatform extends PlatformInterface {
  /// Constructs a StarRatingPlatform.
  StarRatingPlatform() : super(token: _token);

  static final Object _token = Object();

  static StarRatingPlatform _instance = MethodChannelStarRating();

  /// The default instance of [StarRatingPlatform] to use.
  ///
  /// Defaults to [MethodChannelStarRating].
  static StarRatingPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [StarRatingPlatform] when
  /// they register themselves.
  static set instance(StarRatingPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
