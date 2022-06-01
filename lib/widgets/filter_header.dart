import 'package:flutter/material.dart';

import '../theme/colors.dart';

class FilterHeader extends StatelessWidget {
  final String? labelText;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSearch;
  final Function? showSearch;
  final Color? color;
  final Widget? actionsFilter;
  final String? initialValue;
  final Widget? leading;
  final FocusNode? focusNode;
  final Function()? onTap;

  const FilterHeader(
      {Key? key,
        this.labelText,
        this.onChanged,
        this.showSearch,
        required this.onSearch,
        this.color,
        this.actionsFilter,
        this.initialValue,
        this.leading,
        this.onTap,
        this.focusNode})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 36,
      child: TextFormField(
        onTap: onTap,
        initialValue: initialValue,
        textInputAction: TextInputAction.search,
        focusNode: focusNode,
        onFieldSubmitted: onSearch,
        onChanged: onChanged,
        decoration: InputDecoration(
          prefixIcon: const Icon(Icons.search_outlined, size: 18),
          filled: true,
          fillColor: Colors.grey.withOpacity(0.1),
          focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: AppColors.primaryColor), borderRadius: BorderRadius.circular(20)),
          enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey.withOpacity(0.5)), borderRadius: BorderRadius.circular(20)),
          contentPadding: const EdgeInsets.symmetric(vertical: 8),
          border: InputBorder.none,
          hintText: labelText ?? 'Tìm kiếm...',
          hintStyle: const TextStyle(fontSize: 13)
        ),
      ),
    );
  }
}
