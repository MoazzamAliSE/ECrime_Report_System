import 'package:ecrime/admin/view/view_admin_barrel.dart';
import 'package:ecrime/client/view/widgets/widgets_barrel.dart';

class FIRDetailPage extends StatefulWidget {
  final QueryDocumentSnapshot firSnapshot;

  const FIRDetailPage({super.key, required this.firSnapshot});

  @override
  State<FIRDetailPage> createState() => _FIRDetailPageState();
}

class _FIRDetailPageState extends State<FIRDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('FIR Number ${widget.firSnapshot['firNumber']}'),
      ),
      body: BackgroundFrame(
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
                const Text('Name of person who submit the fir'),
                Row(
                  children: [
                    const Text(
                      'Submitted at: ',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    Text('${widget.firSnapshot['timestamp']}'),
                  ],
                ),
                const Text(
                  'Description: ',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                Text(' ${widget.firSnapshot['description']}'),
                const SizedBox(height: 20),
                const Text(
                  'Files:',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                const SizedBox(height: 10),
                ..._buildFileWidgets(widget.firSnapshot, context),
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
    );
  }

  List<Widget> _buildFileWidgets(QueryDocumentSnapshot firSnapshot, context) {
    List<Widget> fileWidgets = [];

    List<String> videoUrls = List.from(firSnapshot['videoUrls']);
    List<String> pictureUrls = List.from(firSnapshot['pictureUrls']);
    List<String> pdfUrls = List.from(firSnapshot['pdfUrls']);

    fileWidgets.addAll(_buildVideoWidgets(videoUrls));
    fileWidgets.add(const SizedBox(height: 10));
    fileWidgets.addAll(_buildPictureWidgets(pictureUrls));
    fileWidgets.add(const SizedBox(height: 10));
    fileWidgets.addAll(_buildPDFWidgets(pdfUrls, context));

    return fileWidgets;
  }

  List<Widget> _buildVideoWidgets(List<String> videoUrls) {
    List<Widget> videoWidgets = [];

    for (String url in videoUrls) {
      VideoPlayerController videoPlayerController =
          VideoPlayerController.network(url);
      ChewieController chewieController = ChewieController(
        videoPlayerController: videoPlayerController,
        aspectRatio: 16 / 9,
        autoPlay: false,
        looping: false,
      );

      videoWidgets.add(
        Container(
          padding: const EdgeInsets.all(5),
          decoration: BoxDecoration(
            color: Colors.grey.withOpacity(.2),
          ),
          height: 200,
          child: Chewie(
            controller: chewieController,
          ),
        ),
      );
      _controllers.add(chewieController);
    }

    return videoWidgets.isNotEmpty
        ? videoWidgets
        : [const Text('No video available')];
  }

  final List<ChewieController> _controllers = [];

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  List<Widget> _buildPictureWidgets(List<String> pictureUrls) {
    return pictureUrls.isNotEmpty
        ? pictureUrls.map((url) {
            return Padding(
              padding: const EdgeInsets.all(5),
              child: Image.network(url,
                  height: 200,
                  width: 200,
                  fit: BoxFit.fitHeight, errorBuilder: (BuildContext context,
                      Object error, StackTrace? stackTrace) {
                return const Text('No image available');
              }),
            );
          }).toList()
        : [const Text('No image available')];
  }

  List<Widget> _buildPDFWidgets(List<String> pdfUrls, context) {
    return pdfUrls.isNotEmpty
        ? pdfUrls.map((url) {
            return ElevatedButton(
              onPressed: () async {
                try {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return const AlertDialog(
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            CircularProgressIndicator(),
                            SizedBox(height: 10),
                            Text("Downloading PDF..."),
                          ],
                        ),
                      );
                    },
                  );

                  PDFDocument document = await PDFDocument.fromURL(url);

                  Navigator.pop(context);

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PDFViewer(document: document),
                    ),
                  );
                } catch (e) {
                  Navigator.pop(context);

                  print('Error loading PDF: $e');
                }
              },
              child: const Text('Open PDF'),
            );
          }).toList()
        : [const Text('No PDF available')];
  }
}
