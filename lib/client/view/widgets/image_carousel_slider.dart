import 'package:ecrime/client/view/widgets/widgets_barrel.dart';

class ImageCarouselSlider extends StatelessWidget {
  final List<String> imageList = [
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTZ_AU7jeTL0TRphFgK_ERAuaU8P-MgQyojmvJxgtPhP7xATnWyOO5NROaeCmA-dccGk1k&usqp=CAU',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRA0BGmxorF_pvFWmlMR9RXR6ntfX1EeZM0rhFsobnqeBj0CPEs-u_iy2xUYBGUyqowgdk&usqp=CAU',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQTxjkBue8hHEB3ugS-MhcjnzGM0bIgr52ozvIMxD5FdrCil-oQj7Ly_etWT_lTfWztXoo&usqp=CAU',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQJeJKnCp4l0meZs4EY1kaPW74qdpUg-DKwp_OCUmzCBAXPexJ1_-S6Xupd8dO9GCKitS4&usqp=CAU',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSMZHTnhCkPxIhv7D9sDvwxaP_5UnyEL0mYi-vh_4U-wFYgXdnmMLL-wpvBnl-quwBPERo&usqp=CAU',
  ];

  ImageCarouselSlider({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CarouselSlider(
        items: imageList.map((String imageUrl) {
          return Container(
            margin: const EdgeInsets.all(5.0),
            child: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(5.0)),
              child: Image.network(
                imageUrl,
                fit: BoxFit.fill,
                width: 1000.0,
              ),
            ),
          );
        }).toList(),
        options: CarouselOptions(
          height: 400.0,
          enlargeCenterPage: true,
          autoPlay: true,
          aspectRatio: 16 / 9,
          autoPlayCurve: Curves.fastOutSlowIn,
          enableInfiniteScroll: true,
          autoPlayAnimationDuration: const Duration(milliseconds: 800),
          viewportFraction: 0.8,
        ),
      ),
    );
  }
}
