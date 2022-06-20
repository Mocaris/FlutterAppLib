import 'dart:ui';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

enum OverlayVisibilityMode {
  /// Overlay will never appear regardless of the text entry state.
  never,

  /// Overlay will only appear when the current text entry is not empty.
  ///
  /// This includes prefilled text that the user did not type in manually. But
  /// does not include text in placeholders.
  editing,

  /// Overlay will only appear when the current text entry is empty.
  ///
  /// This also includes not having prefilled text that the user did not type
  /// in manually. Texts in placeholders are ignored.
  notEditing,

  /// Always show the overlay regardless of the text entry state.
  always,
}

class EditText extends StatefulWidget {
  final String? restorationId;
  final TextEditingController controller;
  final bool obscureText;
  final List<TextInputFormatter>? inputFormatters;
  final Iterable<String>? autofillHints;
  final TextInputAction? textInputAction;
  final TextInputType? keyboardType;
  final ValueChanged<String>? onSubmitted;
  final ValueChanged<String>? onChanged;
  final FocusNode? focusNode;
  final TextStyle? style;
  final String? hintText;
  final TextStyle? hintStyle;
  final TextAlign textAlign;
  final TextAlignVertical? textAlignVertical;
  final bool autofocus;
  final bool readOnly;
  final double cursorWidth;
  final Radius? cursorRadius;
  final StrutStyle? strutStyle;
  final int? maxLines;
  final int? minLines;
  final Color? cursorColor;
  final BoxDecoration? decoration;
  final EdgeInsetsGeometry padding;
  final Widget? prefix;
  final OverlayVisibilityMode prefixMode;
  final Widget? suffix;
  final OverlayVisibilityMode suffixMode;
  final bool? selectionEnabled;
  final TextDirection? textDirection;
  final TextCapitalization textCapitalization;
  final bool? showCursor;
  final String obscuringCharacter;
  final bool autocorrect;
  final bool enableSuggestions;
  final bool expands;

  final VoidCallback? onEditingComplete;
  final bool? enabled;
  final double? cursorHeight;
  final BoxHeightStyle selectionHeightStyle;
  final BoxWidthStyle selectionWidthStyle;
  final Brightness? keyboardAppearance;
  final EdgeInsets scrollPadding;
  final DragStartBehavior dragStartBehavior;
  final TextSelectionControls? selectionControls;
  final GestureTapCallback? onTap;
  final ScrollController? scrollController;
  final ScrollPhysics? scrollPhysics;
  final Clip clipBehavior;
  final bool scribbleEnabled;
  final bool enableIMEPersonalizedLearning;
  final OverlayVisibilityMode clearButtonMode;
  final ToolbarOptions? toolbarOptions;
  final SmartDashesType? smartDashesType;
  final SmartQuotesType? smartQuotesType;

  const EditText({
    Key? key,
    required this.controller,
    this.focusNode,
    this.decoration = const BoxDecoration(),
    this.padding = const EdgeInsets.all(6.0),
    this.hintText,
    this.hintStyle,
    this.prefix,
    this.prefixMode = OverlayVisibilityMode.always,
    this.suffix,
    this.suffixMode = OverlayVisibilityMode.always,
    this.clearButtonMode = OverlayVisibilityMode.editing,
    this.textInputAction,
    this.textCapitalization = TextCapitalization.none,
    this.style,
    this.strutStyle,
    this.textAlign = TextAlign.start,
    this.textAlignVertical = TextAlignVertical.center,
    this.textDirection,
    this.readOnly = false,
    this.toolbarOptions,
    this.showCursor,
    this.autofocus = false,
    this.obscuringCharacter = '●',
    this.obscureText = false,
    this.autocorrect = true,
    this.smartDashesType,
    this.smartQuotesType,
    this.enableSuggestions = true,
    this.maxLines = 1,
    this.minLines,
    this.expands = false,
    this.onChanged,
    this.onEditingComplete,
    this.onSubmitted,
    this.inputFormatters,
    this.enabled,
    this.cursorWidth = 2.0,
    this.cursorHeight,
    this.cursorRadius = const Radius.circular(1.0),
    this.cursorColor,
    this.selectionHeightStyle = BoxHeightStyle.tight,
    this.selectionWidthStyle = BoxWidthStyle.tight,
    this.keyboardAppearance,
    this.scrollPadding = const EdgeInsets.all(20.0),
    this.dragStartBehavior = DragStartBehavior.start,
    this.selectionControls,
    this.onTap,
    this.scrollController,
    this.scrollPhysics,
    this.autofillHints = const <String>[],
    this.clipBehavior = Clip.hardEdge,
    this.restorationId,
    this.scribbleEnabled = true,
    this.enableIMEPersonalizedLearning = true,
    this.keyboardType,
    this.selectionEnabled,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => EditTextState();
}

class EditTextState extends State<EditText> {
  bool _obscureText = true;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.obscureText;
  }

  @override
  Widget build(BuildContext context) {
    var themeData = Theme.of(context);
    var textStyle = widget.style ?? themeData.textTheme.bodyText2;
    var hintStyle = widget.hintStyle ??
        (themeData.inputDecorationTheme.hintStyle ?? textStyle)
            ?.copyWith(color: themeData.hintColor);
    var brightness = themeData.brightness;
    return ValueListenableBuilder(
      valueListenable: widget.controller,
      builder: (BuildContext context, TextEditingValue value, Widget? child) {
        var editingValue = widget.controller.value;
        return TextField(
            controller: widget.controller,
            readOnly: widget.readOnly,
            toolbarOptions: widget.toolbarOptions,
            showCursor: widget.showCursor,
            focusNode: widget.focusNode,
            keyboardType: widget.keyboardType,
            textInputAction: widget.textInputAction,
            textCapitalization: widget.textCapitalization,
            style: textStyle,
            strutStyle: widget.strutStyle,
            textAlign: widget.textAlign,
            textDirection: widget.textDirection,
            autofocus: widget.autofocus,
            obscuringCharacter: widget.obscuringCharacter,
            obscureText: _obscureText,
            autocorrect: widget.autocorrect,
            smartDashesType: widget.smartDashesType,
            smartQuotesType: widget.smartQuotesType,
            enableSuggestions: widget.enableSuggestions,
            maxLines: widget.maxLines,
            minLines: widget.minLines,
            expands: widget.expands,
            onChanged: widget.onChanged,
            onEditingComplete: widget.onEditingComplete,
            onSubmitted: widget.onSubmitted,
            inputFormatters: widget.inputFormatters,
            cursorWidth: widget.cursorWidth,
            cursorHeight: widget.cursorHeight,
            cursorRadius: widget.cursorRadius,
            cursorColor: widget.cursorColor,
            selectionHeightStyle: widget.selectionHeightStyle,
            selectionWidthStyle: widget.selectionWidthStyle,
            scrollPadding: widget.scrollPadding,
            keyboardAppearance: widget.keyboardAppearance,
            dragStartBehavior: widget.dragStartBehavior,
            scrollController: widget.scrollController,
            scrollPhysics: widget.scrollPhysics,
            enableInteractiveSelection: widget.selectionEnabled,
            clipBehavior: widget.clipBehavior,
            restorationId: widget.restorationId,
            scribbleEnabled: widget.scribbleEnabled,
            enableIMEPersonalizedLearning: widget.enableIMEPersonalizedLearning,
            autofillHints: widget.autofillHints,
            onTap: widget.onTap,
            textAlignVertical: widget.textAlignVertical,
            decoration: InputDecoration(
                hintStyle: hintStyle,
                hintText: widget.hintText,
                border: InputBorder.none,
                filled: false,
                isCollapsed: true,
                isDense: true,
                alignLabelWithHint: true,
                contentPadding: EdgeInsets.zero,
                prefix: _showPrefixWidget(editingValue) ? widget.prefix : null,
                suffixIcon: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      if ((widget.enabled ?? true) &&
                          _showClearButton(editingValue))
                        _clearButtonWidget(brightness),
                      if (widget.obscureText) _passwordWidget(brightness),
                      if (_showSuffixWidget(editingValue)) widget.suffix!,
                    ])));
      },
    );
  }

  Color _iconColor(Brightness brightness) =>
      brightness == Brightness.light
          ? const Color(0x33000000)
          : const Color(0x33FFFFFF);

  Widget _clearButtonWidget(Brightness brightness) {
    return GestureDetector(
      onTap: () => widget.controller.clear(),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 3.0),
        child: Icon(Icons.cancel, color: _iconColor(brightness), size: 18),
      ),
    );
  }

  Widget _passwordWidget(Brightness brightness) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _obscureText = !_obscureText;
        });
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 3.0),
        child: Icon(
            _obscureText ? Icons.visibility_sharp : Icons.visibility_off_sharp,
            color: _iconColor(brightness),
            size: 18),
      ),
    );
  }

  bool _showPrefixWidget(TextEditingValue text) {
    return widget.prefix != null &&
        _shouldShowAttachment(
          attachment: widget.prefixMode,
          hasText: text.text.isNotEmpty,
        );
  }

  bool _showSuffixWidget(TextEditingValue text) {
    return widget.suffix != null &&
        _shouldShowAttachment(
          attachment: widget.suffixMode,
          hasText: text.text.isNotEmpty,
        );
  }

  bool _showClearButton(TextEditingValue text) {
    return _shouldShowAttachment(
      attachment: widget.clearButtonMode,
      hasText: text.text.isNotEmpty,
    );
  }

  bool _shouldShowAttachment({
    required OverlayVisibilityMode attachment,
    required bool hasText,
  }) {
    switch (attachment) {
      case OverlayVisibilityMode.never:
        return false;
      case OverlayVisibilityMode.always:
        return true;
      case OverlayVisibilityMode.editing:
        return hasText;
      case OverlayVisibilityMode.notEditing:
        return !hasText;
    }
  }
}
