import 'package:flutter/material.dart';

import 'body/dashboard_body.dart';

class DashBoardScreen extends StatelessWidget {
  final String routeName = "/dashboard";
  const DashBoardScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: BodyDashBoardScreen(),
    );
  }
}
