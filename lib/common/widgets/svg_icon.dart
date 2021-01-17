import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';

class SVGIcon extends StatelessWidget {
  final Color color;
  final String assetAddress;
  final double size;

  const SVGIcon(
      {Key key, @required this.color, @required this.assetAddress, this.size = 24})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      this.assetAddress,
      color: this.color,
      width: this.size,
      height: this.size,
    );
  }
}
