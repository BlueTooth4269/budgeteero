import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../enums/persistence_enums.dart';
import '../../state/data_model.dart';
import '../../state/settings_model.dart';
import 'drawer.dart';
import 'loading_overlay.dart';

class PageLayoutFrame extends StatelessWidget {
  final Widget child;
  final String title;

  const PageLayoutFrame({super.key, required this.child, required this.title});

  void saveState(BuildContext context) {
    context.read<DataModel>().writeDataStateToFile();
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Changes Saved'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.primary,
          foregroundColor: Theme.of(context).colorScheme.onPrimary,
          title: Text(title),
        ),
        drawer: const BudgeteeroDrawer(),
        floatingActionButton:
            context.select((SettingsModel settings) => settings.selectedSaveMethod) ==
                        SaveMethod.manual &&
                    context.select((DataModel data) => data.unsavedChanges)
                ? FloatingActionButton(
                    onPressed: () => saveState(context),
                    foregroundColor: Theme.of(context).colorScheme.background,
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    shape: const CircleBorder(),
                    child: const Icon(Icons.save),
                  )
                : null,
        body: LoadingOverlay(
            isLoading: !context
                .select((DataModel data) => data.finishedLoadingFromFile),
            child: Center(child: child)),
      ),
    );
  }
}
