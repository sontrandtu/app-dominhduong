import 'package:dominhduong/screens/order_medicine/selected_category_view_model.dart';
import 'package:dominhduong/screens/order_medicine/selected_category_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../model/category_model.dart';

class CategoriesDropdownButton extends StatefulWidget {
  final String placeholderText;
  final IconData icons;
  final int type;
  final bool isValidate;
  final List<CategoryModel> data;
  final Function(int)? onSelectedCallback;

  const CategoriesDropdownButton({Key? key, this.data = const [], this.placeholderText = '', this.icons = Icons.place_outlined, this.onSelectedCallback, required this.type, this.isValidate = false}) : super(key: key);

  @override
  State<CategoriesDropdownButton> createState() => _CategoriesDropdownButtonState();
}

class _CategoriesDropdownButtonState extends State<CategoriesDropdownButton> {
  int selectedIndex = -1;
  String placeholderText = '';
  bool showChild = false;

  @override
  void initState() {
    super.initState();

    placeholderText = widget.placeholderText;
  }

  _showModalBottomSheet(context) {
    showModalBottomSheet(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15),
            topRight: Radius.circular(15),
          ),
        ),
        context: context,
        builder: (BuildContext ctx) {
          return Stack(
            children: [
              ListView.builder(
                padding: const EdgeInsets.only(left: 10, top: 50, right: 10, bottom: 10),
                physics: const ClampingScrollPhysics(),
                itemCount: widget.data.isEmpty ? 0 : widget.data.length,
                itemBuilder: (BuildContext context, int index) {
                  final item = widget.data[index];
                  return (item.numberChildren != 0) ? GestureDetector(
                    onTap: () {
                      showModalBottomSheet(
                          shape: const RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(15), topRight: Radius.circular(15))),
                          context: context,
                          builder: (context) {
                            final int? categoryId = item.id;
                            return ChangeNotifierProvider(
                              create: (_) => SelectedCategoryViewModel(repo: context.read(), categoryId: categoryId),
                              child: SelectedCategoryWidget(
                                onSelectedCallback: (id, name){
                                  placeholderText = name;
                                  widget.onSelectedCallback?.call(id);
                                  Navigator.of(context).pop();
                                },
                              ),
                            );
                          }
                      );
                    },
                    child: Container(
                      margin: const EdgeInsets.symmetric(vertical: 5),
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(0.1),
                        borderRadius:
                        const BorderRadius.all(Radius.circular(8)),
                          border: Border.all(color: selectedIndex == index ? Theme.of(context).primaryColor :  Colors.grey.withOpacity(0.1))
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(item.name ?? '', style: const TextStyle(fontSize: 13, fontFamily: 'Roboto', color: Colors.black)),
                          const Icon(Icons.arrow_forward_ios_outlined, size: 14, color: Colors.black45),
                        ],
                      ),
                    ),
                  ) : GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedIndex = index;
                        placeholderText = item.name.toString();
                        widget.onSelectedCallback?.call(widget.data[selectedIndex].id!);
                        Navigator.of(context).pop();
                      });
                    },
                    child: Container(
                      margin: const EdgeInsets.symmetric(vertical: 5),
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(0.1),
                        borderRadius: const BorderRadius.all(Radius.circular(8)),
                        border: Border.all(color: Colors.grey.withOpacity(0.1))
                      ),
                      child: Text(item.name ?? '', style: const TextStyle(fontSize: 13, fontFamily: 'Roboto', color: Colors.black)),
                    ),
                  );
                },
              ),
              Container(
                padding:
                const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15),
                  ),
                ),
                child: const Text(
                    'Chuyên khoa bệnh & Đầu bệnh',
                    style: TextStyle(fontSize: 14, fontFamily: 'RobotoSlab', color: Colors.black, fontWeight: FontWeight.w700)
                ),
              ),
            ],
          );
        }
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        _showModalBottomSheet(context);
      },
      child: Container(
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
                Icon(widget.icons, color: Colors.black54, size: 20),
                const SizedBox(width: 10),
                RichText(
                  text: TextSpan(
                    style: const TextStyle(fontSize: 13, fontFamily: 'Roboto',),
                    children: [
                      TextSpan(text: widget.type == 2 ? '' : '* ', style: const TextStyle(color: Colors.red)),
                      TextSpan(text: placeholderText, style: const TextStyle(color: Colors.black)),
                    ],
                  ),
                ),
              ],
            ),
            const Icon(Icons.keyboard_arrow_down_rounded, color: Colors.black54, size: 20),
          ],
        ),
      ),
    );
  }
}