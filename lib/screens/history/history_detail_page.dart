import 'package:dominhduong/model/history_model.dart';
import 'package:flutter/material.dart';

class HistoryDetailPage extends StatefulWidget {
  final HistoryModel historyModel;
  const HistoryDetailPage({Key? key, required this.historyModel}) : super(key: key);

  @override
  State<HistoryDetailPage> createState() => _HistoryDetailPageState();
}

class _HistoryDetailPageState extends State<HistoryDetailPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(widget.historyModel.name!, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                const SizedBox(height: 20),
                Row(
                  children: [
                    const Icon(Icons.watch_later_outlined, size: 20, color: Color(0xff808080)),
                    const SizedBox(width: 6),
                    Text('Vào lúc ${widget.historyModel.timeSlotName}', style: const TextStyle(fontSize: 14, color: Color(0xff808080))),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    const Icon(Icons.calendar_today, size: 20, color: Color(0xff808080),),
                    const SizedBox(width: 6),
                    Text('Ngày ${widget.historyModel.dateStart}', style: const TextStyle(fontSize: 14, color: Color(0xff808080))),
                  ],
                ),
                SizedBox(height: widget.historyModel.physicianName != null ? 20 : 0),
                widget.historyModel.physicianName != null ? Row(
                  children: [
                    const Icon(Icons.account_circle_outlined, size: 20, color: Color(0xff808080),),
                    const SizedBox(width: 6),
                    Text('Với bác sĩ: ${widget.historyModel.physicianName ?? ''}', style: const TextStyle(fontSize: 14, color: Color(0xff808080))),
                  ],
                ) : const SizedBox(width: 0),
                const SizedBox(height: 20),
                Text('Nội dung: ${widget.historyModel.reason!}', style: const TextStyle(fontSize: 14)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}