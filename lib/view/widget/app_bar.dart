import 'package:flutter/material.dart';

PreferredSizeWidget appBar(
  String title,
  String subTitle,
  List<IconButton> iconButtonList,
) {
  return AppBar(
    title: Text(title),
    // todo styling text
    bottom: PreferredSize(preferredSize: Size.zero, child: Text(subTitle)),
    actions: iconButtonList,
  );
}
