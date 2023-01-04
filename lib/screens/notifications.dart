import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';


class Notifixations extends StatefulWidget {
  const Notifixations({super.key});

  @override
  State<Notifixations> createState() => _NotifixationsState();
}

class _NotifixationsState extends State<Notifixations> {
  @override
  Widget build(BuildContext context) {
    List<String> Users = [
      "Make money",
      "Make money",
      "Make money",
      "Make money",
      "Make money",
    ];
    return Scaffold(
      // backgroundColor: Theme.of(context).iconTheme.color,
      
      body: Column(
        children: [
          Container(
            height: 100,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Notifications", style: Theme.of(context).textTheme.headline3,),
              ],
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height*0.8172,
            decoration:  const BoxDecoration(
                    image:   DecorationImage(
                    image: AssetImage("assets/images/extended.png"),
                    fit: BoxFit.fitWidth,
                    opacity: 0.4),
           gradient: LinearGradient(
                      colors: [
                        Colors.white12,
                        Color(0xFF03608F), 
                       
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    )
              ),
            child: ListView.builder(
                itemCount: Users.length,
                itemBuilder: (context, index) {
                  return Slidable(
                    // Specify a key if the Slidable is dismissible.
                    key: const ValueKey(0),

                    // The start action pane is the one at the left or the top side.
                    startActionPane: ActionPane(
                      // A motion is a widget used to control how the pane animates.
                      motion: const ScrollMotion(),

                      // A pane can dismiss the Slidable.
                      dismissible: DismissiblePane(onDismissed: () {}),

                      // All actions are defined in the children parameter.
                      children: const [
                        
                        SlidableAction(
                          onPressed: doNothing,
                          backgroundColor: Color(0xFFFE4A49),
                          foregroundColor: Colors.white,
                          icon: Icons.delete,
                          label: 'Delete',
                        ),
                        SlidableAction(
                          onPressed: doNothing,
                          backgroundColor: Color(0xFF21B7CA),
                          foregroundColor: Colors.white,
                          icon: Icons.share,
                          label: 'Share',
                        ),
                      ],
                    ),

                    // The end action pane is the one at the right or the bottom side.
                    endActionPane: const ActionPane(
                      motion: ScrollMotion(),
                      children: [
                        SlidableAction(
                          // An action can be bigger than the others.
                          flex: 2,
                          onPressed: doNothing,
                          backgroundColor: Color(0xFF7BC043),
                          foregroundColor: Colors.white,
                          icon: Icons.archive,
                          label: 'Archive',
                        ),
                        SlidableAction(
                          onPressed: doNothing,
                          backgroundColor: Color(0xFF0392CF),
                          foregroundColor: Colors.white,
                          icon: Icons.save,
                          label: 'Save',
                        ),
                      ],
                    ),

                    // The child of the Slidable is what the user sees when the
                    // component is not dragged.
                    child:  ListTile(
                      leading: Icon(Feather.package),
                      title: Text(Users[index])),
                  );
                },
              ),
          ),
        ],
      ),
      
    );
    
  }
}
  void doNothing(BuildContext context) {}
