import 'package:currency_picker/currency_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:intern_test/screens/qalb_saleem/widgets/custom_nav_button.dart';
import 'package:provider/provider.dart';

import 'package:flutter_iconpicker/flutter_iconpicker.dart';
import '../../model/budget_category.dart';
import '../../provider/budget_provider.dart';
import '../../widgets/custom_text_form_field.dart';

class AddEditCategoryScreen extends StatefulWidget {
  final BudgetCategory? category;

  AddEditCategoryScreen({this.category});

  @override
  _AddEditCategoryScreenState createState() => _AddEditCategoryScreenState();
}

class _AddEditCategoryScreenState extends State<AddEditCategoryScreen> {
  final _formKey = GlobalKey<FormState>();
  late String _name;
  late double _budgetedAmount;
  late Color _color;
  late IconData _icon;
  late String _currencyCode;
  double _spentAmount = 0;
  BudgetCategory category = BudgetCategory(id: '', name: '', budgetedAmount: 0);
  @override
  void initState() {
    super.initState();
    _name = widget.category?.name ?? '';
    _budgetedAmount = widget.category?.budgetedAmount ?? 0;
    _spentAmount = widget.category?.spentAmount ?? 0;
    _color = widget.category?.color ?? Colors.blue;
    _icon = widget.category?.icon ?? Icons.category;
    _currencyCode = widget.category?.currencyCode ?? 'PKR';
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 20),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppBarWidget(widget: widget),
                const SizedBox(height: 20),
                CustomTextFormField(
                  initialValue: _name,
                  hintText: 'Category Name',
                  prefixIcon: Icons.category,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a category name';
                    }
                    return null;
                  },
                  onSaved: (value) => _name = value!,
                ),
                const SizedBox(height: 16),
                CustomTextFormField(
                  initialValue: "$_budgetedAmount",
                  inputType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a budgeted amount';
                    }
                    if (double.tryParse(value) == null) {
                      return 'Please enter a valid number';
                    }
                    return null;
                  },
                  prefixIcon: Icons.money,
                  hintText: 'Budgeted Amount',
                  onSaved: (value) => _budgetedAmount = double.parse(value!),
                ),
                const SizedBox(height: 16),
                if (widget.category != null)
                  CustomTextFormField(
                    initialValue: _spentAmount.toString(),
                    hintText: 'Spent Amount',
                    inputType: TextInputType.number,
                    prefixIcon: Icons.account_balance_wallet_rounded,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a spent amount';
                      }
                      if (double.tryParse(value) == null) {
                        return 'Please enter a valid number';
                      }
                      return null;
                    },
                    onSaved: (value) => _spentAmount = double.parse(value!),
                  ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      onPressed: _showColorPicker,
                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          backgroundColor: _color),
                      child: Text(
                        'Pick Color',
                        style: Theme.of(context).textTheme.bodyLarge!.apply(
                              color: Colors.white,
                            ),
                      ),
                    ),
                    // const SizedBox(width: 16),
                    ElevatedButton(
                      onPressed: _showIconPicker,
                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          backgroundColor: const Color(0xff9953FF)),
                      child: Icon(_icon, color: Colors.white),
                    ),
                    ElevatedButton(
                      onPressed: _showCurrencyPicker,
                      style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xff9953FF),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10))),
                      child: Text(
                        _currencyCode,
                        style: Theme.of(context).textTheme.titleMedium!.apply(
                              fontSizeFactor: 0.9,
                              color: Colors.white,
                            ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: widget.category != null
                      ? MediaQuery.sizeOf(context).height * 0.5
                      : MediaQuery.sizeOf(context).height * 0.55,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    OutlinedButton(
                      onPressed: () => Navigator.pop(context),
                      style: OutlinedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12)),
                          fixedSize: const Size(150, 40)),
                      child: const Text('Cancel'),
                    ),
                    ElevatedButton(
                      onPressed: _saveCategory,
                      style: ElevatedButton.styleFrom(
                          fixedSize: const Size(150, 40),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          backgroundColor: const Color(0xff9953FF)),
                      child: Text(
                        'Save',
                        style: Theme.of(context).textTheme.bodyLarge!.apply(
                              color: Colors.white,
                            ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showColorPicker() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Pick a color'),
          content: SingleChildScrollView(
            child: ColorPicker(
              pickerColor: _color,
              onColorChanged: (Color color) {
                setState(() => _color = color);
              },
            ),
          ),
          actions: <Widget>[
            ElevatedButton(
              child: const Text('Got it'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _showIconPicker() async {
    IconData? icon = await showIconPicker(
      context,
      iconPackModes: [
        IconPack.cupertino,
        IconPack.material,
        IconPack.allMaterial,
        IconPack.fontAwesomeIcons,
      ],
      iconPickerShape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
    );
    if (icon != null) {
      _icon = Icon(icon) as IconData;
      setState(() {});
    }
    // IconData? icon = await showIconPicker(
    //   context,
    //   iconPackModes: [IconPack.cupertino],
    //   adaptiveDialog: true,
    // );
    //
    // if (icon != null) {
    //   setState(() => _icon = icon);
    // }
  }

  void _showCurrencyPicker() {
    showCurrencyPicker(
      context: context,
      showFlag: true,
      showCurrencyName: true,
      showCurrencyCode: true,
      onSelect: (Currency currency) {
        setState(() => _currencyCode = currency.code);
      },
    );
  }

  void _saveCategory() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      final budgetProvider =
          Provider.of<BudgetProvider>(context, listen: false);
      final category = BudgetCategory(
        id: widget.category?.id ?? DateTime.now().toString(),
        name: _name,
        budgetedAmount: _budgetedAmount,
        spentAmount: _spentAmount,
        color: _color,
        icon: _icon,
        currencyCode: _currencyCode,
      );
      if (widget.category == null) {
        budgetProvider.addCategory(category);
      } else {
        budgetProvider.updateCategory(category);
      }
      Navigator.pop(context);
    }
  }
}

class AppBarWidget extends StatelessWidget {
  const AppBarWidget({
    super.key,
    required this.widget,
  });

  final AddEditCategoryScreen widget;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CustomNavButton(
          onPress: () {
            Navigator.pop(context);
          },
          buttonColor: Colors.black87,
          icon: Icons.arrow_back_ios_new_rounded,
        ),
        const SizedBox(width: 10),
        Text(
          widget.category == null ? 'Add Category' : 'Edit Category',
          style: Theme.of(context)
              .textTheme
              .titleLarge!
              .apply(fontSizeFactor: 0.8),
        ),
      ],
    );
  }
}
