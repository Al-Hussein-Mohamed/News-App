import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:news_app/core/application_theme_manager.dart';
import 'package:news_app/features/drawer_view/drawer_view.dart';
import 'package:news_app/features/home_view/custom_widgets/category_custom_widget.dart';
import 'package:news_app/models/category_model.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  CategoryModel? selectedCategory;

  @override
  Widget build(BuildContext context) {
    final _scaffoldKey = new GlobalKey<ScaffoldState>();
    var lang = AppLocalizations.of(context)!;
    var theme = Theme.of(context);
    var mediaQuery = MediaQuery.of(context);
    var screenHeight = mediaQuery.size.height;
    var screenWidth = mediaQuery.size.width;

    List<CategoryModel> categoryModelList = [
      CategoryModel(
        id: "sport",
        title: lang.sports,
        imagePath: "assets/icons/ball.png",
        backgroundColor: const Color(0xFFC91C22),
      ),
      CategoryModel(
        id: "politics",
        title: lang.politics,
        imagePath: "assets/icons/Politics.png",
        backgroundColor: const Color(0xFF003E90),
      ),
      CategoryModel(
        id: "health",
        title: lang.health,
        imagePath: "assets/icons/health.png",
        backgroundColor: const Color(0xFFED1E79),
      ),
      CategoryModel(
        id: "business",
        title: lang.business,
        imagePath: "assets/icons/bussines.png",
        backgroundColor: const Color(0xFFCF7E48),
      ),
      CategoryModel(
        id: "environment",
        title: lang.environment,
        imagePath: "assets/icons/environment.png",
        backgroundColor: const Color(0xFF4882CF),
      ),
      CategoryModel(
        id: "science",
        title: lang.science,
        imagePath: "assets/icons/science.png",
        backgroundColor: const Color(0xFFF2D352),
      ),
    ];

    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        image: DecorationImage(
          image: AssetImage("assets/images/pattern.png"),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: selectedCategory == null
              ? Text(lang.newsApp)
              : Text(selectedCategory!.title),
          leading: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 6),
              child: IconButton(
                  onPressed: () => _scaffoldKey.currentState?.openDrawer(),
                  icon: const Icon(
                    Icons.menu_rounded,
                  ))),
        ),
        drawer: DrawerView(categoryDrawBarOnClicked,),
        body: selectedCategory == null ? Padding(
          padding: EdgeInsets.symmetric(
              horizontal: screenWidth * .075, vertical: screenHeight * .04),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                lang.pickYourCategoryOfInterest,
                style: theme.textTheme.bodyLarge,
              ),
              const SizedBox(
                height: 25,
              ),
              Expanded(
                child: GridView.builder(
                  itemCount: categoryModelList.length,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 16,
                    crossAxisSpacing: 16,
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
        ) : Text(selectedCategory!.title),
      ),
    );
  }

  void categoryOnClicked(CategoryModel categoryModel) {
    setState(() => selectedCategory = categoryModel);
  }

  void categoryDrawBarOnClicked() {
    setState(() => selectedCategory = null);
  }
}
