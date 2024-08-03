import 'package:currency_picker/currency_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_iconpicker_plus/flutter_iconpicker.dart';
import 'package:provider/provider.dart';

import '../../model/budget_category.dart';
import '../../provider/budget_provider.dart';
import '../../widgets/custom_text_form_field.dart';
import '../qalb_saleem/widgets/custom_nav_button.dart';

class AddEditCategoryScreen extends StatefulWidget {
  final BudgetCategory? category;

  const AddEditCategoryScreen({super.key, this.category});

  @override
  _AddEditCategoryScreenState createState() => _AddEditCategoryScreenState();
}

class _AddEditCategoryScreenState extends State<AddEditCategoryScreen> {
  final _formKey = GlobalKey<FormState>();

  late String _name;
  late double _budgetedAmount;
  late double _spentAmount;
  late Color _color;
  late IconData? _icon;
  late String _currencyCode;

  @override
  void initState() {
    super.initState();
    _initializeFields();
  }

  void _initializeFields() {
    final category = widget.category;
    _name = category?.name ?? '';
    _budgetedAmount = category?.budgetedAmount ?? 0;
    _spentAmount = category?.spentAmount ?? 0;
    _color = category?.color ?? Colors.blue;
    _icon = category?.icon ?? Icons.category;
    _currencyCode = category?.currencyCode ?? 'PKR';
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
                _buildAppBar(),
                const SizedBox(height: 20),
                _buildNameField(),
                const SizedBox(height: 16),
                _buildBudgetedAmountField(),
                const SizedBox(height: 16),
                if (widget.category != null) _buildSpentAmountField(),
                const SizedBox(height: 16),
                _buildActionButtons(),
                SizedBox(
                  height: _calculateContentHeight(),
                ),
                _buildFooterButtons(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAppBar() {
    return Row(
      children: [
        CustomNavButton(
          onPress: () => Navigator.pop(context),
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

  Widget _buildNameField() {
    return CustomTextFormField(
      initialValue: _name,
      hintText: 'Category Name',
      prefixIcon: Icons.category,
      validator: (value) => value == null || value.isEmpty
          ? 'Please enter a category name'
          : null,
      onSaved: (value) => _name = value!,
    );
  }

  Widget _buildBudgetedAmountField() {
    return CustomTextFormField(
      initialValue: "$_budgetedAmount",
      inputType: TextInputType.number,
      validator: (value) {
        if (value == null || value.isEmpty)
          return 'Please enter a budgeted amount';
        if (double.tryParse(value) == null)
          return 'Please enter a valid number';
        return null;
      },
      prefixIcon: Icons.money,
      hintText: 'Budgeted Amount',
      onSaved: (value) => _budgetedAmount = double.parse(value!),
    );
  }

  Widget _buildSpentAmountField() {
    return CustomTextFormField(
      initialValue: _spentAmount.toString(),
      hintText: 'Spent Amount',
      inputType: TextInputType.number,
      prefixIcon: Icons.account_balance_wallet_rounded,
      validator: (value) {
        if (value == null || value.isEmpty)
          return 'Please enter a spent amount';
        if (double.tryParse(value) == null)
          return 'Please enter a valid number';
        return null;
      },
      onSaved: (value) => _spentAmount = double.parse(value!),
    );
  }

  Widget _buildActionButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ElevatedButton(
          onPressed: _showColorPicker,
          style: ElevatedButton.styleFrom(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            backgroundColor: _color,
          ),
          child: Text(
            'Pick Color',
            style: Theme.of(context)
                .textTheme
                .bodyLarge!
                .apply(color: Colors.white),
          ),
        ),
        ElevatedButton(
          onPressed: _showIconPicker,
          style: ElevatedButton.styleFrom(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            backgroundColor: const Color(0xff9953FF),
          ),
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            child: Icon(_icon, color: Colors.white, key: ValueKey(_icon)),
          ),
        ),
        ElevatedButton(
          onPressed: _showCurrencyPicker,
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xff9953FF),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          ),
          child: Text(
            _currencyCode,
            style: Theme.of(context).textTheme.titleMedium!.apply(
                  fontSizeFactor: 0.9,
                  color: Colors.white,
                ),
          ),
        ),
      ],
    );
  }

  double _calculateContentHeight() {
    final height = MediaQuery.sizeOf(context).height;
    return widget.category != null ? height * 0.5 : height * 0.55;
  }

  Widget _buildFooterButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        OutlinedButton(
          onPressed: () => Navigator.pop(context),
          style: OutlinedButton.styleFrom(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            fixedSize: const Size(150, 40),
          ),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: _saveCategory,
          style: ElevatedButton.styleFrom(
            fixedSize: const Size(150, 40),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            backgroundColor: const Color(0xff9953FF),
          ),
          child: Text(
            'Save',
            style: Theme.of(context)
                .textTheme
                .bodyLarge!
                .apply(color: Colors.white),
          ),
        ),
      ],
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
              onColorChanged: (color) => setState(() => _color = color),
            ),
          ),
          actions: <Widget>[
            ElevatedButton(
              child: const Text('Got it'),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        );
      },
    );
  }

  void _showIconPicker() async {
    final icon = await FlutterIconPicker.showIconPicker(
      context,
      iconPackModes: [
        IconPack.cupertino,
        IconPack.material,
        IconPack.fontAwesomeIcons,
      ],
      iconPickerShape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
    );
    if (icon != null) {
      setState(() => _icon = icon);
    }
  }

  void _showCurrencyPicker() {
    showCurrencyPicker(
      context: context,
      showFlag: true,
      showCurrencyName: true,
      showCurrencyCode: true,
      onSelect: (Currency currency) =>
          setState(() => _currencyCode = currency.code),
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
        icon: _icon!,
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
