import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopywell/domain/bloc/product/product_bloc.dart';
import 'package:shopywell/domain/bloc/user_profile/user_profile_bloc.dart';
import 'package:shopywell/presentation/home/place_order.dart';
import 'package:shopywell/presentation/home/profile.dart';
import 'package:shopywell/presentation/widgets/sizedbox_widget.dart';

class ShoppingCartPage extends StatelessWidget {
  const ShoppingCartPage({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<UserProfileBloc>().add(FetchUserDetails());
    context.read<ProductBloc>().add(FetchCartProducts());

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Checkout',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: BlocListener<UserProfileBloc, UserProfileState>(
        listener: (context, state) {
          if (state is UserDetailsFetched) {
            context
                .read<UserProfileBloc>()
                .add(FetchUserProfileDetails(email: state.user.email ?? ''));
          }
        },
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            children: [
              // Delivery Address Section
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.location_on_outlined),
                      kSizedBoxWidth(width: 5),
                      Text(
                        'Delivery Address',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 19),
                      )
                    ],
                  ),
                  BlocBuilder<UserProfileBloc, UserProfileState>(
                    buildWhen: (previous, current) {
                      return current is UserProfileLoadedSuccess ||
                          current is NoUserProfileFound;
                    },
                    builder: (context, state) {
                      if (state is UserProfileLoadedSuccess) {
                        return Card(
                          elevation: 3,
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Stack(
                              children: [
                                Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Address :',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      kSizedBoxHeight(height: 4),
                                      Text(
                                          '${state.userProfile.address},${state.userProfile.city}'),
                                      Text(
                                          '${state.userProfile.state},${state.userProfile.country}'),
                                      Text(state.userProfile.pincode),
                                    ]),
                                Positioned(
                                    top: 0,
                                    right: 0,
                                    child: GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      Profile()));
                                        },
                                        child: Icon(Icons.edit_square)))
                              ],
                            ),
                          ),
                        );
                      }
                      return Card(
                          color: Colors.white,
                          elevation: 3,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Profile()));
                                },
                                child: Icon(Icons.add_circle_outline_outlined)),
                          ));
                    },
                  ),
                ],
              ),
              SizedBox(height: 20),

              // Shopping List
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    ' Shopping List',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 19),
                  ),
                ],
              ),
              BlocBuilder<ProductBloc, ProductState>(
                builder: (context, state) {
                  if (state is CartProductLoaded) {
                    final products = state.cartProducts;

                    return Expanded(
                      child: ListView.builder(
                          itemCount: products.length,
                          itemBuilder: (context, index) {
                            final product = products[index];
                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => PlaceOrder(
                                            product: product,
                                          )),
                                );
                              },
                              child: Card(
                                color: Colors.white,
                                elevation: 3,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.all(12.0),
                                  child: Row(
                                    children: [
                                      Image.network(product.image,
                                          width: 100,
                                          height: 100,
                                          fit: BoxFit.cover),
                                      SizedBox(width: 12),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(product.title,
                                                maxLines: 1,
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.bold)),
                                            SizedBox(height: 5),
                                            Row(
                                              children: [
                                                Text('${product.rating.rate}'),
                                                SizedBox(width: 5),
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
                                              ],
                                            ),
                                            SizedBox(height: 10),
                                            Row(
                                              children: [
                                                Container(
                                                  padding: EdgeInsets.all(5),
                                                  decoration: BoxDecoration(
                                                      border: Border.all(),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5)),
                                                  child: Text(
                                                      '₹${product.price}',
                                                      style: TextStyle(
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.bold)),
                                                ),
                                                SizedBox(width: 10),
                                                Text("₹${product.price * 2}",
                                                    style: TextStyle(
                                                        decoration:
                                                            TextDecoration
                                                                .lineThrough)),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          }),
                    );
                  }
                  return SizedBox.shrink();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
