import 'dart:ui' as dui;

import 'geometry.dart' as geo;

dui.Offset uiOffset(geo.Offset offset) => dui.Offset(offset.dx, offset.dy);
dui.Size uiSize(geo.Size size) => dui.Size(size.width, size.height);
