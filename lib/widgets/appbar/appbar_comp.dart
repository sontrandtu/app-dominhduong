import 'package:dominhduong/theme/colors.dart';
import 'package:dominhduong/theme/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../res.dart';

class PageAppBarComp extends StatefulWidget implements PreferredSizeWidget {
  final String title;
  final bool canPop;
  final bool backHome;
  final bool search;
  final bool favorite;
  final bool isFavoriteActive;
  final Function(String)? searchCallback;
  final Function(bool)? favoriteCallback;
  late bool showSearchBox;
  final bool? clearText;

  PageAppBarComp(
      {Key? key,
        required this.title,
        this.canPop = true,
        this.backHome = false,
        this.search = false,
        this.showSearchBox = false,
        this.favorite = false,
        this.isFavoriteActive = false,
        this.searchCallback,
        this.favoriteCallback,
        this.clearText,
      })
      : super(key: key);

  @override
  State<PageAppBarComp> createState() => _PageAppBarCompState();

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(50);
}

class _PageAppBarCompState extends State<PageAppBarComp> {
  final TextEditingController _keyword = TextEditingController();


  @override
  void didUpdateWidget(covariant PageAppBarComp oldWidget) {
    super.didUpdateWidget(oldWidget);
    if(oldWidget.clearText != widget.clearText){
      _keyword.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: const Size.fromHeight(50),
      child: Stack(
        children: [
          AppBar(
            iconTheme: const IconThemeData(color: AppColors.secondaryColor),
            elevation: 0,
            centerTitle: true,
            automaticallyImplyLeading: false,
            titleSpacing: 0,
            leadingWidth: 28,
            leading: widget.canPop
                ? Builder(
              builder: (BuildContext context) {
                return IconButton(
                  padding: const EdgeInsets.only(
                      left: 20, right: 0, top: 0, bottom: 0),
                  alignment: Alignment.center,
                  icon: const Icon(Icons.arrow_back_ios,
                      color: AppColors.backgroundBlack, size: 18),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                );
              },
            )
                : const SizedBox(width: 0),
            title: Builder(builder: (BuildContext context) {
              return Text(widget.title,
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                      color: AppColors.secondaryColor,
                      fontSize: 16,
                      fontFamily: 'RobotoSlab',
                      fontWeight: FontWeight.w700));
            }),
            actions: [
              widget.backHome
                  ? SizedBox(
                width: 35,
                child: Builder(
                  builder: (BuildContext context) {
                    return IconButton(
                        padding: EdgeInsets.zero,
                        alignment: Alignment.center,
                        icon: SvgPicture.asset(Res.ic_dashboard,
                            height: 20),
                        onPressed: () {
                          Navigator.of(context).pop();
                        });
                  },
                ),
              )
                  : const SizedBox(width: 0),
              widget.search
                  ? SizedBox(
                width: 35,
                child: Builder(
                  builder: (BuildContext context) {
                    return IconButton(
                        padding: EdgeInsets.zero,
                        alignment: Alignment.center,
                        icon: SvgPicture.asset(Res.ic_search, height: 20),
                        onPressed: () {
                          setState(() {
                            widget.showSearchBox = true;
                          });
                        });
                  },
                ),
              )
                  : const SizedBox(width: 0),
              widget.favorite
                  ? SizedBox(
                width: 35,
                child: Builder(
                  builder: (BuildContext context) {
                    return IconButton(
                        padding: EdgeInsets.zero,
                        alignment: Alignment.center,
                        icon: SvgPicture.asset(
                            widget.isFavoriteActive
                                ? Res.ic_favorite
                                : Res.ic_favorite_outlined,
                            height: 22,
                            color: widget.isFavoriteActive
                                ? AppColors.textRed.withOpacity(0.7)
                                : AppColors.textBlack),
                        onPressed: () {
                          setState(() {
                            widget.favoriteCallback
                                ?.call(!widget.isFavoriteActive);
                          });
                        });
                  },
                ),
              )
                  : const SizedBox(width: 0),
            ],
            backgroundColor: AppColors.primaryColor,
          ),
          Visibility(
            visible: widget.showSearchBox,
            child: Positioned(
                bottom: 0,
                left: 0,
                height: 50,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 50,
                  color: AppColors.primaryColor,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 38,
                        child: IconButton(
                          splashColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          alignment: Alignment.center,
                          icon: const Icon(Icons.arrow_back_ios,
                              color: AppColors.backgroundBlack,
                              size: 18), // Put icon of your preference.
                          onPressed: () {
                            _keyword.text = '';
                            setState(() {
                              widget.showSearchBox = false;
                              widget.searchCallback?.call('');
                            });
                          },
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width - 60,
                        height: 38,
                        margin: const EdgeInsets.only(right: 10),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(5)),
                        child: TextField(
                          autofocus: true,
                          textAlign: TextAlign.left,
                          controller: _keyword,
                          textInputAction: TextInputAction.search,
                          onSubmitted: (String value) {
                            setState(() {
                              widget.searchCallback?.call(value);
                            });
                          },
                          decoration: InputDecoration(
                              prefixIcon: const Icon(Icons.search, size: 20),
                              suffixIcon: IconButton(
                                splashColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                icon: const Icon(Icons.clear, size: 20),
                                onPressed: () {
                                  _keyword.text = '';
                                  setState(() {
                                    widget.searchCallback?.call('');
                                  });
                                },
                              ),
                              hintText: 'Tìm kiếm...',
                              border: InputBorder.none),
                        ),
                      ),
                    ],
                  ),
                )),
          )
        ],
      ),
    );
  }
}

PreferredSize signUpAppBarComp({required String title}) {
  return PreferredSize(
    preferredSize: const Size.fromHeight(31.52),
    child: AppBar(
      elevation: 0,
      centerTitle: true,
      leadingWidth: 28.0,
      leading: Builder(
        builder: (BuildContext context) {
          return IconButton(
            padding:
            const EdgeInsets.only(left: 10, right: 0, top: 0, bottom: 0),
            alignment: Alignment.center,
            icon: const Icon(Icons.arrow_back_ios,
                color: AppColors.backgroundBlack,
                size: 18), // Put icon of your preference.
            onPressed: () {
              Navigator.of(context).pop();
            },
          );
        },
      ),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: AppColors.secondaryColor,
              fontSize: 18,
              fontFamily: 'RobotoSlab',
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 7)
        ],
      ),
      backgroundColor: AppColors.primaryColor,
    ),
  );
}

Padding appBarSignIn({required String title}) {
  return Padding(
    padding: const EdgeInsets.only(left: 10.0, right: 30.0),
    child: Row(
      children: [
        Expanded(
          child: Builder(builder: (context) {
            return IconButton(
              alignment: Alignment.centerLeft,
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: const Icon(Icons.arrow_back_ios,
                  color: AppColors.backgroundBlack, size: 18),
            );
          }),
          flex: 1,
        ),
        Expanded(
          child: Center(
            child: Text(
              title.toUpperCase(),
              style: const TextStyle(
                  color: AppColors.secondaryColor,
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  fontFamily: AppStyles.RobotoSlab),
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          flex: 9,
        ),
      ],
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
    ),
  );
}

PreferredSize homeAppBarComp() {
  return PreferredSize(
    preferredSize: const Size.fromHeight(0),
    child: AppBar(
      elevation: 0,
      centerTitle: true,
      leadingWidth: 0,
      leading: Builder(
        builder: (BuildContext context) {
          return const SizedBox();
        },
      ),
      title: const SizedBox(),
      backgroundColor: AppColors.primaryColor,
    ),
  );
}

