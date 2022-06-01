import 'package:dominhduong/model/order_model.dart';
import 'package:flutter/material.dart';

class OrderDetailPage extends StatefulWidget {
  final OrderModel orderDetail;
  const OrderDetailPage({Key? key, required this.orderDetail}) : super(key: key);

  @override
  State<OrderDetailPage> createState() => _OrderDetailPageState();
}

class _OrderDetailPageState extends State<OrderDetailPage> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            children: [
              Column(
                children: widget.orderDetail.orderLines!.map((line) {
                  return Container(
                    decoration: BoxDecoration(
                      border: Border(bottom: BorderSide(width: 1, color: Colors.black.withOpacity(0.1))),
                    ),
                    child: ListTile(
                      contentPadding: EdgeInsets.zero,
                      title: Text(line.name??'', style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 14, color: Color(0xff3b2313))),
                      trailing: Text('${line.productUomQty} Sản phẩm', style: const TextStyle(fontSize: 13, color: Color(0xff3b2313))),
                      subtitle: Container(
                          margin: const EdgeInsets.only(top: 10),
                          child: (line.priceSubtotal!.isNotEmpty) ? Row(
                            children: [
                              const Icon(Icons.attach_money_outlined, size: 18, color: Color(0xff3b2313)),
                              const SizedBox(width: 2),
                              Text('Thành tiền: ${line.priceSubtotal}đ', style: const TextStyle(fontSize: 13, color: Color(0xff3b2313))),
                            ],
                          ) : const SizedBox(),
                      ),
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(height: 15),
              Row(
                children: [
                  const Text(r'Tổng tiền:', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18, color: Color(0xff3b2313))),
                  const Spacer(),
                  Text('${widget.orderDetail.amountTotal}đ', style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 18, color: Color(0xff3b2313))),
                ],
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
