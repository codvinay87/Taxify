import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class uber extends StatefulWidget {
  const uber({Key? key}) : super(key: key);

  @override
  State<uber> createState() => _uberState();
}

class _uberState extends State<uber> {
  void launchUberWithLocations(double pickupLat, double pickupLng, double dropoffLat, double dropoffLng) async {

    final url = Uri.parse('uber://?action=setPickup&pickup[latitude]=${pickupLat}&pickup[longitude]=${pickupLng}&dropoff[latitude]=${dropoffLat}&dropoff[longitude]=${dropoffLng}&link_text=View%20team%20roster&partner_deeplink=partner%3A%2F%2Fteam%2F9383');
    // final url = Uri.parse('uber://?action=setPickup&pickup[latitude]=37.775818&pickup[longitude]=-122.418028&pickup[nickname]=UberHQ&pickup[formatted_address]=1455%20Market%20St%2C%20San%20Francisco%2C%20CA%2094103&dropoff[latitude]=37.802374&dropoff[longitude]=-122.405818&dropoff[nickname]=Coit%20Tower&dropoff[formatted_address]=1%20Telegraph%20Hill%20Blvd%2C%20San%20Francisco%2C%20CA%2094133&product_id=a1111c8c-c720-46c3-8534-2fcdd730040d&link_text=View%20team%20roster&partner_deeplink=partner%3A%2F%2Fteam%2F9383');

    await launchUrl(url);
    // //
    // if (await canLaunchUrl(url)) {
    //   await launchUrl(url);
    // } else {
    //   // If the user does not have the Uber app installed,
    //   // open the App Store or Google Play Store to download it.
    //   await launch('https://play.google.com/store/apps/details?id=com.ubercab&hl=en');
    //
    // }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(padding: const EdgeInsets.all(16.0),
          child: TextButton(onPressed:()=> launchUberWithLocations(28.65, 77.23149,19.07283, 72.88261)
              , child: Text("book uber"))
            ,)
        ],
      )


    );
  }
}
