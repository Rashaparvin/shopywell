import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopywell/core/constants/colors_and_fonts.dart';
import 'package:shopywell/core/constants/main_variables.dart';
import 'package:shopywell/core/strings/image_strings.dart';
import 'package:shopywell/domain/bloc/product/product_bloc.dart';
import 'package:shopywell/domain/models/product/product_detail_model.dart';
import 'package:shopywell/presentation/home/widgets/search_bar_filter.dart';
import 'package:shopywell/presentation/widgets/sizedbox_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    context.read<ProductBloc>().add(FetchProducts());
  }

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> categories = [
      {'name': 'Beauty', 'image': 'assets/images/beauty.png'},
      {'name': 'Fashion', 'image': 'assets/images/fashion.png'},
      {'name': 'Kids', 'image': 'assets/images/kids.png'},
      {'name': 'Mens', 'image': 'assets/images/mens.png'},
      {'name': 'Womens', 'image': 'assets/images/womens.png'},
    ];

    final List<String> bannerImages = [
      'assets/images/carousel_image1.png',
    ];
    int activeIndex = 0;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.menu, color: Colors.black, size: 30),
          onPressed: () {
            Scaffold.of(context).openDrawer();
          },
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(Images.appLogo,
                height: Dimensions.screenHeight(context) * 0.3,
                width: Dimensions.screenWidth(context) * 0.3)
          ],
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 10),
            child: CircleAvatar(
              backgroundColor: Colors.red[100],
              radius: 20,
              child: Image.asset(Images.userIcon),
            ),
          ),
        ],
        centerTitle: true,
      ),
      drawer: Drawer(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SearchBarColumnWidget(
              heading: 'All Featured',
            ),
            kSizedBoxHeight(height: 10),

            // Category Scrollable List
            SizedBox(
              height: 90,
              child: ListView.separated(
                separatorBuilder: (context, index) {
                  return kSizedBoxWidth(width: 5);
                },
                scrollDirection: Axis.horizontal,
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      CircleAvatar(
                        radius: 30,
                        backgroundImage:
                            AssetImage(categories[index]['image']!),
                      ),
                      const SizedBox(height: 5),
                      Text(categories[index]['name']!,
                          style: const TextStyle(fontSize: 12)),
                    ],
                  );
                },
              ),
            ),
            kSizedBoxHeight(height: 10),

            // Promotional Banner (Carousel)
            CarouselSlider(
              options: CarouselOptions(
                height: 180,
                autoPlay: true,
                enlargeCenterPage: true,
                aspectRatio: 16 / 9,
                viewportFraction: 1,
                onPageChanged: (index, reason) {
                  setState(() {
                    activeIndex = index;
                  });
                },
              ),
              items: bannerImages.map((image) {
                return ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Stack(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(image),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Positioned(
                        left: 20,
                        top: 20,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              '50-40% OFF',
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(height: 5),
                            const Text(
                              'Now in (product)\nAll colours',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.white,
                              ),
                            ),
                            kSizedBoxHeight(height: 10),
                            CustomElevatedButton(
                              backgroundColor:
                                  Color.fromARGB(255, 236, 167, 177),
                              title: 'Shop Now',
                              fontSize: 15,
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                );
              }).toList(),
            ),
            kSizedBoxHeight(height: 10),

            // Dot Indicator
            DotsIndicator(
              dotsCount: 3,
              position: activeIndex.toDouble(),
              decorator: DotsDecorator(
                activeColor: Pallete.kRedColor,
                size: const Size.square(8.0),
                activeSize: const Size(8.0, 8.0),
                activeShape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0)),
              ),
            ),
            kSizedBoxHeight(height: 5),

            // Deal of the Day Section
            BuildContanerWithButton(
              containerColor: Colors.blue,
              title: 'Deal of the Day',
              icon: Icons.alarm,
              text: '22h 55m 20s remaining',
              buttonTitle: 'View All',
              backgroundColor: Colors.blue,
            ),
            kSizedBoxHeight(height: 10),
            // Products list
            BlocBuilder<ProductBloc, ProductState>(
              builder: (context, state) {
                if (state is ProductError) {
                  return SizedBox(
                    child: Text(state.errorMessage),
                  );
                } else if (state is ProductLoading) {
                  return CircularProgressIndicator(
                    color: Pallete.kRedColor,
                  );
                } else if (state is ProductLoaded) {
                  return SizedBox(
                    height: 250,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 10,
                      itemBuilder: (context, index) {
                        final product = state.products[index];
                        return BuildProductCard(
                          product: product,
                        );
                      },
                    ),
                  );
                }
                return SizedBox.shrink();
              },
            ),
            kSizedBoxHeight(height: 5),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(color: Colors.grey.shade300, blurRadius: 5)
                ],
              ),
              child: Row(
                children: [
                  Image.asset("assets/images/special_offer.png", height: 50),
                  kSizedBoxWidth(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      kSizedBoxHeight(height: 4),
                      Text("Special Offers 🎭",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18)),
                      SizedBox(height: 4),
                      SizedBox(
                        width: Dimensions.screenWidth(context) * 0.6,
                        child: Text(
                            "We make sure you get the offer you need at best prices",
                            style: TextStyle(color: Colors.grey)),
                      ),
                      kSizedBoxHeight(height: 4)
                    ],
                  ),
                ],
              ),
            ),
            kSizedBoxHeight(height: 10),
            Container(
              height: 200,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.center,
                  colors: [
                    Colors.amber, // Thick golden color on the left
                    Color.fromARGB(
                        255, 255, 234, 157), // Slightly lighter golden
                    Colors.white, // Fading into white on the right
                  ],
                ),
                borderRadius: BorderRadius.circular(12),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(color: Colors.grey.shade300, blurRadius: 5)
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset("assets/images/flat_and_heels.png", height: 80),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("Flat and Heels",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18)),
                          kSizedBoxHeight(height: 5),
                          SizedBox(
                            width: Dimensions.screenWidth(context) * 0.6,
                            child: const Text("Stand a chance to get rewarded",
                                style: TextStyle(color: Colors.grey)),
                          ),
                        ],
                      ),
                      kSizedBoxHeight(height: 15),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          CustomElevatedButton(
                              title: 'Visit Now',
                              fontSize: 15,
                              backgroundColor: Colors.red),
                        ],
                      )
                    ],
                  ),
                ],
              ),
            ),
            kSizedBoxHeight(height: 10),

            BuildContanerWithButton(
              containerColor: const Color.fromARGB(213, 242, 134, 134),
              title: 'Trending Products',
              icon: Icons.calendar_month,
              text: 'Last Date 29/02/22',
              buttonTitle: 'View All',
              backgroundColor: Colors.transparent,
            ),
            kSizedBoxHeight(height: 10),
            // Products list
            BlocBuilder<ProductBloc, ProductState>(
              builder: (context, state) {
                if (state is ProductError) {
                  return SizedBox(
                    child: Text(state.errorMessage),
                  );
                } else if (state is ProductLoading) {
                  return CircularProgressIndicator(
                    color: Pallete.kRedColor,
                  );
                } else if (state is ProductLoaded) {
                  return SizedBox(
                    height: 250,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 10,
                      itemBuilder: (context, index) {
                        final product = state.products[index];
                        return BuildProductCard(
                          product: product,
                        );
                      },
                    ),
                  );
                }
                return SizedBox.shrink();
              },
            ),
            kSizedBoxHeight(height: 13),
            SizedBox(
              child: Card(
                color: Pallete.kWhiteColor,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                elevation: 3,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(12),
                          topRight: Radius.circular(12)),
                      child: Image.asset('assets/images/hot_summer.png',
                          height: 200,
                          width: double.infinity,
                          fit: BoxFit.cover),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 5, vertical: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'New Arrivals',
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(height: 5),
                              Text(
                                "Summer'25 Collections",
                                style: TextStyle(fontSize: 14),
                              ),
                            ],
                          ),
                          CustomElevatedButton(
                            backgroundColor: Colors.red,
                            title: 'View All',
                            fontSize: 13,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            kSizedBoxHeight(height: 15),
            Container(
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(10)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Text(
                      'Sponsored',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                  ),
                  Card(
                    color: Pallete.kWhiteColor,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                    elevation: 3,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          child: Image.asset('assets/images/50%off.png',
                              height: 200,
                              width: double.infinity,
                              fit: BoxFit.cover),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Text(
                      'Up to 50% Off',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                  ),
                ],
              ),
            ),
            kSizedBoxWidth(width: 20)
          ],
        ),
      ),
    );
  }
}

class BuildContanerWithButton extends StatelessWidget {
  final Color? containerColor;
  final String title;
  final String text;
  final Color backgroundColor;
  final String buttonTitle;
  final IconData icon;
  const BuildContanerWithButton({
    super.key,
    required this.containerColor,
    required this.title,
    required this.text,
    required this.backgroundColor,
    required this.buttonTitle,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: containerColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
              SizedBox(height: 5),
              Row(
                children: [
                  Icon(
                    icon,
                    color: Colors.white,
                  ),
                  kSizedBoxWidth(width: 2),
                  Text(
                    text,
                    style: TextStyle(color: Colors.white70, fontSize: 14),
                  ),
                ],
              ),
            ],
          ),
          CustomElevatedButton(
            backgroundColor: backgroundColor,
            title: buttonTitle,
            fontSize: 13,
          )
        ],
      ),
    );
  }
}

class BuildProductCard extends StatelessWidget {
  final ProductDetailModel product;
  const BuildProductCard({
    super.key,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 190,
      margin: const EdgeInsets.only(right: 10),
      child: Card(
        color: Pallete.kWhiteColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 3,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network(product.image,
                      height: 120, width: double.infinity),
                ),
                Positioned(
                    top: 5,
                    right: 10,
                    child: GestureDetector(
                      onTap: () {
                        context
                            .read<ProductBloc>()
                            .add(ToggleFavorite(productId: product.id));
                      },
                      child: Icon(
                        product.selectedToWish
                            ? Icons.favorite
                            : Icons.favorite_border,
                        color: Colors.amber,
                      ),
                    ))
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Column(
                children: [
                  Text(
                    product.title,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 14),
                    maxLines: 1,
                    overflow:
                        TextOverflow.ellipsis, // Show "..." if text is too long
                  ),
                  Text(
                    product.description,
                    style: const TextStyle(color: Colors.grey, fontSize: 10),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      Text('₹${product.price}',
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 14)),
                      const SizedBox(width: 6),
                      Text('₹${product.price * 2}',
                          style: const TextStyle(
                              decoration: TextDecoration.lineThrough,
                              color: Colors.grey,
                              fontSize: 12)),
                      const SizedBox(width: 6),
                      Text('50% Off',
                          style: const TextStyle(
                              color: Colors.red,
                              fontSize: 12,
                              fontWeight: FontWeight.bold)),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      Icon(Icons.star, color: Colors.amber, size: 14),
                      Text(' ${product.rating.rate}',
                          style: const TextStyle(fontSize: 12)),
                      const SizedBox(width: 4),
                      Text('(${product.rating.count})',
                          style: const TextStyle(
                              color: Colors.grey, fontSize: 10)),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class CustomElevatedButton extends StatelessWidget {
  final String title;
  final double fontSize;
  final Color backgroundColor;
  const CustomElevatedButton({
    super.key,
    required this.title,
    required this.fontSize,
    required this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        foregroundColor: Colors.white,
        side: const BorderSide(color: Colors.white),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      onPressed: () {},
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            title,
            style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.w500),
          ),
          SizedBox(width: 5),
          Icon(
            Icons.arrow_right_alt,
            size: 22,
            color: Colors.white,
          ),
        ],
      ),
    );
  }
}
