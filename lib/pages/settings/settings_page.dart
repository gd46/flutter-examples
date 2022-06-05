import 'package:flutter/material.dart';
import 'package:flutter_sample_app/notifiers/app_settings_notifier.dart';
import 'package:provider/provider.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _appSettings = Provider.of<AppSettingsNotifier>(context);

    return Scaffold(
      persistentFooterButtons: [
        Center(
          child: ElevatedButton(
              onPressed: () async {
                await _appSettings.clear();
              },
              child: const Text('Restore default settings')),
        )
      ],
      body: Column(
        children: [
          SwitchListTile(
              title: const Text('Dark Theme'),
              value: _appSettings.isDarkModeEnabled,
              onChanged: (bool? value) {
                _appSettings.isDarkModeEnabled = value ?? false;
              }),
        ],
      ),
    );
  }
}
