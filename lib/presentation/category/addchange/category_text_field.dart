import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

import '../../state/category/category_title_state.dart';

class CategoryTextField extends StatefulWidget {
  const CategoryTextField({super.key});

  @override
  State<CategoryTextField> createState() => _CategoryTextFieldState();
}

class _CategoryTextFieldState extends State<CategoryTextField> {
  late final TextEditingController _categoryTitleController;

  @override
  void initState() {
    super.initState();
    _categoryTitleController = TextEditingController(text: context.read<CategoryTitleState>().getCategoryTitle);
  }

  @override
  void dispose() {
    _categoryTitleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final appLocale = AppLocalizations.of(context)!;
    return Consumer<CategoryTitleState>(
      builder: (context, categoryTitleState, _) {
        return TextField(
          controller: _categoryTitleController,
          autofocus: categoryTitleState.getCategoryTitle.isEmpty ? true : false,
          textCapitalization: TextCapitalization.sentences,
          keyboardType: TextInputType.text,
          textInputAction: TextInputAction.done,
          maxLength: 75,
          decoration: InputDecoration(
            hintText: appLocale.enterTitle,
            errorText: categoryTitleState.getCategoryTitle.isEmpty ? appLocale.enterTitle : null,
          ),
          onChanged: (String inputValue) {
            categoryTitleState.setCategoryTitle = inputValue;
          },
        );
      },
    );
  }
}
