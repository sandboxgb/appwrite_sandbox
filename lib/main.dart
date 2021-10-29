
import 'package:flutter/material.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:sandbox/widgets/startup.dart';
import 'configuration/settings.dart';

void main() {
  GlobalConfiguration().loadFromMap(appSettings);
  runApp(
    MaterialApp(
      title: GlobalConfiguration().getValue(APP_TITTLE),
      debugShowCheckedModeBanner: false,
      home: StartupWidget(),
    ),
  );
}