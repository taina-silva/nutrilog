import 'package:flutter/material.dart';

var fadeTransition = (ctx, anim, secAnim, child) {
  return FadeTransition(
    opacity: anim,
    child: SlideTransition(
      position: Tween<Offset>(
        begin: const Offset(0, -1),
        end: Offset.zero,
      ).animate(anim),
      child: child,
    ),
  );
};
