import 'package:dominhduong/model/company_model.dart';
import 'package:dominhduong/model/doctor_model.dart';
import 'package:flutter/material.dart';

class DropDownBT extends StatefulWidget {
  final List<DoctorModel> doctors;
  final List<CompanyModel> companies;
  final Function(String)? onDoctorSelectedCallback;
  final Function(String)? onCompanySelectedCallback;

  const DropDownBT({Key? key, this.doctors = const [], this.companies = const [], this.onDoctorSelectedCallback, this.onCompanySelectedCallback}) : super(key: key);

  @override
  State<DropDownBT> createState() => _DropDownBTState();
}

class _DropDownBTState extends State<DropDownBT> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            height: 50,
            width: double.infinity,
            margin: const EdgeInsets.only(bottom: 10, top: 10),
            decoration: BoxDecoration(color: Colors.grey.withOpacity(0.2), borderRadius: BorderRadius.circular(10)),
            child: DropdownButtonFormField<String>(
              decoration: const InputDecoration(enabledBorder: InputBorder.none, prefixIcon: Icon(Icons.place_outlined, color: Colors.black, size: 20)),
              hint: const Text('Chọn chi nhánh', style: TextStyle(fontSize: 12, fontFamily: 'Roboto', color: Colors.black)),
              items: List.generate(widget.companies.length, (index) {
                return DropdownMenuItem<String>(
                  value: widget.companies[index].id.toString(),
                  child: Text(widget.companies[index].name.toString()),
                );
              }),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Bạn vui chọn chi nhánh';
                }
                return null;
              },
              onChanged: (newValue) {
                setState(() {
                 widget.onCompanySelectedCallback?.call(newValue!);
                });
              },
            ),
          ),
          Container(
            height: 50,
            margin: const EdgeInsets.only(bottom: 10, top: 10),
            decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.2),
              borderRadius: BorderRadius.circular(10),
            ),
            child: DropdownButtonFormField<String>(
              decoration: const InputDecoration(
                enabledBorder: InputBorder.none,
                prefixIcon: Icon(Icons.perm_contact_calendar_outlined, color: Colors.black, size: 20),
              ),
              hint: const Text(r'Chọn bác sĩ', style: TextStyle(fontSize: 12, fontFamily: 'Roboto', color: Colors.black)),
              items: List.generate(widget.doctors.length, (index) {
                return DropdownMenuItem<String>(
                  value: widget.doctors[index].id.toString(),
                  child: Text(widget.doctors[index].name.toString()),
                );
              }),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Bạn vui lòng chọn bác sĩ';
                }
                return null;
              },
              onChanged: (newValue) {
                setState(() {
                  widget.onDoctorSelectedCallback?.call(newValue!);
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}
