import 'package:dominhduong/res.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomDropdownButtonDefault extends StatefulWidget {
  final String placeholderText;
  final IconData icons;
  final int type;
  final bool isValidate;
  final bool readOnly;

  const CustomDropdownButtonDefault({Key? key, required this.placeholderText, this.icons = Icons.place_outlined, required this.type, this.isValidate = false, this.readOnly = false}) : super(key: key);

  @override
  State<CustomDropdownButtonDefault> createState() => _CustomDropdownButtonDefaultState();
}

class _CustomDropdownButtonDefaultState extends State<CustomDropdownButtonDefault> {
  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      ignoring: widget.readOnly,
      child: GestureDetector(
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
                  border: Border.all(color: widget.isValidate ? Colors.red : Colors.grey.withOpacity(0.5))
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(widget.icons, color: Colors.black54, size: 20),
                      const SizedBox(width: 10),
                      RichText(
                        text: TextSpan(
                          style: const TextStyle(fontSize: 13, fontFamily: 'Roboto'),
                          children: [
                            TextSpan(text: widget.type == 2 ? '' : '* ', style: const TextStyle(color: Colors.red)),
                            TextSpan(text: widget.placeholderText , style: const TextStyle(color: Colors.black)),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const Icon(Icons.keyboard_arrow_down_rounded, color: Colors.black54, size: 20),
                ],
              ),
            ),
            widget.readOnly ? Container(
              margin: const EdgeInsets.symmetric(vertical: 10),
              padding: const EdgeInsets.symmetric(horizontal: 10),
              width: double.infinity,
              height: 50,
              decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.1),
                  borderRadius: const BorderRadius.all(Radius.circular(10))
              ),
            ) : const SizedBox()
          ],
        ),
      ),
    );
  }
}
