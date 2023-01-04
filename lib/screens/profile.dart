import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:gofast/global/global_variables.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).highlightColor,
      // appBar: AppBar(
      //   elevation: 0,
      //   toolbarHeight: 35,
      //   actions: [
      //     IconButton(onPressed: (){}, icon: Icon(AntDesign.setting))
      //   ],
      // ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height*0.355,
              decoration:  BoxDecoration(
                    // image:  const DecorationImage(
                    // image: AssetImage("assets/images/bg.png"),
                    // fit: BoxFit.cover,
                    // opacity: 0.3),
           gradient: LinearGradient(
                      colors: [
                        
                        const Color(0xFF03608F).withOpacity(0.8), 
                        const Color(0xFFFFFFFF).withOpacity(.6),
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    )
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(12.0,50,8,8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        
                        ClipRRect(
                          borderRadius: BorderRadius.circular(60),
                          child: Image.network(userImage!,width: 40,height: 40,), ),
                          const SizedBox(width: 8,),
                        Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(name, style: Theme.of(context).textTheme.headline2,),
                              Text(email, style: Theme.of(context).textTheme.headline6,)
                            ],
                          ),
                        ),

                        
                      
                      ],
                    ),
                  ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Container(
                  height: 40,
                  decoration: BoxDecoration(
                        color: Color(0xFFFFFFFF).withOpacity(0.7),
                        borderRadius: BorderRadius.circular(10)),
                  child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              const Icon(Ionicons.phone_portrait_outline, size: 20,),
                              const SizedBox(
                                width: 5,
                              ),
                              Text(
                                'Change Number'.toUpperCase(),
                                style: Theme.of(context).textTheme.headline5,
                              ),
                            ],
                          ),
                          InkWell(
                            onTap: () {
                              
                            },
                            child: Row(
                              children: [
                                const Icon(
                                  Ionicons.location_outline,
                                  size: 20,
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  ' Change Location'.toUpperCase(),
                                  style: Theme.of(context).textTheme.headline5,
                                ),
                              ],
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              
                            },
                            child: Row(
                              children: [
                                const Icon(
                                    AntDesign.gift, size: 20,),
                                const SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  'Coupons     '.toUpperCase(),
                                  style: Theme.of(context).textTheme.headline5,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                  )),
                    ),
           
                      
                  
                  ListTile(
                    leading: const Icon(MaterialCommunityIcons.truck_fast),
                   title: Text("Shipping orders", style: Theme.of(context).textTheme.headline5,),
                    trailing: const Icon(AntDesign.right, size: 16,),
                    // tileColor: Colors.white,
                  ),
                   ListTile(
                    leading: const Icon(MaterialCommunityIcons.cube_send),
                   title: Text("Delivery order", style: Theme.of(context).textTheme.headline5,),
                    trailing: const Icon(AntDesign.right, size: 16,),
                    // tileColor: Colors.white,
                  ),
                  ListTile(
                    leading: const Icon(MaterialCommunityIcons.wallet_giftcard),
                   title: Text("Membership", style: Theme.of(context).textTheme.headline5,),
                    trailing: const Icon(AntDesign.right, size: 16,),
                    // tileColor: Colors.white,
                  ),
                  
                 
                  
                ],
              ),
            ),

            const SizedBox(height: 15,),

           const  CustomList(),

            const SizedBox(height: 15,),

            const CustomLis(),

            // SizedBox(height: 15,),

             Container(
                    height: 160,
                    decoration:  const BoxDecoration(
                    image:   DecorationImage(
                    image: AssetImage("assets/images/bg.png"),
                    fit: BoxFit.cover,
                    opacity: 0.9),
           gradient: LinearGradient(
                      colors: [
                        Colors.white12,
                        Color(0xFF03608F), 
                       
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    )
              ),
                  ),


           
            
          ],
        ),
      ),
    );
  }
}



class CustomList extends StatelessWidget {
  const CustomList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height*0.18,
      decoration:  BoxDecoration(
    //     image:  DecorationImage(
    // image: AssetImage("assets/images/bg.png"),
    // fit: BoxFit.cover,
    // opacity: 0.3),
    color: Colors.grey.shade100
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        
        children:  [
          //  Padding(
          //    padding: const EdgeInsets.fromLTRB(16.0, 8, 8, 8),
          //    child: Center(child: Text("Couriers Settings", style: Theme.of(context).textTheme.headline4,)),
          //  ),
           ListTile(
            
            leading: const Icon(Ionicons.notifications_circle_outline),
            title: Text("Parcel Message and notifications", style: Theme.of(context).textTheme.headline5,),
            trailing: const Icon(AntDesign.right, size: 16,),
            tileColor: Colors.white,
          ),
           ListTile(
            
            leading: const Icon(AntDesign.unlock),
            title: Text("Request password", style: Theme.of(context).textTheme.headline5,),
            trailing: const Icon(AntDesign.right, size: 16,),
            tileColor: Colors.white,
          ),
           ListTile(
            
            leading: const Icon(MaterialCommunityIcons.barcode_scan),
            title: Text("Identity Code", style: Theme.of(context).textTheme.headline5,),
            trailing: Icon(AntDesign.right, size: 16,),
            tileColor: Colors.white,
          )
        ],
      ),
    );
  }
}


class CustomLis extends StatelessWidget {
  const CustomLis({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height*0.18,
      decoration:  BoxDecoration(
    //     image:  DecorationImage(
    // image: AssetImage("assets/images/bg.png"),
    // fit: BoxFit.cover,
    // opacity: 0.3),
    color: Colors.grey.shade100
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        
        children:  [
          //  Padding(
          //    padding: const EdgeInsets.fromLTRB(16.0, 8, 8, 8),
          //    child: Center(child: Text("Couriers Settings", style: Theme.of(context).textTheme.headline4,)),
          //  ),
           ListTile(
            
            leading: const Icon(AntDesign.customerservice),
            title: Text("Service Center", style: Theme.of(context).textTheme.headline5,),
            trailing: const Icon(AntDesign.right, size: 16,),
            tileColor: Colors.white,
          ),
           ListTile(
            
            leading: const Icon(AntDesign.like2),
            title: Text("Praise", style: Theme.of(context).textTheme.headline5,),
            trailing: const Icon(AntDesign.right, size: 16,),
            tileColor: Colors.white,
          ),
           ListTile(
            
            leading: const Icon(AntDesign.logout),
            title: Text("Logout", style: Theme.of(context).textTheme.headline5,),
            trailing: Icon(AntDesign.right, size: 16,),
            tileColor: Colors.white,
          )
        ],
      ),
    );
  }
}