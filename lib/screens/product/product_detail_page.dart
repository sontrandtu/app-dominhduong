import 'dart:async';
import 'package:dominhduong/screens/product/product_detail_view_model.dart';
import 'package:dominhduong/widgets/cover_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import '../../res.dart';
import '../../theme/colors.dart';
import '../../widgets/html_content.dart';

class ProductDetailPage extends StatefulWidget {
  const ProductDetailPage({Key? key}) : super(key: key);

  @override
  _ProductDetailPageState createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  late ScrollController _scrollController;
  Color _textColor = Colors.transparent;
  static const kExpandedHeight = 280.0;
  String text = '';
  ProductDetailViewModel get viewModel => context.watch<ProductDetailViewModel>();
  StreamController titleController = StreamController<dynamic>.broadcast();
  Stream get titleStream => titleController.stream;


  @override
  void initState() {
    _scrollController = ScrollController()
      ..addListener(() {
        text = _isSliverAppBarExpanded ? (Provider.of<ProductDetailViewModel>(context, listen: false).article?.name ?? "Đỗ Minh Gia Quý").toUpperCase() : '';
        _textColor = _isSliverAppBarExpanded ? AppColors.primaryColor : Colors.transparent;
        titleController.sink.add(text);
        titleController.sink.add(_textColor);
      });

    super.initState();
  }

  bool get _isSliverAppBarExpanded {
    return _scrollController.hasClients && kToolbarHeight > kExpandedHeight - _scrollController.offset;
  }

  @override
  Widget build(BuildContext context) {
    //final viewModel = context.watch<ProductDetailViewModel>();
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            CoverLoading(
              showLoading: viewModel.isLoading,
              child: CustomScrollView(
                controller: _scrollController,
                physics: const ClampingScrollPhysics(),
                slivers: <Widget>[
                  StreamBuilder(
                    stream: titleStream,
                    builder: (context, snapshot) => SliverAppBar(
                      title: Text(text),
                      elevation: 0,
                      centerTitle: true,
                      automaticallyImplyLeading: false,
                      backgroundColor: _textColor,
                      systemOverlayStyle: SystemUiOverlayStyle(
                          statusBarColor: _textColor,
                          statusBarIconBrightness: Brightness.dark),
                      leading: IconButton(
                        padding: EdgeInsets.zero,
                        icon: const Icon(Icons.arrow_back_ios,
                            color: AppColors.secondaryColor, size: 18),
                        // Put icon of your preference.
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                      expandedHeight: kExpandedHeight,
                      flexibleSpace: FlexibleSpaceBar(
                        background: Stack(
                          children: [
                            Positioned(
                                top: 0,
                                bottom: 30,
                                left: 0,
                                right: 0,
                                child: ClipRRect(
                                    child: Image.network(
                                      viewModel.article?.imageUrl ?? '',
                                      fit: BoxFit.fill,
                                    ),
                                    borderRadius: const BorderRadius.only(
                                        bottomLeft: Radius.circular(40)))),
                            Positioned(
                              bottom: 0,
                              right: 0,
                              child: Container(
                                width: 300,
                                padding: const EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 15),
                                decoration: const BoxDecoration(
                                  color: Color(0xffF3F1F1),
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(100),
                                      bottomLeft: Radius.circular(100)),
                                ),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceAround,
                                  children: [
                                    Column(
                                      children: [
                                        SvgPicture.asset(viewModel.article?.rating != 0 ? Res.ic_star : Res.ic_star_outline, height: 24, color: AppColors.primaryColor),
                                        const SizedBox(height: 2),
                                        Text(
                                            viewModel.article?.rating
                                                .toString() ??
                                                '5.0',
                                            style: const TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w700,
                                                color: AppColors.textBlack,
                                                fontFamily: 'RobotSlab'))
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      pinned: true,
                    ) ,
                  ),
                  SliverToBoxAdapter(
                    child: SingleChildScrollView(
                      reverse: true,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 30),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Text(
                              viewModel.article?.name?.toUpperCase() ?? '',
                              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: AppColors.primaryColor, fontFamily: 'RobotSlab'),
                            ),
                          ),
                          HtmlContent(content: viewModel.article?.content ?? ''),
                          const SizedBox(height: 25),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
