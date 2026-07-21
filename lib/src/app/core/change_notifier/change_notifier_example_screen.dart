import 'package:flutter/material.dart';


class ChangeNotifierExampleScreen extends StatelessWidget {
  const ChangeNotifierExampleScreen();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Change Notifier Example'),
      ),
      body: Column(
        children: <Widget>[
        //  const WarningWidgetChangeNotifier(),
        ],
      ),
    );
  }
}
