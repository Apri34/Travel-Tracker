import 'package:flutter/material.dart';
import 'package:travel_trackr/core/presentation/widgets/app_text_field.dart';

import '../../theme/app_colors.dart';
import '../../theme/app_text_theme.dart';

class AppDropdown<T> extends StatefulWidget {
  final void Function(T, int)? onChange;
  final List<T> items;
  final String Function(T item) textBuilder;
  final Widget Function(T item)? itemBuilder;
  final DropdownStyle? dropdownStyle;
  final InputDecoration? decoration;
  final bool withSuffix;
  final DropdownController? controller;
  final int? startIndex;
  final bool enabled;
  final String? hint;
  final bool error;

  const AppDropdown({
    Key? key,
    this.onChange,
    required this.items,
    this.dropdownStyle,
    this.withSuffix = true,
    this.controller,
    this.startIndex,
    this.enabled = true,
    this.decoration,
    required this.textBuilder,
    this.itemBuilder,
    this.hint,
    this.error = false,
  }) : super(key: key);

  @override
  _AppDropdownState<T> createState() => _AppDropdownState<T>();
}

class _AppDropdownState<T> extends State<AppDropdown<T>>
    with SingleTickerProviderStateMixin {
  final LayerLink _layerLink = LayerLink();
  late OverlayEntry _overlayEntry;
  bool _isOpen = false;
  late AnimationController _animationController;
  late Animation<double> _expandAnimation;
  late DropdownController controller;
  final TextEditingController selectionController = TextEditingController();

  @override
  void initState() {
    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 200));
    _expandAnimation =
        CurvedAnimation(parent: _animationController, curve: Curves.easeOut);
    controller = widget.controller ?? DropdownController();
    if (widget.startIndex != null) {
      controller.setIndex(widget.startIndex!);
      selectionController.text =
          widget.textBuilder(widget.items[widget.startIndex!]);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      link: _layerLink,
      child: AppTextField(
        allowWrite: false,
        onTap: _toggleDropdown,
        enabled: widget.enabled,
        controller: selectionController,
        hint: widget.hint,
        error: widget.error,
      ),
    );
  }

  void _toggleDropdown({bool close = false}) async {
    if (_isOpen || close) {
      await _animationController.reverse();
      _overlayEntry.remove();
      setState(() {
        _isOpen = false;
      });
    } else {
      _overlayEntry = _createOverlayEntry();
      Overlay.of(context)!.insert(_overlayEntry);
      setState(() {
        _isOpen = true;
      });
      _animationController.forward();
    }
  }

  OverlayEntry _createOverlayEntry() {
    RenderBox? renderBox = context.findRenderObject() as RenderBox;
    var size = renderBox.size;

    var offset = renderBox.localToGlobal(Offset.zero);
    var topOffset = offset.dy + size.height + 5;
    return OverlayEntry(
      builder: (context) => GestureDetector(
        onTap: () => _toggleDropdown(close: true),
        behavior: HitTestBehavior.translucent,
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Stack(
            children: [
              Positioned(
                left: offset.dx,
                top: topOffset,
                width: widget.dropdownStyle?.width ?? size.width,
                child: CompositedTransformFollower(
                  offset: widget.dropdownStyle?.offset ??
                      Offset(0, size.height + 5),
                  link: _layerLink,
                  showWhenUnlinked: false,
                  child: Material(
                    elevation: widget.dropdownStyle?.elevation ?? 0,
                    borderRadius: widget.dropdownStyle?.borderRadius ??
                        BorderRadius.circular(20.0),
                    color:
                        widget.dropdownStyle?.color ?? AppColors.textFieldColor,
                    child: SizeTransition(
                      axisAlignment: 1,
                      sizeFactor: _expandAnimation,
                      child: ConstrainedBox(
                        constraints: widget.dropdownStyle?.constraints ??
                            BoxConstraints(
                              maxHeight: MediaQuery.of(context).size.height -
                                  topOffset -
                                  15,
                            ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: ListView(
                            padding: EdgeInsets.zero,
                            shrinkWrap: true,
                            children: widget.items
                                .map((e) => DropdownItem<T>(
                                      text: widget.textBuilder(e),
                                      value: e,
                                      child: widget.itemBuilder != null
                                          ? widget.itemBuilder!(e)
                                          : null,
                                    ))
                                .toList()
                                .asMap()
                                .entries
                                .map(
                                  (item) => InkWell(
                                    onTap: !item.value.disabled
                                        ? () {
                                            setState(() {
                                              controller.setIndex(item.key);
                                              selectionController.text =
                                                  item.value.text;
                                            });
                                            if (widget.onChange != null) {
                                              widget.onChange!(
                                                item.value.value!,
                                                controller.index!,
                                              );
                                            }
                                            _toggleDropdown(close: true);
                                          }
                                        : null,
                                    child: Padding(
                                      padding: widget.dropdownStyle?.padding ??
                                          EdgeInsets.zero,
                                      child: item.value,
                                    ),
                                  ),
                                )
                                .toList(),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class DropdownItem<T> extends StatelessWidget {
  final T? value;
  final Widget? child;
  final String text;
  final bool disabled;

  const DropdownItem({
    Key? key,
    required this.value,
    this.child,
    required this.text,
    this.disabled = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return child ??
        Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 8.0,
            horizontal: 16.0,
          ),
          child: Text(
            text,
            style: AppTextTheme.dropdown,
          ),
        );
  }
}

class DropdownStyle {
  final BorderRadius? borderRadius;
  final double? elevation;
  final Color? color;
  final EdgeInsets? padding;
  final BoxConstraints? constraints;
  final TextStyle? textStyle;

  /// position of the top left of the dropdown relative to the top left of the button
  final Offset? offset;

  ///button width must be set for this to take effect
  final double? width;

  const DropdownStyle({
    this.constraints,
    this.offset,
    this.width,
    this.elevation,
    this.color,
    this.padding,
    this.borderRadius,
    this.textStyle,
  });
}

class DropdownController extends ChangeNotifier {
  int? index;

  void setIndex(int? index) {
    this.index = index;
    notifyListeners();
  }
}
