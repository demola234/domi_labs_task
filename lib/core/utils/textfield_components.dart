// Dart imports:
import 'dart:ui';

// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// Package imports:
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../design_system/theme_extension/app_theme_extension.dart';

class TextFieldComponents extends StatefulWidget {
  // Change StatelessWidget to StatefulWidget
  final String? labelText;
  final String? initialValue;
  final Widget? suffixIcon;
  final TextInputType? inputType;
  final String? Function(String? input)? validator;
  final Function(String input)? onChanged;
  final Function(String)? onFieldSubmitted;
  final Function(String?)? onSaved;
  final Function()? onEditingComplete;
  final List<TextInputFormatter>? inputFormatters;
  final EdgeInsetsGeometry? contentPadding;
  final TextInputType keyboardType;
  final int? maxLines, maxLength;
  final FocusNode? focusNode;
  final bool enableInteractiveSelection;
  final TextAlign textAlign;
  final String? hintText;
  final String? errorText;
  final bool? obscureText;
  final bool? phoneNumberPrefix;
  final Widget? prefixIcon;
  final TextEditingController? controller;
  final TextCapitalization textCapitalization;
  final Iterable<String>? autofillHints;
  final bool enabled;
  final bool hideHint;
  final bool onTapOutside;
  final bool? readOnly;
  final TextInputAction? textInputAction;
  final void Function()? onTap;
  final List<String>? bottomSheetItems;
  final Function(String selected)? onSelectItem;

  const TextFieldComponents({
    super.key,
    this.labelText,
    this.keyboardType = TextInputType.text,
    this.phoneNumberPrefix = false,
    this.maxLength,
    this.initialValue,
    this.autofillHints,
    this.contentPadding,
    this.onTapOutside = true,
    this.suffixIcon,
    this.inputType,
    this.onChanged,
    this.onEditingComplete,
    this.onSelectItem,
    this.textCapitalization = TextCapitalization.none,
    this.onSaved,
    this.validator,
    this.inputFormatters,
    this.onFieldSubmitted,
    this.maxLines = 1,
    this.focusNode,
    this.textAlign = TextAlign.start,
    this.textInputAction = TextInputAction.next,
    this.obscureText = false,
    this.enableInteractiveSelection = true,
    this.hideHint = false,
    this.hintText,
    this.prefixIcon,
    this.controller,
    this.readOnly = false,
    this.onTap,
    this.enabled = true,
    this.errorText,
    this.bottomSheetItems,
  });

  @override
  _TextFieldComponentsState createState() => _TextFieldComponentsState();
}

class _TextFieldComponentsState extends State<TextFieldComponents> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller =
        widget.controller ?? TextEditingController(text: widget.initialValue);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        8.verticalSpace,
        TextFormField(
          controller: _controller,
          onSaved: widget.onSaved,
          autofillHints: widget.autofillHints,
          onEditingComplete: widget.onEditingComplete,
          cursorColor: context.theme.colors.activeButton,
          enableInteractiveSelection: widget.enableInteractiveSelection,
          onTap: () {
            widget.onTap ?? () {};
          },
          maxLines: widget.maxLines,
          readOnly: widget.readOnly!,
          focusNode: widget.focusNode,
          onFieldSubmitted: widget.onFieldSubmitted,
          textCapitalization: widget.textCapitalization,
          selectionHeightStyle: BoxHeightStyle.max,
          initialValue: widget.initialValue,
          keyboardType: widget.keyboardType,
          textInputAction: widget.textInputAction,
          enabled: widget.enabled,
          style: context.theme.fonts.bodyMedium.copyWith(
            color: context.theme.colors.textTertiary,
          ),
          decoration: InputDecoration(
            contentPadding: widget.contentPadding ??
                EdgeInsets.symmetric(horizontal: 16.w, vertical: 18.h),
            fillColor: context.theme.colors.surfaceCard,
            prefixIcon: widget.prefixIcon,
            errorText: widget.errorText,
            filled: true,
            focusedBorder: InputBorder.none,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: context.theme.colors.textTertiary,
                width: 0.5.w,
              ),
            ),
            suffixIcon: widget.suffixIcon,
            labelStyle: context.theme.fonts.bodyMedium.copyWith(
              color: context.theme.colors.surface,
            ),
            hintText: widget.hintText ?? '',
            hintStyle: context.theme.fonts.bodyMedium.copyWith(
              fontSize: 14.sp,
              fontWeight: FontWeight.w300,
              color: context.theme.colors.textTertiary,
            ),
            constraints: const BoxConstraints(minWidth: 30, minHeight: 10),
            prefixIconConstraints:
                const BoxConstraints(minWidth: 35, minHeight: 10),
          ),
          onChanged: widget.onChanged,
          validator: widget.validator,
        ),
      ],
    );
  }
}
