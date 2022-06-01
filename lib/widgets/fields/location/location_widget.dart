import 'package:dominhduong/widgets/fields/dropdown/custom_dropdown_button_related.dart';
import 'package:dominhduong/widgets/fields/location/location_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LocationWidget extends StatefulWidget {
  final Function(dynamic)? onSelectedProvinceCallback;
  final Function(dynamic)? onSelectedDistrictCallback;
  final Function(dynamic)? onSelectedWardCallback;
  final bool isSProvince;
  final bool isDistrict;
  final bool isWard;
  final int? provinceId;
  final int? districtId;
  final int? wardId;

  const LocationWidget(
      {Key? key,
      this.onSelectedProvinceCallback,
      this.onSelectedDistrictCallback,
      this.onSelectedWardCallback,
      this.isSProvince = false,
      this.isDistrict = false,
      this.isWard = false, this.provinceId, this.districtId, this.wardId})
      : super(key: key);

  @override
  _LocationWidgetState createState() => _LocationWidgetState();
}

class _LocationWidgetState extends State<LocationWidget> {
  final String _provincePlaceholderText = 'Tỉnh/Thành phố';
  final String _districtPlaceholderText = 'Quận/Huyện';
  final String _wardPlaceholderText = 'Xã/Phường';
  late int _provinceId = -1;
  late int _districtId = -1;
  late int _wardId = -1;

  @override
  void initState() {
    _provinceId = widget.provinceId!;
    _districtId = widget.districtId!;
    _wardId = widget.wardId!;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<LocationViewModel>();
    return Column(
      children: [
        CustomDropdownButtonRelated(
          placeholderText: _provincePlaceholderText,
          data: viewModel.listProvince,
          onSelectedCallback: (id, name) {
            setState(() {
              viewModel.loadFistTime = false;
              viewModel.provinceName = name;
              viewModel.districtName = _districtPlaceholderText;
              viewModel.wardName = _wardPlaceholderText;
              _provinceId = id;
              _districtId = -1;
              _wardId = -1;
              widget.onSelectedProvinceCallback?.call(id);
              widget.onSelectedDistrictCallback?.call(0);
              widget.onSelectedWardCallback?.call(0);
              viewModel.loadDistrict(id);
            });
          },
          selectId: _provinceId,
          child: IgnorePointer(
            ignoring: viewModel.listProvince.isEmpty,
            child: Stack(
              children: [
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  width: double.infinity,
                  height: 50,
                  decoration: BoxDecoration(
                      color: viewModel.listProvince.isEmpty ? Colors.grey.withOpacity(0.1) : Colors.white,
                      borderRadius: const BorderRadius.all(Radius.circular(8)),
                      border: Border.all(color: Colors.grey.withOpacity(0.5))
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.place_outlined, color: Colors.black54, size: 20),
                          const SizedBox(width: 10),
                          RichText(
                            text: TextSpan(
                              style: const TextStyle(fontSize: 13, fontFamily: 'Roboto'),
                              children: [
                                const TextSpan(text: '* ', style: TextStyle(color: Colors.red)),
                                TextSpan(text: viewModel.provinceName, style: const TextStyle(color: Colors.black)),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const Icon(Icons.keyboard_arrow_down_rounded, color: Colors.black54, size: 20),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        CustomDropdownButtonRelated(
          placeholderText: _districtPlaceholderText,
          data: viewModel.listDistrict,
          onSelectedCallback: (id, name) {
            setState(() {
              viewModel.loadFistTime = false;
              viewModel.districtName = name;
              viewModel.wardName = _wardPlaceholderText;
              _districtId = id;
              _wardId = -1;
              widget.onSelectedDistrictCallback?.call(id);
              widget.onSelectedWardCallback?.call(0);
              viewModel.loadWard(id);
            });
          },
          selectId: _districtId,
          child: IgnorePointer(
            ignoring: viewModel.listDistrict.isEmpty,
            child: Stack(
              children: [
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  width: double.infinity,
                  height: 50,
                  decoration: BoxDecoration(
                      color: viewModel.listDistrict.isEmpty ? Colors.grey.withOpacity(0.1) : Colors.white,
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                      border: Border.all(color: Colors.grey.withOpacity(0.5))
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.place_outlined, color: Colors.black54, size: 20),
                          const SizedBox(width: 10),
                          RichText(
                            text: TextSpan(
                              style: const TextStyle(fontSize: 13, fontFamily: 'Roboto'),
                              children: [
                                const TextSpan(text: '* ', style: TextStyle(color: Colors.red)),
                                TextSpan(text: viewModel.districtName, style: const TextStyle(color: Colors.black)),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const Icon(Icons.keyboard_arrow_down_rounded, color: Colors.black54, size: 20),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        CustomDropdownButtonRelated(
          placeholderText: _wardPlaceholderText,
          data: viewModel.listWard,
          onSelectedCallback: (id, name) {
            setState(() {
              _wardId = id;
              viewModel.wardName = name;
              widget.onSelectedWardCallback?.call(id);
            });
          },
          selectId: _wardId,
          child: IgnorePointer(
            ignoring: viewModel.listWard.isEmpty,
            child: Stack(
              children: [
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  width: double.infinity,
                  height: 50,
                  decoration: BoxDecoration(
                      color: viewModel.listWard.isEmpty ? Colors.grey.withOpacity(0.1) : Colors.white,
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                      border: Border.all(color: Colors.grey.withOpacity(0.5))
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.place_outlined, color: Colors.black54, size: 20),
                          const SizedBox(width: 10),
                          RichText(
                            text: TextSpan(
                              style: const TextStyle(fontSize: 13, fontFamily: 'Roboto'),
                              children: [
                                const TextSpan(text: '* ', style: TextStyle(color: Colors.red)),
                                TextSpan(text: viewModel.wardName, style: const TextStyle(color: Colors.black)),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const Icon(Icons.keyboard_arrow_down_rounded, color: Colors.black54, size: 20),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
