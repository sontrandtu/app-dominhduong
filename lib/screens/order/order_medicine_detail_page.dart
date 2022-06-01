import 'package:dominhduong/model/order_medicine_model.dart';
import 'package:dominhduong/widgets/appbar/appbar_comp.dart';
import 'package:dominhduong/widgets/custom_cached_network_image.dart';
import 'package:flutter/material.dart';

import 'order/full_photo_page.dart';

class OrderDetailPage extends StatelessWidget {
  final OrderMedicineModel orderDetail;
  const OrderDetailPage({Key? key, required this.orderDetail})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PageAppBarComp(title: 'Chi tiết đơn hàng'.toUpperCase()),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: SingleChildScrollView(
            physics: const ClampingScrollPhysics(),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Row(
                      children: const [
                        Expanded(
                            child: Divider(
                                color: Colors.black, thickness: 1, height: 20)),
                        Text('Hình ảnh đơn thuốc',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Roboto',
                                fontSize: 16)),
                        Expanded(
                            child: Divider(
                                color: Colors.black, thickness: 1, height: 20)),
                      ],
                    ),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: (orderDetail.isHavePrescription!)
                        ? SizedBox(
                            child: Center(
                            child: GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => FullPhotoPage(
                                              url: orderDetail.imageUrl)));
                                },
                                child: CustomNetworkImage(
                                    url: orderDetail.imageUrl,
                                    width: 100,
                                    height: 100)),
                          ))
                        : const Text('Đơn hàng này không có hình ảnh đơn thuốc',
                            textAlign: TextAlign.center),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Row(
                      children: const [
                        Expanded(
                            child: Divider(
                                color: Colors.black, thickness: 1, height: 20)),
                        Text('Thông tin đặt hàng',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Roboto',
                                fontSize: 16)),
                        Expanded(
                            child: Divider(
                                color: Colors.black, thickness: 1, height: 20)),
                      ],
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 5),
                      LineCard(
                          title: 'Danh mục bệnh: ',
                          content: orderDetail.categoryName ?? ''),
                      LineCard(
                          title: 'Số liệu trình thuốc: ',
                          content: orderDetail.quantity.toString()),
                      LineCard(
                          title: 'Đã có đơn thuốc: ',
                          content: orderDetail.isHavePrescription!
                              ? 'Đã có'
                              : 'Chưa có'),
                      LineCard(
                          title: 'Ngày đặt: ',
                          content: orderDetail.dateOrder ?? ''),
                      LineCard(
                          title: 'Ghi chú: ', content: orderDetail.note ?? ''),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Row(
                      children: const [
                        Expanded(
                            child: Divider(
                                color: Colors.black, thickness: 1, height: 20)),
                        Text('Thông tin khách hàng',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Roboto',
                                fontSize: 16)),
                        Expanded(
                            child: Divider(
                                color: Colors.black, thickness: 1, height: 20)),
                      ],
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      LineCard(
                          title: 'Khách hàng: ',
                          content: orderDetail.partnerName ?? ''),
                      LineCard(
                          title: 'Số điện thoại: ',
                          content: orderDetail.receiverPhone ?? ''),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Row(
                      children: const [
                        Expanded(
                            child: Divider(
                                color: Colors.black, thickness: 1, height: 20)),
                        Text('Thông tin vận chuyển',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Roboto',
                                fontSize: 16)),
                        Expanded(
                            child: Divider(
                                color: Colors.black, thickness: 1, height: 20)),
                      ],
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      LineCard(
                          title: 'Khách hàng: ',
                          content: orderDetail.receiverName ?? ''),
                      LineCard(
                          title: 'SĐT người nhận: ',
                          content: orderDetail.receiverPhone ?? ''),
                      LineCard(
                          title: 'Tỉnh/Thành phố: ',
                          content: orderDetail.provinceName ?? ''),
                      LineCard(
                          title: 'Quận/Huyện: ',
                          content: orderDetail.districtName ?? ''),
                      LineCard(
                          title: 'Phường/Xã: ',
                          content: orderDetail.wardName ?? ''),
                      LineCard(
                          title: 'Địa chỉ giao hàng: ',
                          content: orderDetail.address ?? ''),
                      LineCard(
                          title: 'Hình thức thanh toán: ',
                          content: orderDetail.paymentType ?? ''),
                      LineCard(
                          title: 'Ghi chú vận chuyển: ',
                          content: orderDetail.deliveryNote ?? ''),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class LineCard extends StatelessWidget {
  final String? title;
  final String? content;
  const LineCard({
    Key? key,
    this.title,
    this.content,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: RichText(
        text: TextSpan(
            style: const TextStyle(
              fontSize: 14,
              fontFamily: 'Roboto',
            ),
            children: [
              TextSpan(
                  text: title!,
                  style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Roboto',
                      fontSize: 14)),
              TextSpan(
                  text: content!,
                  style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w400,
                      fontFamily: 'Roboto',
                      fontSize: 14))
            ]),
      ),
    );
  }
}
