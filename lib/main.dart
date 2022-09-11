import 'package:bb_baazar/provider/cart_provider.dart';
import 'package:bb_baazar/provider/wishlist_provider.dart';
import 'package:bb_baazar/views/auth/customer_login_screen.dart';
import 'package:bb_baazar/views/auth/landing_customer_screen.dart';
import 'package:bb_baazar/views/auth/landing_seller_screen.dart';
import 'package:bb_baazar/views/auth/seller_login_screen.dart';
import 'package:bb_baazar/views/customer_home_screen.dart';
import 'package:bb_baazar/views/seller_home_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp().then((value) => print("Completed"));
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) {
      return CartProvider();
    }),
    ChangeNotifierProvider(create: (_) {
      return WishlistProvider();
    })
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'BB Baazar',
      theme: ThemeData(
        primarySwatch: Colors.red,
        fontFamily: "Brand-Bold",
      ),
      initialRoute: LandingSellerScreen.routeName,
      routes: {
        CustomerHomeScreen.routeName: (context) => CustomerHomeScreen(),
        LandingCustomerScreen.routeName: (context) => LandingCustomerScreen(),
        CustomerLoginScreen.routeName: (context) => CustomerLoginScreen(),
        LandingSellerScreen.routeName: (context) => LandingSellerScreen(),
        SellerLoginScreen.routeName: (context) => SellerLoginScreen(),
        SellerHomeScreen.routeName: (context) => SellerHomeScreen(),
      },
    );
  }
}
