import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

import '../../state/market/market_title_state.dart';

class MarketTextField extends StatefulWidget {
  const MarketTextField({super.key});

  @override
  State<MarketTextField> createState() => _MarketTextFieldState();
}

class _MarketTextFieldState extends State<MarketTextField> {
  late final TextEditingController _marketTitleController;

  @override
  void initState() {
    super.initState();
    _marketTitleController = TextEditingController(text: context.read<MarketTitleState>().getMarketTitle);
  }

  @override
  void dispose() {
    _marketTitleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final appLocale = AppLocalizations.of(context)!;
    return Consumer<MarketTitleState>(
      builder: (context, marketTitleState, _) {
        return TextField(
          controller: _marketTitleController,
          autofocus: marketTitleState.getMarketTitle.isEmpty ? true : false,
          textCapitalization: TextCapitalization.sentences,
          keyboardType: TextInputType.text,
          textInputAction: TextInputAction.done,
          maxLength: 75,
          decoration: InputDecoration(
            hintText: appLocale.enterTitle,
            errorText: marketTitleState.getMarketTitle.isEmpty ? appLocale.enterTitle : null,
          ),
          onChanged: (String inputValue) {
            marketTitleState.setMarketTitle = inputValue;
          },
        );
      },
    );
  }
}
