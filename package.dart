import 'package:flutist/flutist.dart';

final package = Package(
  name: 'flutist_clean_architecture_v3',
  dependencies: [
    Dependency(name: 'dio', version: '^5.4.0'),
    Dependency(name: 'flutter_bloc', version: '^8.1.4'),
    Dependency(name: 'equatable', version: '^2.0.5'),
    Dependency(name: 'mocktail', version: '^1.0.3'),
    Dependency(name: 'bloc_test', version: '^9.1.7'),
    Dependency(name: 'test', version: '^1.24.0'),
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
