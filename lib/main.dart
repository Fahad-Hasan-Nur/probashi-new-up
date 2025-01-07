import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

import 'probashi.dart';

void main() async {
  await GetStorage.init();
  runApp(ProBashi());
}
