import 'package:dominhduong/theme/colors.dart';
import 'package:dominhduong/utils/extensions/context_extension.dart';
import 'package:dominhduong/utils/extensions/text_styles_extension.dart';
import 'package:dominhduong/widgets/custom_cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../res.dart';
import 'custom_cached_network_image.dart';

class ChatItem extends StatefulWidget {
  final String pageRoutes;
  final String? urlNetworkImage;
  final String? userName;
  final String? contentChat;
  final String? timeLastMess;
  final bool isOnline;
  final bool isRead;

  const ChatItem(
      {Key? key,
      required this.pageRoutes,
      this.urlNetworkImage,
      this.userName,
      this.contentChat,
      this.timeLastMess,
      this.isOnline = false,
      this.isRead = false})
      : super(key: key);

  @override
  _ChatItemState createState() => _ChatItemState();
}

class _ChatItemState extends State<ChatItem> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 0, 0),
      child: Container(
        color: Colors.transparent,
        child: Row(
          children: [
            Stack(
              children: [
                widget.urlNetworkImage!.isNotEmpty
                    ? CustomNetworkImage(
                        height: 45,
                        width: 45,
                        url: widget.urlNetworkImage ?? '',
                        isCircle: true,
                      )
                    : CircleAvatar(radius: 45, child: SvgPicture.asset(Res.image_people, width: 45, height: 45)),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: SizedBox(
                    width: 14,
                    height: 14,
                    child: Container(
                      padding: const EdgeInsets.all(2),
                      decoration: BoxDecoration(
                        color: widget.isOnline ? AppColors.onlineUser : AppColors.grey,
                        shape: BoxShape.circle,
                        border: Border.all(width: 2, color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              width: 21,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 16, 5),
                    child: Text(widget.userName ?? '',
                        style: widget.isRead
                            ? context.textStyle(color: AppColors.textDark).size12.w400.fontRobotoSlab
                            : context.textStyle(color: Colors.black).size12.w600.fontRobotoSlab,
                        overflow: TextOverflow.ellipsis),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Flexible(
                        child: Container(
                            padding: const EdgeInsets.only(right: 5.0),
                            child: Text(widget.contentChat ?? '',
                                style: widget.isRead
                                    ? context.textStyle(color: AppColors.textDark).size12.w400.fontRoboto
                                    : context.textStyle(color: Colors.black).size12.w600.fontRoboto,
                                overflow: TextOverflow.ellipsis)),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 16.0),
                        child: Text(
                          widget.timeLastMess ?? '',
                          style: widget.isRead
                              ? context.textStyle(color: AppColors.textDark).size12.w400.fontRoboto
                              : context.textStyle(color: Colors.black).size12.w600.fontRoboto,
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
