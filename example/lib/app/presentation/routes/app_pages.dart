import 'package:app_mi_upc/app_mi_upc.dart';
import 'package:flutter/animation.dart';
import 'package:get/get.dart';



class AppPages {
  static final _transition = Transition.rightToLeft;
  static final _transitionDuration = const Duration(milliseconds: 400);
  static final _curve = Curves.fastOutSlowIn;
  static List<GetPage> _pages = [];

  static GetPage getPageConfig(
      {required String name,
      required GetPageBuilder page,
      required Bindings binding}) {
    return GetPage(
        transition: _transition,
        transitionDuration: _transitionDuration,
        curve: _curve,
        name: name,
        page: page,
        binding: binding);
  }

  static List<GetPage> getPages() {
    _pages = [];

    //agregamos las paguinas de cada app
    _pages.addAll(MiUpc.getPages);

    return _pages;
  }
}
