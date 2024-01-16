import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DescriptionPage extends StatefulWidget {
  final String documentId;
  final String categoryName;
  final String categoryImage;
  final List<DocumentSnapshot> allEventsData;

  const DescriptionPage({
    Key? key,
    required this.documentId,
    required this.categoryName,
    required this.categoryImage,
    required this.allEventsData,
  }) : super(key: key);

  @override
  _DescriptionPageState createState() => _DescriptionPageState();
}

class _DescriptionPageState extends State<DescriptionPage> {
  List<int> selectedImageIndices = List.filled(100, 0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text(widget.categoryName),
      // ),
      body: SingleChildScrollView(
        // Ensure scrolling for longer content
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 8.0),
                  for (final eventData in widget.allEventsData) ...[
                    _buildEventCard(eventData),
                    const SizedBox(height: 16.0),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEventCard(DocumentSnapshot eventData) {
    final pid = eventData['pid'];
    final price = eventData['price'];
    final pimages = eventData['pimage'] as List<dynamic>;

    final int productIndex = widget.allEventsData.indexOf(eventData);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () {
                setState(() {
                  // Update the selectedImageIndex for the specific product on tap
                  selectedImageIndices[productIndex] = 0;
                });
              },
              child: SizedBox(
                width: 370,
                height: 400,
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(25),
                    child: CachedNetworkImage(
                      imageUrl: pimages.isNotEmpty
                          ? pimages[selectedImageIndices[productIndex]]
                      as String
                          : 'default_image_url',
                      placeholder: (context, url) =>
                      const CircularProgressIndicator(),
                      errorWidget: (context, url, error) =>
                      const Icon(Icons.error),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 8.0),
            const Text(
              "Description",
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 25,
              ),
            ),
            const SizedBox(height: 8.0),

            const SizedBox(height: 8.0),

            Padding(
              padding: const EdgeInsets.only(left: 0),
              child: Text(
                "${price}",
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            const SizedBox(height: 8.0),
            SizedBox(
              height: 120, // Adjust height as needed
              child: SizedBox(
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: pimages.length,
                  itemBuilder: (context, imageIndex) {
                    final imageUrl = pimages[imageIndex] as String;
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          // Update the selectedImageIndex for the specific product on tap
                          selectedImageIndices[productIndex] = imageIndex;
                        });
                      },
                      child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SizedBox(
                            height: 80,
                            width: 80,
                            child: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(20.0),
                                child: Image.network(
                                  imageUrl,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          )),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}