import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopywell/domain/bloc/user_profile/user_profile_bloc.dart';
import 'package:shopywell/domain/models/product/product_detail_model.dart';
import 'package:shopywell/domain/models/user_model/user_details_modl.dart';
import 'package:shopywell/presentation/home/payment_screen.dart';
import 'package:shopywell/presentation/widgets/sizedbox_widget.dart';

class PlaceOrder extends StatelessWidget {
  final ProductDetailModel product;
  const PlaceOrder({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    context.read<UserProfileBloc>().add(FetchUserDetails());
    UserDetailsModel userDetails = UserDetailsModel(
        email: '',
        password: '',
        pincode: '',
        address: '',
        city: '',
        state: '',
        country: '',
        bankAccountNumber: '',
        accountHolderName: '',
        ifscCode: '');

    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('Shopping Bag',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        bottomNavigationBar: BottomAppBar(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      '₹ ${product.price}',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'View Details',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                BlocListener<UserProfileBloc, UserProfileState>(
                  listener: (context, state) {
                    if (state is UserDetailsFetched) {
                      context.read<UserProfileBloc>().add(
                          FetchUserProfileDetails(
                              email: state.user.email ?? ''));
                    } else if (state is UserProfileLoadedSuccess) {
                      userDetails = state.userProfile;
                    }
                  },
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => PaymentScreen(
                                  product: product,
                                  user: userDetails,
                                )),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text(
                      'Proceed to Payment',
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        body: Padding(
          padding: EdgeInsets.all(16.0),
          child: Builder(builder: (context) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  Row(
                    children: [
                      Card(
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Image.network(product.image,
                            width: 110, height: 140, fit: BoxFit.cover),
                      ),
                      SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(product.title,
                                maxLines: 1,
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold)),
                            SizedBox(height: 5),
                            Text(product.description, maxLines: 1),
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
                                      borderRadius: BorderRadius.circular(5)),
                                  child: Text('₹${product.price}',
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold)),
                                ),
                                SizedBox(width: 10),
                                Text("₹${product.price * 2}",
                                    style: TextStyle(
                                        decoration:
                                            TextDecoration.lineThrough)),
                              ],
                            ),
                            Row(
                              children: [
                                Text('Delivery by '),
                                Expanded(
                                  child: Text(
                                    '10 May 2XXX',
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                  kSizedBoxHeight(height: 20),
                  ListTile(
                    leading: Icon(Icons.local_offer_outlined, size: 24),
                    title: Text(
                      'Apply Coupons',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    trailing: Text(
                      'Select',
                      style: TextStyle(
                          color: Colors.red, fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(height: 10),
                  Divider(thickness: 1, color: Colors.grey),
                  SizedBox(height: 10),
                  Text(
                    'Order Payment Details',
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  _buildRow('Order Amounts', '₹ ${product.price}',
                      isBoldRight: true),
                  _buildRow(
                    'Convenience',
                    'Know More    Apply Coupon',
                    isRed: true,
                    isBoldRight: false,
                  ),
                  _buildRow('Delivery Fee', 'Free',
                      isRed: true, isBoldRight: true),
                  Divider(thickness: 1, color: Colors.grey),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Order Total',
                        style: TextStyle(
                            fontSize: 17, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        '₹ ${product.price}',
                        style: TextStyle(
                            fontSize: 17, fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                  _buildRow('EMI Available', 'Details', isRed: true),
                  SizedBox(height: 20),
                ],
              ),
            );
          }),
        ));
  }

  Widget _buildRow(String leftText, String rightText,
      {bool isRed = false, bool isBoldRight = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            leftText,
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
          ),
          Text(
            rightText,
            style: TextStyle(
              fontSize: 14,
              fontWeight: isBoldRight ? FontWeight.bold : FontWeight.w500,
              color: isRed ? Colors.red : Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
