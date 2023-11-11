import 'package:advance_pdf_viewer/advance_pdf_viewer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:chewie/chewie.dart';
import 'package:video_player/video_player.dart';

class ViewFIRsPage extends StatelessWidget {
  const ViewFIRsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('View FIRs'),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('firs').snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return const CircularProgressIndicator();
          }

          List<QueryDocumentSnapshot> firs = snapshot.data!.docs;

          return ListView.builder(
            itemCount: firs.length,
            itemBuilder: (context, index) {
              return FIRListItem(firSnapshot: firs[index]);
            },
          );
        },
      ),
    );
  }
}

class FIRListItem extends StatelessWidget {
  final QueryDocumentSnapshot firSnapshot;

  const FIRListItem({super.key, required this.firSnapshot});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: NetworkImage(firSnapshot['userImage']),
      ),
      title: Text('FIR Number ${firSnapshot['firNumber']}'),
      subtitle: Text('Submitted at ${firSnapshot['timestamp']}'),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => FIRDetailPage(firSnapshot: firSnapshot),
          ),
        );
      },
    );
  }
}

class FIRDetailPage extends StatelessWidget {
  final QueryDocumentSnapshot firSnapshot;

  const FIRDetailPage({super.key, required this.firSnapshot});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('FIR Number ${firSnapshot['firNumber']}'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text('Description: ${firSnapshot['description']}'),
            const SizedBox(height: 20),
            const Text('Files:'),
            const SizedBox(height: 10),
            ..._buildFileWidgets(firSnapshot, context),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {},
              child: const Text('Assign FIR'),
            ),
          ],
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
    fileWidgets.addAll(_buildPictureWidgets(pictureUrls));
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
        Chewie(
          controller: chewieController,
        ),
      );
    }

    return videoWidgets;
  }

  List<Widget> _buildPictureWidgets(List<String> pictureUrls) {
    return pictureUrls.map((url) {
      return Image.network(url);
    }).toList();
  }

  List<Widget> _buildPDFWidgets(List<String> pdfUrls, context) {
    return pdfUrls.map((url) {
      return ElevatedButton(
        onPressed: () async {
          PDFDocument document = await PDFDocument.fromURL(url);

          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PDFViewer(document: document),
            ),
          );
        },
        child: const Text('Open PDF'),
      );
    }).toList();
  }
}
