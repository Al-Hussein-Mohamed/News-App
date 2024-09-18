import 'package:flutter/material.dart';
import 'package:news_app/core/config/color_palette.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../../models/category_model.dart';
import 'category_custom_widget.dart';

class CategoryBottomSheet extends StatelessWidget {
  void Function(CategoryModel)? categoryOnClicked;

  CategoryBottomSheet({
    super.key,
    required this.categoryOnClicked,
  });

  @override
  Widget build(BuildContext context) {
    var lang = AppLocalizations.of(context)!;
    var theme = Theme.of(context);
    var mediaQuery = MediaQuery.of(context);
    var screenHeight = mediaQuery.size.height;
    var screenWidth = mediaQuery.size.width;

    List<CategoryModel> categoryModelList = [
      CategoryModel(
        id: "sports",
        title: lang.sports,
        imagePath: "assets/icons/ball.png",
      ),
      CategoryModel(
        id: "general",
        title: lang.politics,
        imagePath: "assets/icons/Politics.png",
      ),
      CategoryModel(
        id: "health",
        title: lang.health,
        imagePath: "assets/icons/health.png",
      ),
      CategoryModel(
        id: "business",
        title: lang.business,
        imagePath: "assets/icons/bussines.png",
      ),
      CategoryModel(
        id: "entertainment",
        title: lang.environment,
        imagePath: "assets/icons/environment.png",
      ),
      CategoryModel(
        id: "science",
        title: lang.science,
        imagePath: "assets/icons/science.png",
      ),
    ];

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          height: screenHeight * .8,
          width: screenWidth,
          padding: const EdgeInsets.only(left: 25, right: 25, top: 30, bottom: 20),
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(100),
              topRight: Radius.circular(100),
            ),
          ),
          child: Column(
            children: [
              Text(
                "Categories",
                style: theme.textTheme.titleLarge
                    ?.copyWith(fontSize: 33, fontFamily: "Poppins"),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                "Pick your category of interest",
                style: TextStyle(
                  fontFamily: "Poppins",
                  fontSize: 17,
                  fontWeight: FontWeight.w800,
                  color: ColorPalette.textColor,
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Expanded(
                child: GridView.builder(
                  itemCount: categoryModelList.length,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 17,
                    crossAxisSpacing: 17,
                  ),
                  itemBuilder: (context, index) => CategoryCustomWidget(
                    index: index,
                    categoryModel: categoryModelList[index],
                    categoryOnClicked: categoryOnClicked,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
