// ignore_for_file: unused_import

import 'package:flutist/flutist.dart';

import 'flutist/flutist_gen.dart';
import 'package.dart';

final project = Project(
  name: 'flutist_clean_architecture_v3',
  options: const ProjectOptions(),
  modules: [
    Module(
      name: 'app',
      dependencies: [
        // Example)
        // package.dependencies.intl,
      ],
      devDependencies: [
        // Example)
        // package.dependencies.test,
      ],
      modules: [
        // Example)
        // package.modules.login,
      ],
    ),
    Module(
      name: 'product_domain',
      dependencies: [],
      devDependencies: [],
      modules: [],
    ),
    Module(
      name: 'product_data',
      dependencies: [],
      devDependencies: [],
      modules: [
        package.modules.productDomain,
      ],
    ),
    Module(
      name: 'product_presentation',
      dependencies: [],
      devDependencies: [],
      modules: [
        package.modules.productDomain,
      ],
    ),
  ],
);
