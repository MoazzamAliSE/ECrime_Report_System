import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecrime/admin/view%20model/controller/assign_fir_controller.dart';
import 'package:ecrime/admin/view/view_admin_barrel.dart';
import 'package:ecrime/admin/view/view_fir/fir_detail_page/pdfViewer.dart';
import 'package:ecrime/client/view/widgets/widgets_barrel.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:get/get.dart';

class FIRDetailPage extends StatefulWidget {
  final DataSnapshot snapshot;

   FIRDetailPage({super.key, required this.snapshot}){
    final controller=Get.put(AssignFirController());
    controller.selectedString.value=snapshot.child('assignTo').value.toString();
  }

  @override
  State<FIRDetailPage> createState() => _FIRDetailPageState();
}

class _FIRDetailPageState extends State<FIRDetailPage>
    with WidgetsBindingObserver {
  late VideoPlayerController _controller;
  ChewieController? _chewieController;
  final controller=Get.put(AssignFirController());
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    if (widget.snapshot.child('evidenceUrl').value.toString().contains('mp4')) {
      _controller = VideoPlayerController.networkUrl(
          Uri.parse(widget.snapshot.child('evidenceUrl').value.toString()))
        ..initialize().then((_) {
          setState(() {});
        });

      _chewieController = ChewieController(
        videoPlayerController: _controller,
        autoInitialize: true,
        allowedScreenSleep: false,
        showControls: true,
        autoPlay: false,
        allowFullScreen: true,
        aspectRatio: 16 / 9,
      );
    }
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            'FIR Number ${widget.snapshot.child('firNumber').value.toString()}'),
        // 'FIR Number ${widget.snapshot.child('key').value.toString().substring(0, 4)}'
      ),
      body: BackgroundFrame(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text(
                    'Submitted by: ',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  Text(widget.snapshot.child('name').value.toString()),
                  Row(
                    children: [
                      const Text(
                        'Submitted at: ',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                      Text(widget.snapshot
                          .child('incidentDateTime')
                          .value
                          .toString()
                          .substring(
                              0,
                              widget.snapshot
                                  .child('incidentDateTime')
                                  .value
                                  .toString()
                                  .indexOf(' -'))),
                    ],
                  ),


                  Row(
                    children: [
                      const Text(
                        'Assign to: ',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                      Obx(() => Text(controller.selectedString.value
                      ),)
                    ],
                  ),


                  const Text(
                    'Description: ',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  Text(
                      ' ${widget.snapshot.child('incidentDetails').value.toString()}'),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: LinearProgressIndicator(
                          borderRadius: BorderRadius.circular(10),
                          minHeight: 20,
                          backgroundColor: Colors.grey[300],
                          valueColor:
                              const AlwaysStoppedAnimation<Color>(Colors.green),
                          value: double.parse(widget.snapshot.child('progress').value.toString()),
                        ),
                      ),
                      Text(
                        ' ${(double.parse(widget.snapshot.child('progress').value.toString()) * 100).toStringAsFixed(1)}%',
                        style: const TextStyle(fontSize: 16.0),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Files:',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  const SizedBox(height: 10),
                  fileWidget(),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                              title: const Text('Select officer'),
                              content: Obx(
                                    () => SizedBox(
                                  height: 120,
                                  child: Column(
                                    children: [
                                      DropdownButton<String>(
                                        value: controller
                                            .selectedOfficer.value,
                                        hint:
                                        const Text('Select Officer'),
                                        onChanged: (String? newValue) {
                                          controller.selectedOfficer
                                              .value = newValue!;
                                        },
                                        items: <String>[
                                          'Moazzam - SHO',
                                          'Talha - Inspector',
                                          'Furqan - Sub Inspector',
                                          'Ali - DSP',
                                          'Babar - ASP',
                                          'Zeeshan - SP',
                                          'Zulqarnain - SSP',
                                          'Other',
                                        ].map<DropdownMenuItem<String>>(
                                                (String value) {
                                              return DropdownMenuItem<String>(
                                                value: value,
                                                child: Text(value),
                                              );
                                            }).toList(),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Align(
                                        alignment: Alignment.bottomRight,
                                        child: TextButton(
                                          child: const Text('Assign'),
                                          onPressed: () {
                                            FirebaseDatabase.instance
                                                .ref('Firs')
                                                .child(widget.snapshot
                                                .child('key')
                                                .value
                                                .toString())
                                                .update({
                                              'assignTo': controller
                                                  .selectedOfficer.value
                                            }).then((value) {
                                              controller.selectedString.value=controller.selectedOfficer.value;
                                              Get.back();

                                            });
                                          },
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ));
                        },
                      );
                    },
                    child: const Text('Assign FIR'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  fileWidget() {
    String url = widget.snapshot.child('evidenceUrl').value.toString();
    if (url.contains('jpg') || url.contains('png') || url.contains('jpeg')) {
      return CachedNetworkImage(
        imageUrl: url,
        placeholder: (context, url) => SizedBox(

            child: Center(
              child: CircularProgressIndicator(
                color: AppColor.primaryColor,
              ),
            )),
        imageBuilder: (context, imageProvider) {
          return ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image(
              image: imageProvider,
            ),
          );
        },
      );
    } else if (url.contains('mp4')) {
      _controller.play();
      return AspectRatio(
          aspectRatio: 16 / 9,
          child: Chewie(
            controller: _chewieController!,
          ));
    } else if(url.contains('pdf')) {
      return TextButton(
          onPressed: () {
            Get.to(PDFViewerView(url: url));
          },
          child: const Text('Evidence is a document. Tap for view'));
    }else {
      return Text('No Evidence Available');
    }

  }

  @override
  void dispose() {
    _chewieController?.dispose();
    _controller.dispose();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      _controller.pause();
    } else if (state == AppLifecycleState.resumed) {
      _controller.play();
    }
  }
}
