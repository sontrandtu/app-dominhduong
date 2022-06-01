import 'package:flutter/material.dart';

import '../../theme/colors.dart';

class CustomRadioButton extends StatefulWidget {

  final List<String>? data;
  final List<IconData>? iconData;
  final int? initData;
  final Function(String)? selectedCallBack;
  final bool? isIcon;

  const CustomRadioButton({
    Key? key,
    this.data,
    this.iconData,
    this.initData,
    this.selectedCallBack,
    this.isIcon,
  }) : super(key: key);

  @override
  State<CustomRadioButton> createState() => _CustomRadioButtonState();
}

class _CustomRadioButtonState extends State<CustomRadioButton> {
  int? selectedIndex;
  bool isIcon = false;

  @override
  void initState() {
    super.initState();
    if(widget.initData != null) {
      selectedIndex = widget.initData;
    } else{
      selectedIndex = -1;
    }
    if(widget.isIcon == null){
      isIcon = false;
    } else {
      isIcon = widget.isIcon!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      childAspectRatio: 3.8,
      crossAxisSpacing: 36,
      mainAxisSpacing: 20,
      shrinkWrap: true,
      crossAxisCount: 2,
      physics: const NeverScrollableScrollPhysics(),
      children: List.generate(widget.data!.length, (index) {
        return GestureDetector(
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: selectedIndex == index ? AppColors.primaryColor : Colors.white,
                border: Border.all(color: Colors.grey.withOpacity(0.5))
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                isIcon ? Icon(widget.iconData![index], size: 30, color: Colors.black) : const SizedBox(),
                const SizedBox(width: 12),
                Text(widget.data![index], style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black,fontFamily: 'Roboto')),
              ],
            ),
          ),
          onTap: () {
            setState(() {
              selectedIndex = index;
              widget.selectedCallBack?.call(widget.data![index]);
            });
          },
        );
      }),
    );
  }
}