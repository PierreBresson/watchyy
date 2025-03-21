import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:watchyy/locations/locations_helpers.dart';
import 'package:watchyy/navigation/navigation.dart';
import 'package:watchyy/screens/screens.dart';

GoRouter getNotConnectedRouter(BuildContext context) {
  return GoRouter(
    routes: [
      GoRoute(
        path: '/',
        builder: (_, state) => MyWatchesScreen(key: state.pageKey),
        routes: [
          GoRoute(
            path: scanningPath,
            builder: (_, state) {
              return Consumer<BleStatus?>(
                builder: (_, status, __) {
                  if (status == BleStatus.ready) {
                    return ScanningScreen(key: state.pageKey);
                  } else {
                    return BleStatusScreen(status: status ?? BleStatus.unknown);
                  }
                },
              );
            },
          ),
        ],
      ),
    ],
  );
}

StatefulShellBranch _getHomeShell(
  GlobalKey<NavigatorState>? navigatorKey,
) {
  return StatefulShellBranch(
    navigatorKey: navigatorKey,
    routes: [
      GoRoute(
        path: homePath,
        pageBuilder: (_, state) => NoTransitionPage(
          child: HomeScreen(key: state.pageKey),
        ),
      ),
    ],
  );
}

StatefulShellBranch _getSettingsShell(
  GlobalKey<NavigatorState>? navigatorKey,
) {
  return StatefulShellBranch(
    navigatorKey: navigatorKey,
    routes: [
      GoRoute(
        path: settingsPath,
        pageBuilder: (_, state) => NoTransitionPage(
          child: SettingsScreen(key: state.pageKey),
        ),
      ),
    ],
  );
}

GoRouter getRouter() {
  final branches = [
    _getHomeShell(shellNavigatorHomeKey),
    _getSettingsShell(shellNavigatorSettingsKey),
  ];

  /* https://github.com/bizz84/nestednavigationexamples/blob/main/examples/gorouter/lib/main.dart */
  return GoRouter(
    initialLocation: homePath,
    debugLogDiagnostics: kDebugMode,
    routes: [
      StatefulShellRoute.indexedStack(
        builder: (_, __, navigationShell) {
          return ScaffoldWithNestedNavigation(
            navigationShell: navigationShell,
          );
        },
        branches: branches,
      ),
    ],
  );
}
