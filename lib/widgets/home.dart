import 'package:inject/inject.dart';
import 'package:flutter/material.dart';
import 'package:sandbox/configuration/injections.dart';
import 'package:sandbox/views/home/home_view.dart';

class HomeWidget extends StatefulWidget {

  @override
  _HomeWidgetState createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    Inject().configureInjections(context);
  }

  @override
  Widget build(BuildContext context) {
    return HomeView();
  }
}