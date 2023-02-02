import 'dart:io';

String fixture(String name) {
  var dir = Directory.current.path;
  dir = dir.replaceAll('\\', '/');
  // if (dir.endsWith('/test')) {
  //   dir = dir.replaceAll('/test', '');
  // }
  //replace with your pwd
  return File(
          'C:/Users/aksha/StudioProjects/shop_app/test/test/presentation/fixture/$name')
      .readAsStringSync();
}
