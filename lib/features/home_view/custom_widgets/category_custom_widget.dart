import 'package:flutter/material.dart';
import 'package:news_app/core/config/color_palette.dart';

import '../../../models/category_model.dart';

class CategoryCustomWidget extends StatelessWidget {
  int index;
  CategoryModel categoryModel;
  void Function(CategoryModel)? categoryOnClicked;

  CategoryCustomWidget({
    super.key,
    required this.index,
    required this.categoryModel,
    required this.categoryOnClicked,
  });

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Container(
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(.2),
        border: Border.all(color: Colors.black.withOpacity(.15),),
        borderRadius: BorderRadius.only(
          topLeft: const Radius.circular(25),
          topRight: const Radius.circular(25),
          bottomLeft: index.isEven
              ? const Radius.circular(25)
              : const Radius.circular(0),
          bottomRight: index.isOdd
              ? const Radius.circular(25)
              : const Radius.circular(0),
        ),
      ),
      child: InkWell(
        onTap: () => categoryOnClicked!(categoryModel),
        borderRadius: BorderRadius.only(
          topLeft: const Radius.circular(25),
          topRight: const Radius.circular(25),
          bottomLeft: index.isEven
              ? const Radius.circular(25)
              : const Radius.circular(0),
          bottomRight: index.isOdd
              ? const Radius.circular(25)
              : const Radius.circular(0),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                  flex: 7,
                  child: Center(
                      child: Image.asset(
                    categoryModel.imagePath,
                  ))),
              Expanded(
                flex: 2,
                child: Center(
                  child: Text(
                    categoryModel.title,
                    style: const TextStyle(
                      fontFamily: "Exo",
                      fontSize: 22,
                      fontWeight: FontWeight.w400,
                      color: Colors.white,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
