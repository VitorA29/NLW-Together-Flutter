import 'package:flutter/material.dart';
import 'package:payflow/shared/models/user_model.dart';

import '../../shared/app_strings.pt_BR.dart';
import '../../shared/themes/app_colors.dart';
import '../../shared/themes/app_text_styles.dart';
import '../extract/extract_page.dart';
import '../my_boletos/my_boletos_page.dart';
import 'home_controller.dart';

class HomePage extends StatefulWidget
{
  final UserModel user;

  const HomePage({
    Key? key,
    required this.user,
  }) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
{
  final homeController = HomeController();

  void setPage(int index)
  {
    homeController.setPage(index);
    setState(() {});
  }

  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(152),
        child: Container(
          height: 152,
          color: AppColors.primary,
          child: Center(
            child: ListTile(
              title: Text.rich(
                TextSpan(
                  text: AppStrings.homePageAppBarUserNameTitle,
                  style: AppTextStyles.titleRegular,
                  children: [
                    TextSpan(
                      text: "${widget.user.name}",
                      style: AppTextStyles.titleBoldBackground,
                    )
                  ],
                )
              ),
              subtitle: Text(
                AppStrings.homePageAppBarSubtitle,
                style: AppTextStyles.captionShape,
              ),
              trailing: Container(
                height: 48,
                width: 48,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(5),
                  image: DecorationImage(
                    image: NetworkImage(widget.user.photoURL!),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
      body: [
        MyBoletosPage(
          key: UniqueKey(),
        ),
        ExtractPage(
          key: UniqueKey(),
        ),
      ][homeController.currentPage],
      bottomNavigationBar: Container(
        height: 90,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
              icon: Icon(
                Icons.home,
                color: homeController.currentPage == 0
                        ? AppColors.primary
                        : AppColors.body,
              ),
              onPressed: () {
                setPage(0);
              },
            ),
            GestureDetector(
              onTap: () async
              {
                await Navigator.pushNamed(context, "/barcode_scanner");
                setState(() {});
              },
              child: Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Icon(
                    Icons.add_box_outlined,
                    color: AppColors.background,
                ),
              ),
            ),
            IconButton(
              icon: Icon(
                Icons.description_outlined,
                color: homeController.currentPage == 1
                        ? AppColors.primary
                        : AppColors.body,
              ),
              onPressed: () {
                setPage(1);
              },
            ),
          ],
        ),
      ),
    );
  }
}
