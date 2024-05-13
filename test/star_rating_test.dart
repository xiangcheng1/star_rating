import 'package:flutter_test/flutter_test.dart';
import 'package:star_rating/star_rating.dart';
import 'package:star_rating/star_rating_platform_interface.dart';
import 'package:star_rating/star_rating_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockStarRatingPlatform
    with MockPlatformInterfaceMixin
    implements StarRatingPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final StarRatingPlatform initialPlatform = StarRatingPlatform.instance;

  test('$MethodChannelStarRating is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelStarRating>());
  });

  test('getPlatformVersion', () async {
    CXStarRating starRatingPlugin = CXStarRating(rating: 9,);
    MockStarRatingPlatform fakePlatform = MockStarRatingPlatform();
    StarRatingPlatform.instance = fakePlatform;

    expect(await starRatingPlugin.getPlatformVersion(), '42');
  });
}
