import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:store_api_flutter_course/consts/global_colors.dart';
import 'package:store_api_flutter_course/models/discounted_products%20.dart';
import 'package:store_api_flutter_course/services/api_handler.dart';
import 'package:store_api_flutter_course/screens/feeds_screen.dart';
import 'package:store_api_flutter_course/screens/users_screen.dart';
import '../models/products_model.dart';
import '../widgets/appbar_icons.dart';
import '../widgets/feeds_widget.dart';
import '../widgets/sale_widget.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);

  final TextEditingController _textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
          appBar: AppBar(
            elevation: 4,
            title: const Text('Home'),
            leading: AppBarIcons(
              function: () {},
              icon: IconlyBold.category,
            ),
            actions: [
              AppBarIcons(
                function: () {
                  Navigator.push(
                    context,
                    PageTransition(
                      type: PageTransitionType.fade,
                      child: const UsersScreen(),
                    ),
                  );
                },
                icon: IconlyBold.user3,
              ),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                const SizedBox(
                  height: 18,
                ),
                TextField(
                  controller: _textEditingController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                      hintText: "Search",
                      filled: true,
                      fillColor: Theme.of(context).cardColor,
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide(
                          color: Theme.of(context).cardColor,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide(
                          width: 1,
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                      ),
                      suffixIcon: Icon(
                        IconlyLight.search,
                        color: lightIconsColor,
                      )),
                ),
                const SizedBox(
                  height: 18,
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(children: [
                      SizedBox(
                        height: size.height * 0.25,
                        child: FutureBuilder(
                          future: context.read<ApiHandler>().getDiscounts(),
                          builder: (context,
                              AsyncSnapshot<List<DiscountedProducts>>
                                  snapshot) {
                            if (snapshot.hasData && snapshot.data != null) {
                              return Swiper(
                                itemCount: snapshot.data![0].images![0].isEmpty
                                    ? 1
                                    : snapshot.data![0].images!.length,
                                itemBuilder: (ctx, index) {
                                  return SaleWidget(
                                    image: snapshot.data![0].images![0].isEmpty
                                        ? snapshot.data![0].category!.image!
                                        : snapshot.data![0].images![index],
                                    // image: snapshot.data![5].category!.image!,
                                  );
                                },
                                autoplay: true,
                                pagination: const SwiperPagination(
                                    alignment: Alignment.bottomCenter,
                                    builder: DotSwiperPaginationBuilder(
                                        color: Colors.white,
                                        activeColor: Colors.red)),
                                // control: const SwiperControl(),
                              );
                            }
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            const Text(
                              "Latest Products",
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 18,
                              ),
                            ),
                            const Spacer(),
                            AppBarIcons(
                                function: () {
                                  Navigator.push(
                                      context,
                                      PageTransition(
                                          type: PageTransitionType.fade,
                                          child: const FeedsScreen()));
                                },
                                icon: IconlyBold.arrowRight2),
                          ],
                        ),
                      ),
                      Consumer<ApiHandler>(
                        builder: (context, value, child) {
                          return FutureBuilder(
                            future: value.getProducts(),
                            builder: (context,
                                AsyncSnapshot<List<OurProducts>> snapshot) {
                              if (snapshot.hasData && snapshot.data != null) {
                                return GridView.builder(
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemCount: 5,
                                    gridDelegate:
                                        const SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount: 2,
                                            crossAxisSpacing: 0.0,
                                            mainAxisSpacing: 0.0,
                                            childAspectRatio: 0.7),
                                    itemBuilder: (ctx, index) {
                                      return FeedsWidget(
                                        myProduct: snapshot.data![index],
                                      );
                                    });
                              }
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            },
                          );
                        },
                      )
                    ]),
                  ),
                )
              ],
            ),
          )),
    );
  }
}
