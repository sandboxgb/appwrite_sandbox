
import 'package:event_bus/event_bus.dart';
import 'package:flutter/cupertino.dart';
import 'package:inject/inject.dart';
import 'package:responsive/responsive.dart';
import 'package:appwrite_flutter/appwrite.dart';
import 'package:appwrite_flutter/users.dart';
import 'package:sandbox/configuration/screen_size.dart';
import 'package:sandbox/entities/customer.dart';
import 'package:sandbox/repositories/customer_repository.dart';
import 'package:sandbox/views/home/home_controller.dart';

extension InjectionConfigureExtension on Inject {

  void configureStartUpInjections() {
    var appWrite = AppWrite();
    Inject().putOn(() => appWrite);
    Inject().putOn(() => UserRepository(appWrite));
    Inject().putOn(() => EventBus());
  }

  void configureInjections(BuildContext context) {
    AppWrite appWrite =  Inject().get<AppWrite>();
    Inject().putOn(() => CustomerRepository(appWrite, CustomerSerializer()));
    Inject().putOn(() => HomeController());
    Inject().putOn(
            () => new Responsive(context, ScreenSize.width, ScreenSize.height));
  }

}