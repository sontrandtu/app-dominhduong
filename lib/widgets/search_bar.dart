import 'dart:async';
import 'package:dominhduong/utils/extensions.dart';
import 'package:flutter/material.dart';
import '../theme/colors.dart';

class SearchBar extends StatefulWidget {
  final String hintText;
  final FocusNode? focusNode;
  final Function(String)? onSearchChange;
  final Function(String)? onSubmitted;
  final Widget? prefixWidget;

  const SearchBar({Key? key, required this.hintText, this.focusNode, this.onSearchChange, this.onSubmitted, this.prefixWidget}) : super(key: key);

  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  late FocusNode _focusNode;
  TextEditingController textEditingController = TextEditingController();
  Timer? _debounce;

  @override
  void initState() {
    _focusNode = widget.focusNode ?? FocusNode();
    textEditingController.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  _onSearchChanged(String query) {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 300), () {
      widget.onSearchChange?.call(query);
    });
  }

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color(0xffF3F1F1),
        border: Border.all(color: const Color(0xffC2CBD6)),
        borderRadius: const BorderRadius.all(Radius.circular(8)),
      ),
      padding: EdgeInsets.fromLTRB(widget.prefixWidget != null ? 8 : 15, 0, 0, 0),
      height: 40,
      child: Row(
        children: [
          widget.prefixWidget ?? const SizedBox(),
          if (widget.prefixWidget != null)
            const SizedBox(
              width: 8,
            ),
          Expanded(
            child: TextField(
              textCapitalization: TextCapitalization.sentences,
              focusNode: _focusNode,
              controller: textEditingController,
              style: context.textStyle(color: AppColors.textDefault).size13.w400.fontRoboto,
              decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(vertical: 12),
                  focusedBorder: const OutlineInputBorder(borderSide: BorderSide.none),
                  enabledBorder: const OutlineInputBorder(borderSide: BorderSide.none),
                  isCollapsed: true,
                  isDense: true,
                  suffixIcon: GestureDetector(
                    onTap: () {
                      textEditingController.clear();
                      _onSearchChanged('');
                    },
                    child: (textEditingController.text.isEmpty)
                        ? const Icon(
                          Icons.search,
                          color: AppColors.iconDefaultColor,
                          size: 20,
                        )
                        : const Icon(
                          Icons.clear,
                          color: AppColors.iconDefaultColor,
                          size: 16,
                        ),
                  ),
                  hintText: widget.hintText,
                  hintStyle: context.textStyle(color: AppColors.hintTextColor).size13.w400.fontRoboto,
                  border: InputBorder.none,
                  fillColor: Colors.red
              ),
              textInputAction: TextInputAction.search,
              onChanged: _onSearchChanged,
              onSubmitted: widget.onSubmitted,
            ),
          ),
        ],
      ),
    );
  }
}
