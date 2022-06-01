import 'package:dominhduong/model/timeslot_model.dart';
import 'package:dominhduong/theme/colors.dart';
import 'package:flutter/material.dart';

class GridTime extends StatefulWidget {
  final List<TimeSlotModel> timeSlots;
  final Function(int?)? onTimeSlotSelectedCallback;
  final int? daySelected;
  final int? monthSelected;
  final int? yearSelected;
  final int? selectedIndex;
  final bool? isRefresh;

  const GridTime({Key? key, this.timeSlots = const [], this.onTimeSlotSelectedCallback, this.daySelected, this.monthSelected, this.yearSelected, this.selectedIndex, this.isRefresh}) : super(key: key);

  @override
  State<GridTime> createState() => _GridTimeState();
}

class _GridTimeState extends State<GridTime> {
  int? _selectedIndex = -1;
  int day = DateTime.now().day;
  int month =DateTime.now().month;
  int year = DateTime.now().year;

  bool canChoose(){
    bool choose;
    if(widget.yearSelected! > year){
     choose = true;
    }else{
      if(widget.monthSelected! > month){
        choose = true;
      }else{
        if(widget.daySelected! > day){
          choose = true;
        }else{
          choose = false;
        }
      }
    }
    return choose;
  }

  @override
  void didUpdateWidget(covariant GridTime oldWidget) {
    super.didUpdateWidget(oldWidget);
    if(oldWidget.isRefresh != widget.isRefresh || oldWidget.daySelected != widget.daySelected) {
      _selectedIndex = oldWidget.selectedIndex;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      shrinkWrap: true,
      childAspectRatio: 1,
      crossAxisSpacing: 20,
      mainAxisSpacing: 1,
      padding: EdgeInsets.zero,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 5,
      children: List.generate(widget.timeSlots.length, (index) {
        return IgnorePointer(
          ignoring: canChoose() ? false : !widget.timeSlots[index].isSelected,
          child: InkWell(
            highlightColor: Colors.transparent,
            splashColor: Colors.transparent,
            onTap: () {
              setState(() {
                _selectedIndex = index;
                widget.onTimeSlotSelectedCallback?.call(widget.timeSlots[index].id);
              });
            },
            child: Center(
              child: Container(
                height: 40.0,
                width: 64.0,
                child: Center(
                    child: Text(
                        widget.timeSlots.isNotEmpty ? widget.timeSlots[index].timeStart ?? '' : '',
                        style: TextStyle(
                            fontWeight: FontWeight.w400,
                            color: canChoose() ? Colors.black : (widget.timeSlots[index].isSelected ? Colors.black : Colors.black26),
                            fontSize: 14.0, fontFamily: 'Roboto', fontStyle: FontStyle.normal
                        )
                    )
                ),
                decoration: BoxDecoration(
                    color: widget.timeSlots.isNotEmpty && _selectedIndex == index ? AppColors.primaryColor : Colors.white,
                    borderRadius: const BorderRadius.all(Radius.circular(8)),
                    border: Border.all(color: widget.timeSlots.isNotEmpty && _selectedIndex == index ? AppColors.primaryColor : Colors.grey.withOpacity(0.5))
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}