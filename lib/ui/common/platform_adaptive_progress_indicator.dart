//https://github.com/roughike/inKino/blob/development/lib/ui/common/platform_adaptive_progress_indicator.dart

import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PlatformAdaptiveProgressIndicator extends StatelessWidget {
  const PlatformAdaptiveProgressIndicator({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? const CupertinoActivityIndicator()
        : const CircularProgressIndicator();
  }
}
