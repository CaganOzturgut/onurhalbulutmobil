import 'package:flutter/material.dart';
import 'package:select_searchable_list/select_searchable_list.dart';

class SelectSearchableListExample extends StatefulWidget {
  const SelectSearchableListExample({
    Key? key,
  }) : super(key: key);

  @override
  State<SelectSearchableListExample> createState() =>
      _SelectSearchableListExampleState();
}

class _SelectSearchableListExampleState
    extends State<SelectSearchableListExample> {

  final Map<int, String> _listCategories = {
    1: 'Çilek',
    2: 'Portakal',
    3: 'Muz',
    4: 'Kivi',
    5: 'Ananas',
    6: 'Elma',
    7: 'Greyfurt',
    8: 'Kiraz'
  };

  final List<int> _selectedCategoryValue = [1];


  final List<int> _selectedColorValues = [2, 4];

  /// This is register text field controllers.
  final TextEditingController _productNameTextEditingController =
  TextEditingController();
  final TextEditingController _categoryTextEditingController =
  TextEditingController();
  final TextEditingController _colorsTextEditingController =
  TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _productNameTextEditingController.dispose();
    _categoryTextEditingController.dispose();
    _colorsTextEditingController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: _bodyApp(),
      ),
    );
  }

  /// This is Main Body widget.
  Widget _bodyApp() {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DropDownTextField(
            textEditingController: _categoryTextEditingController,
            title: 'Category',
            hint: 'Select Category',
            options: _listCategories,
            selectedOptions: _selectedCategoryValue,
            onChanged: (selectedIds) {
              // setState(() => selectedIds);
              // print(selectedIds);
            },
            // style: const TextStyle(
            //   fontSize: 16.0,
            //   color: Colors.red,
            // ),
          ),
        ],
      ),
    );
  }
}
