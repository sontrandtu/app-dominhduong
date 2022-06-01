import 'package:dominhduong/model/examination_card_model.dart';
import 'package:flutter/material.dart';

class ExaminationCardDetailPage extends StatefulWidget {
  final ExaminationCardModel examinationCardDetail;

  const ExaminationCardDetailPage({Key? key, detail, required this.examinationCardDetail}) : super(key: key);

  @override
  _ExaminationCardDetailPageState createState() => _ExaminationCardDetailPageState();
}

class _ExaminationCardDetailPageState extends State<ExaminationCardDetailPage> {
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
                Row(
                  children: [
                    Text('Mã phiếu khám: ${widget.examinationCardDetail.name}', style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 16, color: Color(0xff3b2313))),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(Icons.watch_later_outlined, size: 15),
                    const SizedBox(width: 4),
                    Text(widget.examinationCardDetail.dateStart??'', style: const TextStyle(fontSize: 14, fontFamily: 'Roboto'),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                if(widget.examinationCardDetail.physicianId != null) Row(
                  children: [
                    const Icon(Icons.account_circle_outlined, size: 15),
                    const SizedBox(width: 5),
                    Text(widget.examinationCardDetail.physicianName ?? '', style: const TextStyle(fontSize: 14)),
                  ],
                ),
                if(widget.examinationCardDetail.detail != null)
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 15),
                      const Text(r'Kết quả:', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Color(0xff3b2313))),
                      const SizedBox(height: 6),
                      Text(widget.examinationCardDetail.detail ?? '', style: const TextStyle(fontSize: 14, height: 1.5)),
                    ],
                  )
              ],
            ),
          ),
        ),
      ),
    );
  }
}