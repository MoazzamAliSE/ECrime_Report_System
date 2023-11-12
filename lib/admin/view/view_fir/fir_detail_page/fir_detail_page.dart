import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecrime/admin/view/view_admin_barrel.dart';
import 'package:ecrime/admin/view/view_fir/fir_detail_page/pdfViewer.dart';
import 'package:ecrime/client/view/widgets/widgets_barrel.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:get/get.dart';

class FIRDetailPage extends StatefulWidget {
  final DataSnapshot snapshot;

  const FIRDetailPage({super.key, required this.snapshot});

  @override
  State<FIRDetailPage> createState() => _FIRDetailPageState();
}

class _FIRDetailPageState extends State<FIRDetailPage> {
  late VideoPlayerController _controller;
  ChewieController? _chewieController;
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            'FIR Number ${widget.snapshot.child('key').value.toString().substring(0, 4)}'),
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
                  const Text(
                    'Description: ',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  Text(
                      ' ${widget.snapshot.child('incidentDetails').value.toString()}'),
                  const SizedBox(height: 20),
                  const Text(
                    'Files:',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  const SizedBox(height: 10),
                  fileWidget(),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {},
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
        placeholder: (context, url) => Padding(
          padding: const EdgeInsets.all(50),
          child: SizedBox(
              height: 15,
              width: 15,
              child: Center(
                child: CircularProgressIndicator(
                  color: AppColor.primaryColor,
                ),
              )),
        ),
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
    } else {
      return TextButton(
          onPressed: () {
            Get.to(PDFViewerView(url: url));
          },
          child: const Text('Evidence is a document. Tap for view'));
    }
  }

  @override
  void dispose() {
    super.dispose();
  }
}
