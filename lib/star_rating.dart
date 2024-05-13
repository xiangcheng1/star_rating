// You have generated a new plugin project without specifying the `--platforms`
// flag. A plugin project with no platform support was generated. To add a
// platform, run `flutter create -t plugin --platforms <platforms> .` under the
// same directory. You can also find a detailed instruction on how to add
// platforms in the `pubspec.yaml` at
// https://flutter.dev/docs/development/packages-and-plugins/developing-packages#plugin-platforms.

import 'package:flutter/material.dart';
import 'star_rating_platform_interface.dart';

class CXStarRating extends StatefulWidget {
  double rating;
  final double maxRating;
  final int count;
  final double size;
  final Color unSelectedColor;
  final Color selectedColor;

  final Widget unselectedImage;
  final Widget selectedIamge;

  final bool isSupportGesture;

  CXStarRating({
    super.key,
    required this.rating,
    this.maxRating = 10,
    this.count = 5,
    this.size = 30,
    Color? unSelectedColor,
    Color? selectedColor,
    Widget? unselectedImage,
    Widget? selectedIamge,
    bool? isSupportGesture,
  })  : assert(rating > 0 && rating <= maxRating),
        unSelectedColor = unSelectedColor ?? Color(0xffbbbbbb),
        selectedColor = selectedColor ?? Color(0xffbb0000),
        unselectedImage = unselectedImage ??
            Icon(
              Icons.star_border,
              color: unSelectedColor,
              size: size,
            ),
        selectedIamge = selectedIamge ??
            Icon(
              Icons.star,
              color: selectedColor,
              size: size,
            ),
        isSupportGesture = isSupportGesture ?? false;

  @override
  State<StatefulWidget> createState() {
    return _CXStarRatingState();
  }

  Future<String?> getPlatformVersion() {
    return StarRatingPlatform.instance.getPlatformVersion();
  }
}

class _CXStarRatingState extends State<CXStarRating> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.size * widget.count,
      child: GestureDetector(
        onHorizontalDragUpdate: widget.isSupportGesture ? (details) {
          double totalWidth = widget.size * widget.count;
          widget.rating = details.localPosition.dx / totalWidth * widget.maxRating;
          print(details.localPosition.dx);
          setState(() {

          });
        } : null,
        onHorizontalDragDown: widget.isSupportGesture ? (details) {
          double totalWidth = widget.size * widget.count;
          widget.rating = details.localPosition.dx / totalWidth * widget.maxRating;
          setState(() {

          });
        } : null,
        child: Stack(
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: buildUnselectedStar(),
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: buildSelectedStar(),
            ),
            // Slider(value: widget.rating/widget.maxRating, onChanged: (value) {
            //   widget.rating = value * widget.maxRating;
            //   print(widget.rating);
            //   setState(() {
            //
            //   });
            // })
          ],
        ),
      ),
    );
  }

  List<Widget> buildUnselectedStar() {
    return List.generate(widget.count, (index) {
      return widget.unselectedImage;
    });
  }

  List<Widget> buildSelectedStar() {
    List<Widget> stars = [];
    final star = widget.selectedIamge;
    // 计算完整star数量
    double oneValue = widget.maxRating / widget.count;
    int entireCount = (widget.rating / oneValue).floor();
    // 绘制完整start
    for (var i = 0; i < entireCount; i++) {
      stars.add(star);
    }
    // 绘制截取star
    double leftWidth = ((widget.rating / oneValue) - entireCount) * widget.size;
    final halfStar = ClipRect(clipper: CXStarClipper(leftWidth), child: star);
    stars.add(halfStar);
    if (stars.length > widget.count) {
      return stars.sublist(0, widget.count);
    }

    return stars;
  }
}

class CXStarClipper extends CustomClipper<Rect> {
  late double width;

  CXStarClipper(this.width);

  @override
  Rect getClip(Size size) {
    return Rect.fromLTRB(0, 0, width, size.height);
  }

  @override
  bool shouldReclip(CXStarClipper oldClipper) {
    return oldClipper.width != this.width;
  }
}
