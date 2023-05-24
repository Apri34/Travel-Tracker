import 'package:flutter/material.dart';
import 'package:travel_trackr/core/theme/app_colors.dart';
import 'package:travel_trackr/core/utils/always_disabled_focus_node.dart';

import '../../theme/app_text_theme.dart';

class AppTextField extends StatefulWidget {
  final VoidCallback? onTap;
  final bool allowWrite;
  final String? hint;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final ValueChanged<String>? onChanged;
  final bool error;
  final bool enabled;
  final bool autofocus;

  const AppTextField({
    Key? key,
    this.onTap,
    this.allowWrite = true,
    this.hint,
    this.controller,
    this.focusNode,
    this.onChanged,
    this.error = false,
    this.enabled = true,
    this.autofocus = false,
  }) : super(key: key);

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField>
    with SingleTickerProviderStateMixin {
  late final TextEditingController controller;
  late final FocusNode focusNode;
  late final AnimationController _animationController = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 200),
    reverseDuration: const Duration(milliseconds: 200),
  );
  late final Animation<double> _animation =
      Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(
    parent: _animationController,
    curve: Curves.easeOut,
  ))
        ..addListener(() {
          setState(() {});
        });
  Alignment hintAlignment = Alignment.centerLeft;

  @override
  void initState() {
    controller = widget.controller ?? TextEditingController();
    controller.addListener(() {
      updateHint();
    });
    focusNode = widget.allowWrite
        ? widget.focusNode ?? FocusNode()
        : AppAlwaysDisabledFocusNode();
    focusNode.addListener(() {
      updateHint();
    });
    updateHint();
    super.initState();
  }

  void updateHint() {
    if ((focusNode.hasFocus || controller.text.isNotEmpty) &&
        hintAlignment != Alignment.centerRight) {
      setState(() {
        hintAlignment = Alignment.centerRight;
      });
      _animationController.forward(from: 0);
    } else if (!focusNode.hasFocus &&
        controller.text.isEmpty &&
        hintAlignment != Alignment.centerLeft) {
      setState(() {
        hintAlignment = Alignment.centerLeft;
      });
      _animationController.reverse(from: 1);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Theme(
          data: Theme.of(context).copyWith(
            inputDecorationTheme:
                Theme.of(context).inputDecorationTheme.copyWith(
                      fillColor: widget.error ? AppColors.errorFillColor : null,
                    ),
          ),
          child: TextFormField(
            focusNode: focusNode,
            onTap: widget.onTap,
            onChanged: (value) {
              if (widget.onChanged != null) {
                widget.onChanged!(value);
              }
            },
            controller: controller,
            decoration: InputDecoration(
              errorText: widget.error ? '' : null,
              errorStyle: const TextStyle(height: 0),
            ),
            enabled: widget.enabled,
            autofocus: widget.autofocus,
          ),
        ),
        if (widget.hint != null)
          Positioned.fill(
            left: 25.0,
            right: 25.0,
            child: IgnorePointer(
              child: AnimatedAlign(
                alignment: hintAlignment,
                curve: Curves.easeOut,
                duration: const Duration(milliseconds: 200),
                child: Text(
                  widget.hint!,
                  style: AppTextTheme.getHintStyle(_animation.value),
                ),
              ),
            ),
          ),
      ],
    );
  }

  @override
  void dispose() {
    if (widget.controller == null) {
      controller.dispose();
    }
    if (widget.focusNode == null || !widget.allowWrite) {
      focusNode.dispose();
    }
    super.dispose();
  }
}
