import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_left_right_container/left_right_container.dart';
import 'package:form_builder_multi_dropdown/form_builder_multi_dropdown.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

import 'data/mock_data.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FormBuilderMultiDropdown Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const DemoDashboardPage(),
    );
  }
}

class DemoDashboardPage extends StatefulWidget {
  const DemoDashboardPage({super.key});

  @override
  State<DemoDashboardPage> createState() => _DemoDashboardPageState();
}

class _DemoDashboardPageState extends State<DemoDashboardPage> {
  final _formKey = GlobalKey<FormBuilderState>();

  // Controller to programmatically interact with the framework dropdown feature
  final MultiSelectController<String> _frameworkController =
      MultiSelectController<String>();

  String _formOutputLog = 'No data submitted yet.';
  int _selectedDemoIndex = 0;

  void _submitForm() {
    // Standard FormBuilder validation philosophy integrated with form_builder_validators
    final bool isValid = _formKey.currentState?.saveAndValidate() ?? false;
    if (isValid) {
      setState(() {
        _formOutputLog = 'Success:\n${_formKey.currentState?.value.toString()}';
      });
    } else {
      setState(() {
        _formOutputLog = 'Validation Failed!';
      });
    }
  }

  void _resetForm() {
    _formKey.currentState?.reset();
    _frameworkController.clearAll();
    setState(() {
      _formOutputLog = 'Form cleared.';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('FormBuilderMultiDropdown - Showcase Panel'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        actions: [
          TextButton.icon(
            onPressed: _resetForm,
            icon: const Icon(Icons.refresh),
            label: const Text('Reset'),
          ),
        ],
      ),
      // Utilizing flutter_left_right_container split-view architecture
      body: LeftRightContainer(
        fixedSizeWidth: 320.0,
        minSideWidth: 320.0,
        start: Material(
          color: Colors.grey.shade50,
          child: ListView(
            padding: const EdgeInsets.symmetric(vertical: 12.0),
            children: [
              const Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  'Dropdown Scenarios',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
              ),
              _buildMenuTile(0, 'Standard Multi-Select', Icons.layers),
              _buildMenuTile(1, 'Single Select Mode', Icons.adjust),
              _buildMenuTile(
                2,
                'Async Search & Custom Row',
                Icons.cloud_download,
              ),
              _buildMenuTile(3, 'Decoration & Controller', Icons.tune),
              const Divider(height: 40),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: ElevatedButton.icon(
                  onPressed: _submitForm,
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size.fromHeight(48),
                  ),
                  icon: const Icon(Icons.check_circle_outline),
                  label: const Text('Validate & Submit'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Card(
                  color: Colors.grey.shade900,
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Text(
                      _formOutputLog,
                      style: const TextStyle(
                        color: Colors.greenAccent,
                        fontFamily: 'monospace',
                        fontSize: 12,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        // Right side displays the specific content based on selected options
        end: Padding(
          padding: const EdgeInsets.all(24.0),
          child: FormBuilder(
            key: _formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _getScenarioTitle(),
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    _getScenarioDescription(),
                    style: TextStyle(color: Colors.grey.shade600),
                  ),
                  const Divider(height: 32),
                  _buildActiveScenarioWidget(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMenuTile(int index, String title, IconData icon) {
    final isSelected = _selectedDemoIndex == index;
    return ListTile(
      leading: Icon(
        icon,
        color: isSelected ? Theme.of(context).colorScheme.primary : Colors.grey,
      ),
      title: Text(
        title,
        style: TextStyle(
          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
        ),
      ),
      selected: isSelected,
      onTap: () => setState(() => _selectedDemoIndex = index),
    );
  }

  String _getScenarioTitle() {
    switch (_selectedDemoIndex) {
      case 0:
        return 'Standard Multi-Select Configuration';
      case 1:
        return 'Single Choice Strategy';
      case 2:
        return 'Asynchronous Filtering & Custom Templates';
      case 3:
        return 'Styling Options & Programmatic Controller';
      default:
        return '';
    }
  }

  String _getScenarioDescription() {
    switch (_selectedDemoIndex) {
      case 0:
        return 'Demonstrates multi-object mapping with direct standard validations required rule.';
      case 1:
        return 'Enforces a strict isolated single item picker behavior via internal constraints.';
      case 2:
        return 'Fetches data dynamically through overlay portals matching localized search queries with specialized lists.';
      case 3:
        return 'Applies customizable FaColors token configurations, localized borders, chips and external buttons.';
      default:
        return '';
    }
  }

  Widget _buildActiveScenarioWidget() {
    // Explicit clean view rendered conditionally per index
    switch (_selectedDemoIndex) {
      case 0:
        return _buildStandardMultiDropdown();
      case 1:
        return _buildMultiDropdownSingleSelection();
      case 2:
        return _buildMultiDropdownSearchAndCustomRow();
      case 3:
        return _buildMultiDropdownDecorationAndController();
      default:
        return const SizedBox.shrink();
    }
  }

  Widget _buildStandardMultiDropdown() {
    return FormBuilderMultiDropdown<ProgrammingLanguage>(
      name: 'languages_multi',
      items: MockData.languages,
      searchEnabled: true,
      getItemText: (item) => item.name,
      fieldDecoration: const FieldDecoration(
        labelText: 'Select Preferred Languages',
        borderRadius: 8,
      ),
      // Adhering to form_builder_validators ecosystem standards
      validator: FormBuilderValidators.compose([
        FormBuilderValidators.required(
          errorText: 'You must choose at least one item.',
        ),
      ]),
    );
  }

  Widget _buildMultiDropdownSingleSelection() {
    return FormBuilderMultiDropdown<Country>(
      name: 'country_single',
      items: MockData.countries,
      singleSelect: true,
      getItemText: (item) => item.name,
      fieldDecoration: const FieldDecoration(
        labelText: 'Country of Origin (Single)',
        borderRadius: 8,
      ),
      validator: FormBuilderValidators.compose([
        FormBuilderValidators.required(
          errorText: 'Country declaration is mandatory.',
        ),
      ]),
    );
  }

  Widget _buildMultiDropdownSearchAndCustomRow() {
    return FormBuilderMultiDropdown<ProgrammingLanguage>(
      name: 'languages_async',
      items: const [],
      // Keep empty, let future fetch the initial list
      searchEnabled: true,
      // Fetches the full list asynchronously on initialize
      future: () => MockData.fetchLanguagesAsync(),
      getItemText: (item) => item.name,
      fieldDecoration: const FieldDecoration(
        labelText: 'Async Remote Repository Lookup',
        borderRadius: 8,
      ),
      // Triggered whenever the user types in the search box
      onSearchChange: (query) {
        debugPrint('User is searching for: $query');
        // The internal controller will automatically filter the items
        // fetched by 'future' based on their labels.
      },
      itemBuilder: (item, index, onTap) {
        final lang = item.value;
        return ListTile(
          leading: CircleAvatar(child: Text(lang.name[0])),
          title: Text(lang.name),
          subtitle: Text('Maintained by: ${lang.creator}'),
          onTap: onTap,
        );
      },
      validator: FormBuilderValidators.compose([
        FormBuilderValidators.required(errorText: 'Please select a language.'),
      ]),
    );
  }

  Widget _buildMultiDropdownDecorationAndController() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FormBuilderMultiDropdown<String>(
          name: 'frameworks_styled',
          controller: _frameworkController,
          items: MockData.frameworks,
          getItemText: (item) => item,
          searchEnabled: false,
          chipDecoration: ChipDecoration(
            backgroundColor: Colors.deepPurple.shade50,
            labelStyle: const TextStyle(
              color: Colors.deepPurple,
              fontWeight: FontWeight.w500,
            ),
            borderRadius: BorderRadius.circular(4),
            spacing: 6,
          ),
          dropdownDecoration: DropdownDecoration(
            maxHeight: 250,
            borderRadius: BorderRadius.circular(12),
            expandDirection: ExpandDirection.auto,
          ),
          fieldDecoration: const FieldDecoration(
            labelText: 'Frameworks (Custom Tokens & Controller)',
            borderRadius: 16,
          ),
          validator: FormBuilderValidators.compose([
            FormBuilderValidators.required(
              errorText: 'Styled elements tracking requires an entry.',
            ),
          ]),
        ),
        const SizedBox(height: 16),
        Wrap(
          spacing: 8,
          children: [
            ActionChip(
              avatar: const Icon(Icons.add, size: 16),
              label: const Text('Inject Flutter'),
              onPressed: () {
                // Simulating programmatic interaction using package controller features
                final current = _frameworkController.selectedItems
                    .map((e) => e.value)
                    .toList();
                if (!current.contains('Flutter')) {
                  _frameworkController.selectWhere((e) => e.value == 'Flutter');
                }
              },
            ),
            ActionChip(
              avatar: const Icon(Icons.clear_all, size: 16),
              label: const Text('Clear Options'),
              onPressed: () => _frameworkController.clearAll(),
            ),
          ],
        ),
      ],
    );
  }
}
