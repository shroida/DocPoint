import 'dart:async';

import 'package:docpoint/core/routing/app_router.dart';
import 'package:docpoint/doc_point.dart';
import 'package:flutter/widgets.dart';
import 'package:uni_links5/uni_links.dart';

class DeepLinkHandler extends StatefulWidget {
  final AppRouter appRouter;

  const DeepLinkHandler({super.key, required this.appRouter});

  @override
  State<DeepLinkHandler> createState() => _DeepLinkHandlerState();
}

class _DeepLinkHandlerState extends State<DeepLinkHandler> {
  StreamSubscription? _sub;

  @override
  void initState() {
    super.initState();
    _handleInitialLink();
    _listenToLinks();
  }

  Future<void> _handleInitialLink() async {
    final initialUri = await getInitialUri();
    _processUri(initialUri);
  }

  void _listenToLinks() {
    _sub = uriLinkStream.listen((uri) {
      _processUri(uri);
    }, onError: (err) {
      print("Deep link error: $err");
    });
  }

  void _processUri(Uri? uri) {
    if (uri != null && uri.queryParameters.containsKey('token')) {
      final token = uri.queryParameters['token']!;
      // Navigate to NewPasswordScreen and pass the token as a parameter
      widget.appRouter.router.go(
        '/new-password?token=$token',
      );
    }
  }

  @override
  void dispose() {
    _sub?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DocPoint(appRouter: widget.appRouter.router);
  }
}
