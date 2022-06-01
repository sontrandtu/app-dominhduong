import 'package:dominhduong/screens/order_medicine/selected_category_view_model.dart';
import 'package:dominhduong/widgets/cover_loading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SelectedCategoryWidget extends StatefulWidget {

  final Function(int, String)? onSelectedCallback;

  const SelectedCategoryWidget({Key? key, this.onSelectedCallback}) : super(key: key);

  @override
  _SelectedCategoryWidgetState createState() => _SelectedCategoryWidgetState();
}

class _SelectedCategoryWidgetState extends State<SelectedCategoryWidget> {
  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<SelectedCategoryViewModel>();
    return Padding(
        padding: MediaQuery.of(context).viewInsets,
      child: StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return CoverLoading(
              showLoading: viewModel.isLoading,
              child: Stack(
                children: [
                  ListView.builder(
                    padding: const EdgeInsets.only(left: 10, top: 50, right: 10, bottom: 10),
                    physics: const ClampingScrollPhysics(),
                    itemCount: viewModel.categories.isEmpty ? 0 : viewModel.categories.length -1,
                    itemBuilder: (BuildContext context, int index) {
                      final item = viewModel.categories[index + 1];
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            widget.onSelectedCallback?.call(item.id!, item.name!);
                            Navigator.pop(context);
                          });
                        },
                        child: Container(
                          margin: const EdgeInsets.symmetric(vertical: 5),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 15),
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.grey.withOpacity(0.1),
                            borderRadius: const BorderRadius.all(Radius.circular(8)),
                              border: Border.all(color: Colors.grey.withOpacity(0.1))
                          ),
                          child: Text(item.name ?? '', style: const TextStyle(fontSize: 13, fontFamily: 'Roboto', color: Colors.black)),
                        ),
                      );
                    },
                  ),
                  Container(
                    padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(15),
                        topRight: Radius.circular(15),
                      ),
                    ),
                    child: Text(viewModel.header, style: const TextStyle(fontSize: 14, fontFamily: 'RobotoSlab', color: Colors.black, fontWeight: FontWeight.w700)),
                  ),
                ],
              ),
            );
          }
      ),
    );
  }
}
