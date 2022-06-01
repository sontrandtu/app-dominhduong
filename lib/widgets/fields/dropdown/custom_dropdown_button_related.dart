import 'package:dominhduong/res.dart';
import 'package:dominhduong/utils/extensions/string_extension.dart';
import 'package:dominhduong/widgets/filter_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class CustomDropdownButtonRelated extends StatefulWidget {
  final String placeholderText;
  final List<dynamic> data;
  final Widget child;
  final int selectId;
  final Function(int, String)? onSelectedCallback;

  const CustomDropdownButtonRelated(
      {Key? key,
      required this.selectId,
      required this.child,
      required this.data,
      required this.placeholderText,
      this.onSelectedCallback})
      : super(key: key);

  @override
  State<CustomDropdownButtonRelated> createState() => _CustomDropdownButtonRelatedState();
}

class _CustomDropdownButtonRelatedState extends State<CustomDropdownButtonRelated> {

  void _showModalBottomSheet(context) {
    showMaterialModalBottomSheet(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(15),
          topRight: Radius.circular(15),
        ),
      ),
      context: context,
      useRootNavigator: true,
      builder: (BuildContext ctx) => SearchLocationWidget(
        data: widget.data,
        placeholderText: widget.placeholderText,
        child: widget.child,
        onSelectedCallback: widget.onSelectedCallback,
        selectId: widget.selectId,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        _showModalBottomSheet(context);
      },
      child: widget.child,
    );
  }
}

class SearchLocationWidget extends StatefulWidget {
  final String placeholderText;
  final List<dynamic> data;
  final Widget child;
  final int selectId;
  final Function(int, String)? onSelectedCallback;

  const SearchLocationWidget({
    Key? key,
    required this.data,
    required this.placeholderText,
    required this.child,
    required this.onSelectedCallback, required this.selectId,
  }) : super(key: key);

  @override
  State<SearchLocationWidget> createState() => _SearchLocationWidgetState();
}

class _SearchLocationWidgetState extends State<SearchLocationWidget> {
  int _id = -1;
  bool isOpenKeyboard = false;
  late ValueNotifier<List<dynamic>> _itemsNotifier;
  late FocusNode _focusNode;

  Size get size => MediaQuery.of(context).size;

  @override
  void initState() {
    super.initState();
    _itemsNotifier = ValueNotifier(widget.data);
    _id = widget.selectId;
    _focusNode = FocusNode()
      ..addListener(() {
        if (_focusNode.hasFocus) {
          isOpenKeyboard = true;
        } else {
          isOpenKeyboard = false;
        }
        setState(() {});
      });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: isOpenKeyboard,
      child: InkWell(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Container(
          constraints: BoxConstraints(maxHeight: isOpenKeyboard ? size.height : size.height * 9.0/16),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                width: double.infinity,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(height: 16),
                    Text(widget.placeholderText,
                        style: const TextStyle(
                            fontSize: 14,
                            fontFamily: 'RobotoSlab',
                            color: Colors.black,
                            fontWeight: FontWeight.w700,
                        ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 12, bottom: 12),
                      child: FilterHeader(
                        color: Colors.grey.withOpacity(0.1),
                        onChanged: _onChanged,
                        onSearch: _onSearch,
                        focusNode: _focusNode,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ValueListenableBuilder<List>(
                    valueListenable: _itemsNotifier,
                    builder: (_, _items, __) {
                      return ListView.builder(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                        physics: const ClampingScrollPhysics(),
                        itemCount: _items.isEmpty ? 0 : _items.length,
                        itemBuilder: (BuildContext context, int index) {
                          final item = _items[index];
                          return GestureDetector(
                            onTap: () {
                              Navigator.of(context).pop();
                              if(FocusScope.of(context).hasFocus) {
                                FocusScope.of(context).unfocus();
                              }
                              setState(() {
                                _id = item.id;
                              });
                              widget.onSelectedCallback?.call(item.id, item.name);
                            },
                            child: Container(
                              margin: const EdgeInsets.symmetric(vertical: 5),
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  color: Colors.grey.withOpacity(0.1),
                                  borderRadius: const BorderRadius.all(Radius.circular(8)),
                                  border: Border.all(
                                      color:
                                          _id == item.id
                                          ? Theme.of(context).primaryColor
                                          : Colors.grey.withOpacity(0.1))),
                              child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(item.name ?? '',
                                        style: const TextStyle(fontSize: 13, fontFamily: 'Roboto', color: Colors.black)),
                                        _id == item.id
                                        ? SvgPicture.asset(Res.ic_check_circle,
                                            color: Theme.of(context).primaryColor, width: 20)
                                        : const SizedBox(height: 0),
                                  ]),
                            ),
                          );
                        },
                      );
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _onSearch(String value) {}

  void _onChanged(String value) {
    if (value == '') _itemsNotifier.value = widget.data;
    if (value != '') {
      _itemsNotifier.value = _itemsNotifier.value.where((element) => element.name.toString().search(value)).toList();
    }
  }

  @override
  void dispose() {
    _itemsNotifier.dispose();
    _focusNode.dispose();
    super.dispose();
  }
}
