import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:gofast/exports/export_pages.dart';
import 'package:gofast/exports/exported_widgets.dart';

class Processing extends StatelessWidget {
  const Processing({
    Key? key,
    required Stream<QuerySnapshot<Map<String, dynamic>>>
        processingReceiverStream,
  })  : _processingReceiverStream = processingReceiverStream,
        super(key: key);

  final Stream<QuerySnapshot<Map<String, dynamic>>> _processingReceiverStream;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.fromLTRB(0.0, 15, 0, 10),
        child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
          stream: _processingReceiverStream,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting ||
                snapshot.connectionState == ConnectionState.none) {
              return const ShipmentShimmer();
            } else if (snapshot.connectionState == ConnectionState.active) {
              if (snapshot.data?.docs.isNotEmpty == true) {
                return ListView.builder(
                  itemCount: snapshot.data?.docs.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (BuildContext context, int index) {
                    var package = snapshot.data?.docs[index];
                    return Padding(
                      padding: const EdgeInsets.only(bottom:8.0, right: 8, left: 8),
                      child: ClipRRect(
                        borderRadius: const BorderRadius.all(Radius.circular(19)),
                        child: Slidable(
                          key: const ValueKey(0),
                         
                          // The end action pane is the one at the right or the bottom side.
                          endActionPane: const ActionPane(
                            motion: ScrollMotion(),
                            children: [
                              SlidableAction(
                                // An action can be bigger than the others.
                                flex: 1,
                                onPressed: doNothing,
                                backgroundColor: Colors.lightBlue,
                                foregroundColor: Color(0xFFFFFFFF),
                                icon: AntDesign.customerservice,
                                label: 'Enquire',
                              ),
                              SlidableAction(
                                onPressed: doNothing,
                                backgroundColor: Color.fromARGB(255, 3, 110, 164),
                                foregroundColor: Colors.white,
                                icon: Feather.package,
                                label: 'Collect',
                                borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(19),
                                  bottomRight: Radius.circular(19)
                                ),
                              ),
                            ],
                          ),
                    
                          child: ShipmentWidget(
                            package: package,
                            
                          ),
                        ),
                      ),
                    );
                  
                  },
                );
              } else {
                return const Empty();
              }
            }
            return const ErrorWid();
          },
        ));
  }
}
