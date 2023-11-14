import 'package:ecrime/admin/view/view_admin_barrel.dart';
import 'package:ecrime/client/View/widgets/widgets_barrel.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';

class SearchPoliceStation extends StatefulWidget {
   SearchPoliceStation({super.key});

  @override
  State<SearchPoliceStation> createState() => _SearchPoliceStationState();
}

class _SearchPoliceStationState extends State<SearchPoliceStation> {
  final searchField=TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search Stations'),
      ),
      body:  BackgroundFrame(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
          child: Column(
            children: [
              SizedBox(height: 20,),
              GenericTextField(controller: searchField
              ,hintText: 'Search Police Station',
                onSaved: (newValue) {
                  setState(() {

                  });
                },
              ),

              Expanded(child: FirebaseAnimatedList(
                query: FirebaseDatabase.instance.ref('PoliceStations'),

                defaultChild: Center(
                  child: SizedBox(
                    height: 15,
                    width: 15,
                    child: CircularProgressIndicator(
                      color: AppColor.primaryColor,
                    ),
                  ),
                ),

                itemBuilder: (context, snapshot, animation, index) {


                  if(snapshot.children.isEmpty){
                    return Center(child: SizedBox(
                      height: 15,
                      width: 15,
                      child: CircularProgressIndicator(
                        color: AppColor.primaryColor,
                      ),
                    ),);
                  }


                  if(searchField.value.text.toString().isEmpty){
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(snapshot.child('name').value.toString(),
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),),
                              SizedBox(height: 5,),
                              Row(
                                children: [
                                  Text('District : ',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),),Text(snapshot.child('district').value.toString(),
                                    style: TextStyle(

                                    ),)
                                ],
                              ),
                              SizedBox(height: 5,),
                              Row(
                                children: [
                                  Text('Location : ',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),),Text(snapshot.child('location').value.toString(),
                                    style: TextStyle(

                                    ),)
                                ],
                              )

                            ],
                          ),
                        ),
                      ),
                    );
                  }else{
                    if(snapshot.child('name').value.toString().toLowerCase().contains(searchField.value.text.toString().toLowerCase())){
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        child: Card(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(snapshot.child('name').value.toString(),
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),),
                                SizedBox(height: 5,),
                                Row(
                                  children: [
                                    Text('District : ',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),),Text(snapshot.child('district').value.toString(),
                                      style: TextStyle(

                                      ),)
                                  ],
                                ),
                                SizedBox(height: 5,),
                                Row(
                                  children: [
                                    Text('Location : ',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),),Text(snapshot.child('location').value.toString(),
                                      style: TextStyle(

                                      ),)
                                  ],
                                )

                              ],
                            ),
                          ),
                        ),
                      );
                    }
                  }


                  return Container();

                },
              ))


            ],
          ),
        ),
      ),
    );
  }
}
