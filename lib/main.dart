import 'package:budgeteero/state/data_model.dart';
import 'package:budgeteero/state/settings_model.dart';
import 'package:budgeteero/util/routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider<SettingsModel>(
              create: (_) => SettingsModel(), lazy: false),
          ChangeNotifierProxyProvider<SettingsModel, DataModel>(
            create: (_) => DataModel(),
            update: (_, SettingsModel settingsModel, DataModel? dataModel) {
              if (settingsModel.finishedLoadingFromFile) {
                dataModel!
                    .initialiseDataFromFile(settingsModel.currentSaveLocation);
              }
              return dataModel!;
            },
          ),
        ],
        child: MaterialApp(
          title: 'Budgeteero',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
            appBarTheme: AppBarTheme(
              iconTheme:
                  IconThemeData(color: Theme.of(context).colorScheme.onPrimary),
            ),
          ),
          routes: Routes.routingTable,
        ));
  }
}
