import 'dart:io';

import 'package:flutter/foundation.dart';

String readJson(String name) {
  var dir = Directory.current.path;
  if (kDebugMode) {
    print(dir);
  }
  if (dir.endsWith('/test')) {
    dir = dir.replaceAll('/test', '');
  }
  // if (dir.endsWith('core')) {
  //   return File('$dir/test/$name').readAsStringSync();
  // }
  return File('$dir/test/$name').readAsStringSync();
}
