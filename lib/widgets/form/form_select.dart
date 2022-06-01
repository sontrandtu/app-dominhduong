import 'package:dominhduong/res.dart';
import 'package:dominhduong/widgets/filter_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class FormSelect extends StatefulWidget {
  final List<dynamic> items;
  final bool readOnly;
  final bool isValidate;
  final IconData? icon;
  final String? labelText;
  final bool isRequired;
  final ValueChanged? onChanged;
  final dynamic value;

  const FormSelect({
    Key? key,
    required this.items,
    this.readOnly = false,
    this.isValidate = false,
    this.icon,
    this.labelText,
    this.isRequired = false,
    this.onChanged,
    this.value,
  }) : super(key: key);

  @override
  State<FormSelect> createState() => _FormSelectState();
}

class _FormSelectState extends State<FormSelect> {
  String _labelText = '';

  @override
  void initState() {
    _labelText = widget.labelText != '' ? widget.labelText! : '';
    super.initState();
  }

  @override
  void didUpdateWidget(covariant FormSelect oldWidget) {
    if (oldWidget.labelText != widget.labelText) _labelText = widget.labelText!;
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    print('items........${widget.items}');
    return IgnorePointer(
      ignoring: widget.readOnly,
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
          _showMenu(context);
        },
        child: Stack(
          children: [
            Container(
              margin: const EdgeInsets.symmetric(vertical: 10),
              padding: const EdgeInsets.symmetric(horizontal: 10),
              width: double.infinity,
              height: 50,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                  border: Border.all(color: widget.isValidate ? Colors.red : Colors.grey.withOpacity(0.5))),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      if (widget.icon != null) Icon(widget.icon, color: Colors.black54, size: 20),
                      const SizedBox(width: 10),
                      RichText(
                        text: TextSpan(
                          style: const TextStyle(fontSize: 13, fontFamily: 'Roboto'),
                          children: [
                            TextSpan(text: !widget.isRequired ? '' : '* ', style: const TextStyle(color: Colors.red)),
                            TextSpan(text: _labelText, style: const TextStyle(color: Colors.black)),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const Icon(Icons.keyboard_arrow_down_rounded, color: Colors.black54, size: 20),
                ],
              ),
            ),
            widget.readOnly
                ? Container(
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    width: double.infinity,
                    height: 50,
                    decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(0.1), borderRadius: const BorderRadius.all(Radius.circular(10))),
                  )
                : const SizedBox()
          ],
        ),
      ),
    );
  }

  void _showMenu(BuildContext context) {
    showMaterialModalBottomSheet(
      context: context,
      elevation: 10,
      builder: (_) {
        return _MenuContent(
          labelText: _labelText,
          items: widget.items,
          onChanged: widget.onChanged,
        );
      },
    );
  }
}

class _MenuContent extends StatefulWidget {
  final ValueChanged? onChanged;
  final String? labelText;
  final List<dynamic> items;
  final dynamic value;

  const _MenuContent({Key? key, this.onChanged, this.labelText, required this.items, this.value}) : super(key: key);

  @override
  State<_MenuContent> createState() => _MenuContentState();
}

class _MenuContentState extends State<_MenuContent> {
  late FocusNode node;
  int selectId = -1;

  @override
  void initState() {
    if(widget.value != null) {
      for (var element in widget.items) {
        if(element.id == widget.value) {
          selectId = widget.value;
        }
      }
    }

    node = FocusNode();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Colors.grey.shade50),
      constraints: BoxConstraints(maxHeight: (MediaQuery.of(context).size.height * 9) / 16),
      child: Column(
        children: [
          if (widget.labelText != null)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15),
                  topRight: Radius.circular(15),
                ),
              ),
              child: Text(widget.labelText!,
                  style: const TextStyle(
                      fontSize: 14, fontFamily: 'RobotoSlab', color: Colors.black, fontWeight: FontWeight.w700)),
            ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: FilterHeader(
              onSearch: (value) {},
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(10),
              physics: const ClampingScrollPhysics(),
              itemCount: widget.items.isEmpty ? 0 : widget.items.length,
              itemBuilder: (BuildContext context, int index) {
                final item = widget.items[index];
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectId = item.id;
                    });
                    widget.onChanged!(item.id);
                    // setState(() {
                    //   selectedIndex = index;
                    //   placeholderText = item.name;
                    //   widget.onSelectedCallback?.call(item.id);
                    //   Navigator.pop(context);
                    // });
                  },
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 5),
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.1),
                      borderRadius: const BorderRadius.all(Radius.circular(8)),
                      border: Border.all(
                          color: selectId == item.id ? Theme.of(context).primaryColor : Colors.grey.withOpacity(0.1)),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(item.name ?? '',
                            style: const TextStyle(fontSize: 13, fontFamily: 'Roboto', color: Colors.black)),
                        selectId == item.id
                            ? SvgPicture.asset(Res.ic_check_circle, color: Theme.of(context).primaryColor, width: 20)
                            : const SizedBox(height: 0),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
