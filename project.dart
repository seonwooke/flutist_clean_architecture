// ignore_for_file: unused_import

import 'package:flutist/flutist.dart';

import 'flutist/flutist_gen.dart';
import 'package.dart';

import 'package:flutist/flutist.dart';
import 'flutist/flutist_gen.dart';
import 'package.dart';

final project = Project(
  name: 'flutist_clean_architecture_v3',
  options: const ProjectOptions(compositionRoots: ['app']),
  modules: [
    // ── product (clean) ──────────────────────────────────
    Module(
      name: 'product_domain',
      dependencies: [package.dependencies.equatable],
      modules: [],
    ),
    Module(
      name: 'product_data',
      dependencies: [package.dependencies.dio],
      modules: [package.modules.productDomain],
    ),
    Module(
      name: 'product_presentation',
      dependencies: [package.dependencies.flutterBloc],
      modules: [package.modules.productDomain],
    ),

    // ── cart (clean) ─────────────────────────────────────
    Module(
      name: 'cart_domain',
      dependencies: [package.dependencies.equatable],
      modules: [],
    ),
    Module(name: 'cart_data', modules: [package.modules.cartDomain]),
    Module(
      name: 'cart_presentation',
      dependencies: [package.dependencies.flutterBloc],
      modules: [package.modules.cartDomain],
    ),

    // ── app (composition root) ────────────────────────────
    // presentation + data를 모두 의존: data 구현체를 직접 인스턴스화해서 주입
    Module(
      name: 'app',
      modules: [
        package.modules.productPresentation,
        package.modules.productData,
        package.modules.cartPresentation,
        package.modules.cartData,
      ],
    ),
  ],
);
