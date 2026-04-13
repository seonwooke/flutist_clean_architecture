import 'package:flutist/flutist.dart';

final package = Package(
  name: 'flutist_clean_architecture_v3',
  dependencies: [
    // Example)
    // Dependency(name: 'intl', version: '^20.2.0'),
    // Dependency(name: 'test', version: '^1.28.0'),
  ],
  modules: [
    // Modules are auto-registered when you run flutist create
    Module(name: 'product_domain'),
    Module(name: 'product_data'),
    Module(name: 'product_presentation'),
    Module(name: 'cart_domain'),
    Module(name: 'cart_data'),
    Module(name: 'cart_presentation'),
  ],
);