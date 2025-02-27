import 'package:flutter/material.dart';

import '../../l10n/extensions/localizations_ext.dart';
import '../base_button/base_value_button.dart';
import '../config/simple_toolbar_config.dart';
import 'quill_icon_button.dart';

typedef QuillToolbarIndentBaseButton = QuillToolbarBaseButton<
    QuillToolbarIndentButtonOptions, QuillToolbarIndentButtonExtraOptions>;

typedef QuillToolbarIndentBaseButtonState<W extends QuillToolbarIndentButton>
    = QuillToolbarCommonButtonState<W, QuillToolbarIndentButtonOptions,
        QuillToolbarIndentButtonExtraOptions>;

class QuillToolbarIndentButton extends QuillToolbarIndentBaseButton {
  const QuillToolbarIndentButton({
    required super.controller,
    required this.isIncrease,
    super.options = const QuillToolbarIndentButtonOptions(),

    /// Shares common options between all buttons, prefer the [options]
    /// over the [baseOptions].
    super.baseOptions,
    super.key,
  });

  final bool isIncrease;

  @override
  QuillToolbarIndentButtonState createState() =>
      QuillToolbarIndentButtonState();
}

class QuillToolbarIndentButtonState extends QuillToolbarIndentBaseButtonState {
  @override
  String get defaultTooltip => widget.isIncrease
      ? context.loc.increaseIndent
      : context.loc.decreaseIndent;

  @override
  IconData get defaultIconData => widget.isIncrease
      ? Icons.format_indent_increase
      : Icons.format_indent_decrease;

  void _sharedOnPressed() {
    widget.controller.indentSelection(widget.isIncrease);
  }

  @override
  Widget build(BuildContext context) {
    final childBuilder = this.childBuilder;

    if (childBuilder != null) {
      return childBuilder(
        options,
        QuillToolbarIndentButtonExtraOptions(
          controller: controller,
          context: context,
          onPressed: () {
            _sharedOnPressed();
            afterButtonPressed?.call();
          },
        ),
      );
    }

    return QuillToolbarIconButton(
      tooltip: tooltip,
      icon: Icon(
        iconData,
        size: iconSize * iconButtonFactor,
        // color: iconColor,
      ),
      isSelected: false,
      onPressed: _sharedOnPressed,
      afterPressed: afterButtonPressed,
      iconTheme: iconTheme,
    );
  }
}
