import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../enums/persistence_enums.dart';
import '../state/settings_model.dart';
import '../util/io_service.dart';
import '../widgets/layout/drawer.dart';

class SettingsScreen extends StatefulWidget {
  final String title;

  const SettingsScreen({super.key, required this.title});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  late SaveMethod _selectedSaveMethod;
  late SaveLocationOption _selectedSaveLocationOption;
  final TextEditingController _customSaveLocationController =
      TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _showNoValidationErrors = false;
  bool _uiIsBlocked = false;

  @override
  void initState() {
    super.initState();
    getStateFromSettingsModel();
    context.read<SettingsModel>().addListener(getStateFromSettingsModel);
  }

  @override
  void dispose() {
    super.dispose();
    _customSaveLocationController.dispose();
  }

  void getStateFromSettingsModel() {
    if (mounted) {
      setState(() {
        SettingsModel settings = context.read<SettingsModel>();
        _selectedSaveMethod = settings.selectedSaveMethod;
        _selectedSaveLocationOption = settings.selectedSaveLocationOption;
        if (settings.customSaveLocation != null) {
          _customSaveLocationController.text = settings.customSaveLocation!;
        }
      });
    }
  }

  void submitForm() {
    if (_formKey.currentState!.validate()) {
      SettingsModel settings = context.read<SettingsModel>();
      settings.setData(
          _selectedSaveMethod,
          _selectedSaveLocationOption,
          _selectedSaveLocationOption == SaveLocationOption.customLocation
              ? _customSaveLocationController.text
              : settings.customSaveLocation).then((_) {
        settings.writeSettingsStateToFile().then((_) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Settings Saved'),
              duration: Duration(seconds: 2),
            ),
          );
        }
        );
      });
    }
  }

  void clearValidationErrors() {
    _showNoValidationErrors = true;
    _formKey.currentState!.validate();
    _showNoValidationErrors = false;
  }

  void openFilePicker() async {
    SettingsModel settings = context.read<SettingsModel>();
    setState(() => _uiIsBlocked = true);
    String initialDirectory =
        await Directory(_customSaveLocationController.text).exists()
            ? _customSaveLocationController.text
            : settings.customSaveLocation != null &&
                    await Directory(settings.customSaveLocation!).exists()
                ? settings.customSaveLocation!
                : await IOService.defaultPath;
    String? selectedDirectory = await FilePicker.platform
        .getDirectoryPath(initialDirectory: initialDirectory);
    setState(() => _uiIsBlocked = false);
    if (selectedDirectory != null) {
      _customSaveLocationController.text = selectedDirectory;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: [
          Scaffold(
            appBar: AppBar(
              backgroundColor: Theme.of(context).colorScheme.primary,
              foregroundColor: Theme.of(context).colorScheme.onPrimary,
              title: Text(widget.title),
            ),
            drawer: const BudgeteeroDrawer(),
            body: Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 20, left: 50, right: 50),
                child: Container(
                  constraints: const BoxConstraints(maxWidth: 400),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        const Text(
                          'Persistence Settings',
                          style: TextStyle(fontSize: 18),
                        ),
                        const SizedBox(height: 15),
                        const Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'How should data be saved?',
                            style: TextStyle(fontSize: 15),
                          ),
                        ),
                        const SizedBox(height: 5),
                        SizedBox(
                          height: 36,
                          child: RadioListTile<SaveMethod>(
                            contentPadding: EdgeInsets.zero,
                            dense: true,
                            title: const Text(
                              'Automatically with every change',
                              style: TextStyle(fontSize: 14),
                            ),
                            value: SaveMethod.auto,
                            groupValue: _selectedSaveMethod,
                            onChanged: (value) {
                              clearValidationErrors();
                              setState(() => _selectedSaveMethod = value!);
                            },
                          ),
                        ),
                        SizedBox(
                          height: 36,
                          child: RadioListTile<SaveMethod>(
                            contentPadding: EdgeInsets.zero,
                            dense: true,
                            title: const Text(
                              'Manually',
                              style: TextStyle(fontSize: 14),
                            ),
                            value: SaveMethod.manual,
                            groupValue: _selectedSaveMethod,
                            onChanged: (value) {
                              clearValidationErrors();
                              setState(() => _selectedSaveMethod = value!);
                            },
                          ),
                        ),
                        const SizedBox(height: 15),
                        const Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Where should data be saved?',
                            style: TextStyle(fontSize: 15),
                          ),
                        ),
                        const SizedBox(height: 5),
                        SizedBox(
                          height: 36,
                          child: RadioListTile<SaveLocationOption>(
                            contentPadding: EdgeInsets.zero,
                            dense: true,
                            title: const Text(
                              'Default system location',
                              style: TextStyle(fontSize: 14),
                            ),
                            value: SaveLocationOption.defaultLocation,
                            groupValue: _selectedSaveLocationOption,
                            onChanged: (value) {
                              clearValidationErrors();
                              setState(
                                  () => _selectedSaveLocationOption = value!);
                              _customSaveLocationController.text = context
                                      .read<SettingsModel>()
                                      .customSaveLocation ??
                                  '';
                            },
                          ),
                        ),
                        SizedBox(
                          height: 36,
                          child: RadioListTile<SaveLocationOption>(
                            contentPadding: EdgeInsets.zero,
                            dense: true,
                            title: const Text(
                              'Select a directory:',
                              style: TextStyle(fontSize: 14),
                            ),
                            value: SaveLocationOption.customLocation,
                            groupValue: _selectedSaveLocationOption,
                            onChanged: (value) {
                              clearValidationErrors();
                              setState(
                                  () => _selectedSaveLocationOption = value!);
                            },
                          ),
                        ),
                        const SizedBox(height: 8),
                        Padding(
                          padding: const EdgeInsets.only(left: 40),
                          child: TextFormField(
                            controller: _customSaveLocationController,
                            enabled: _selectedSaveLocationOption ==
                                SaveLocationOption.customLocation,
                            validator: (value) {
                              if (_showNoValidationErrors) return null;
                              if (_selectedSaveLocationOption ==
                                  SaveLocationOption.customLocation) {
                                if (!Directory(
                                        _customSaveLocationController.text)
                                    .existsSync()) {
                                  return "Must select an existing folder!";
                                }
                              }
                              return null;
                            },
                            style: const TextStyle(fontSize: 14),
                            decoration: InputDecoration(
                              isDense: true,
                              suffixIcon: ClipRRect(
                                child: InkWell(
                                  customBorder: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.horizontal(
                                        right: Radius.circular(8)),
                                  ),
                                  onTap: openFilePicker,
                                  child: const Icon(Icons.folder_outlined),
                                ),
                              ),
                              fillColor: Theme.of(context).highlightColor,
                              filled: _selectedSaveLocationOption !=
                                  SaveLocationOption.customLocation,
                              contentPadding: const EdgeInsets.all(10),
                              border: const OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(8.0))),
                              hintText: _selectedSaveLocationOption ==
                                      SaveLocationOption.customLocation
                                  ? 'Please enter a save directory'
                                  : '',
                              hintStyle: TextStyle(
                                  fontSize: 14,
                                  color: Theme.of(context)
                                      .hintColor
                                      .withAlpha(100)),
                            ),
                            onFieldSubmitted: (_) => submitForm(),
                          ),
                        ),
                        const SizedBox(height: 20.0),
                        ElevatedButton(
                          onPressed: submitForm,
                          child: const Text('Submit'),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          if (_uiIsBlocked)
            const Opacity(
              opacity: 0.6,
              child: ModalBarrier(dismissible: false, color: Colors.black),
            ),
        ],
      ),
    );
  }
}
