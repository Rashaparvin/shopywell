import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopywell/core/constants/colors_and_fonts.dart';
import 'package:shopywell/core/constants/main_variables.dart';
import 'package:shopywell/core/strings/image_strings.dart';
import 'package:shopywell/domain/bloc/wish_list/wishlist_bloc.dart';
import 'package:shopywell/presentation/home/cart_screen.dart';
import 'package:shopywell/presentation/home/widgets/search_bar_filter.dart';
import 'package:shopywell/presentation/widgets/sizedbox_widget.dart';

class Wishlist extends StatelessWidget {
  const Wishlist({super.key});

  @override
  Widget build(BuildContext context) {
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
      body: BlocBuilder<WishlistBloc, WishlistState>(
        builder: (context, state) {
          if (state is WishlistLoaded) {
            final products = state.wishlist;
            return SingleChildScrollView(
              child: Column(
                children: [
                  SearchBarColumnWidget(
                    heading: '${products.length}+ Items',
                  ),
                  kSizedBoxHeight(height: 10),
                  SizedBox(
                    child: GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: products.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              mainAxisSpacing: 10,
                              crossAxisSpacing: 10,
                              crossAxisCount: 2,
                              childAspectRatio: 4 / 6),
                      padding: const EdgeInsets.all(0),
                      itemBuilder: (context, index) {
                        final product = products[index];
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        CartScreen(product: product)));
                          },
                          child: Column(
                            children: [
                              Expanded(
                                  child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(15),
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.black12,
                                        blurRadius: 4,
                                        spreadRadius: 2),
                                  ],
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ClipRRect(
                                      borderRadius: const BorderRadius.vertical(
                                          top: Radius.circular(15)),
                                      child: Image.network(
                                        product.image,
                                        height: 130,
                                        width: double.infinity,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            product.title,
                                            style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          const SizedBox(height: 4),
                                          Text(
                                            product.description,
                                            style: const TextStyle(
                                                color: Colors.grey,
                                                fontSize: 12),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          const SizedBox(height: 6),
                                          Text(
                                            product.price.toString(),
                                            style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          const SizedBox(height: 4),
                                          Row(
                                            children: [
                                              ...List.generate(
                                                5,
                                                (index) => Icon(
                                                  index < product.rating.rate
                                                      ? Icons.star
                                                      : Icons.star_border,
                                                  color: Colors.amber,
                                                  size: 16,
                                                ),
                                              ),
                                              const SizedBox(width: 5),
                                              Text(
                                                product.rating.count.toString(),
                                                style: const TextStyle(
                                                    color: Colors.grey,
                                                    fontSize: 12),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              )),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          }
          return Center(
              child: Text(
            'Ooops !.. No items in wish list',
            style: TextStyle(
                color: Pallete.kRedColor,
                fontSize: 17,
                fontWeight: FontWeight.bold),
          ));
        },
      ),
    );
  }
}
