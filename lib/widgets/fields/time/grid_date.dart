import 'package:dominhduong/model/date_model.dart';
import 'package:dominhduong/app_config.dart';
import 'package:dominhduong/utils/extensions/context_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';

class GridDate extends StatefulWidget {
  final Function(String)? onDateSelectedCallback;
  final bool? isRefresh;

  const GridDate({Key? key, this.onDateSelectedCallback, this.isRefresh}) : super(key: key);

  @override
  State<GridDate> createState() => _GridDateState();
}

class _GridDateState extends State<GridDate> {
  int dayNumber = 3;
  DateTime dateTime = DateTime.now();
  int selectedDate = 0;
  List<DateModel> sampleData = [];

  @override
  void initState() {
    super.initState();

    for (var i = 0; i <= dayNumber; i++) {
      var dayOfWeek = AppConfig.dayOfWeekConvert[DateFormat('EEEE').format(dateTime.subtract(Duration(days: -i)))];
      sampleData.add(DateModel(dayOfWeek!, DateFormat('dd/MM/yyyy').format(dateTime.subtract(Duration(days: -i))), DateFormat('dd/MM').format(dateTime.subtract(Duration(days: -i))), false));
    }
    sampleData.add(DateModel('+', '', '', true));
    widget.onDateSelectedCallback?.call(sampleData[selectedDate].day);
  }


  @override
  void didUpdateWidget(covariant GridDate oldWidget) {
    super.didUpdateWidget(oldWidget);
    if(oldWidget.isRefresh != widget.isRefresh){
      selectedDate = -1;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      childAspectRatio: 1,
      crossAxisSpacing: 15,
      padding: EdgeInsets.zero,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: sampleData.length,
      children: List.generate(sampleData.length, (index) {
        bool isLast = index == sampleData.length - 1;
        return GestureDetector(
          onTap: () {
            if(sampleData[index].isChooseDate){
              context.hideKeyboard();
              DatePicker.showDatePicker(context, showTitleActions: true, minTime: DateTime.now(), onChanged: (date) {}, onConfirm: (DateTime date) {
                setState(() {
                  selectedDate = index;
                  sampleData.removeLast();
                  sampleData.add(DateModel('+', DateFormat('dd/MM/yyyy').format(date), DateFormat('dd/MM').format(date), true));
                  widget.onDateSelectedCallback?.call(DateFormat('dd/MM/yyyy').format(date));
                });
              }, currentTime: sampleData[index].day.isEmpty ? DateTime.now() : DateFormat('dd/MM/yyyy').parse(sampleData[index].day), locale: LocaleType.vi);
            }else{
              setState(() {
                selectedDate = index;
                widget.onDateSelectedCallback?.call(sampleData[selectedDate].day);
                sampleData.removeLast();
                sampleData.add(DateModel('+', '', '', true));
              });
            }
          },
          child: SizedBox(
            width: 50,
            height: 56,
            child: Column(
              children: <Widget>[
                Container(
                    height: 28,
                    width: 50,
                    child: Center(
                        child: Text(
                            sampleData[index].dateTime.toString(),
                            style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 14.0)
                        )
                    ),
                    decoration: BoxDecoration(
                        color: selectedDate == index ? Theme.of(context).colorScheme.primary : Colors.grey.withOpacity(0.3),
                        borderRadius: const BorderRadius.only(topLeft: Radius.circular(8), topRight: Radius.circular(8))
                    )
                ),
                Container(
                  height: 28,
                  width: 50,
                  child: Center(
                      child: Text(
                          sampleData[index].dayDisplay,
                          style: const TextStyle(color: Colors.black, fontWeight: FontWeight.w400, fontSize: 12.0)
                      )
                  ),
                  decoration: BoxDecoration(
                      color: selectedDate == index ? Theme.of(context).colorScheme.primary.withOpacity(0.5) : Colors.grey.withOpacity(0.1),
                      borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(8), bottomRight: Radius.circular(8))
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
