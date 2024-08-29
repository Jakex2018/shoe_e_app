import 'package:eco_app/models/arrival.dart';
import 'package:eco_app/models/brands.dart';
import 'package:eco_app/page/cart_page.dart';
import 'package:eco_app/page/shoes_page.dart';
import 'package:eco_app/widget/arrival_items.dart';
import 'package:eco_app/widget/brand_image.dart';
import 'package:eco_app/widget/desc_text_button.dart';
import 'package:eco_app/widget/drawer_body.dart';
import 'package:eco_app/widget/list_option.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  BrandCategory? selectCategory = BrandCategory.all;
  List<dynamic> shoes = [];

  @override
  void dispose() {
    super.dispose();
  }

  final GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldkey,
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const CartPage(),
                      ));
                },
                child: const Icon(Icons.shopify_outlined)),
          ),
        ],
        leading: GestureDetector(
            onTap: () {
              _scaffoldkey.currentState?.openDrawer();
            },
            child: const Icon(Icons.menu)),
        title: const Text('Ecommerce'),
        centerTitle: true,
      ),
      drawer: const DrawerBody(),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          color: Theme.of(context).colorScheme.surface,
          child: Column(
            children: [
              Image.asset(
                'asset/banner.webp',
                height: 250,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: DescTextButton(
                  text: 'Top Brands',
                  onTap: () {},
                  button: true,
                ),
              ),
              homeItemsCard(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: DescTextButton(
                  text: 'New Arrival',
                  onTap: () {},
                  button: false,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              homeListOption(),
              const SizedBox(
                height: 30,
              ),
              homeCategory(),
            ],
          ),
        ),
      ),
    );
  }

  Widget homeCategory() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      constraints: const BoxConstraints(maxHeight: 260),
      child: Consumer<ArrivalProvider>(
        builder: (context, arrival, child) {
          // ignore: unrelated_type_equality_checks
          var filterCategory = arrival.menu;
          if (selectCategory != BrandCategory.all) {
            filterCategory = filterCategory
                .where((item) => item.cat == selectCategory)
                .toList();
          }

          return ListView.separated(
              separatorBuilder: (context, index) => const SizedBox(
                    width: 20,
                  ),
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              itemCount: filterCategory.length,
              itemBuilder: (context, index) {
                final filter = filterCategory[index];

                return Wrap(children: [
                  ArrivalItems(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ShoesPage(
                              arrival: filter,
                            ),
                          ));
                    },
                    arrival: filter,
                  ),
                ]);
              });
        },
      ),
    );
  }

  Widget homeListOption() {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 18),
        constraints: const BoxConstraints(maxHeight: 50),
        child: ListOption(
          onCategorySelect: (select) {
            setState(() {
              selectCategory = select;
            });
          },
        ));
  }

  Widget homeItemsCard() {
    return Container(
      constraints: const BoxConstraints(maxHeight: 130),
      child: Consumer<CategoryProvider>(
        builder: (context, category, child) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ListView.separated(
                  separatorBuilder: (context, index) => const SizedBox(
                    width: 20,
                  ),
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemCount: category.menu.length,
                  itemBuilder: (context, index) => BrandImage(
                    image: category.menu[index].image,
                    name: category.menu[index].name,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
