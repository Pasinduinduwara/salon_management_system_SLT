import 'package:flutter/material.dart';
import 'feedbacks-view-details.dart';
import 'feedback-reply.dart';
import '../../widgets/feedbacks/rating_summary_widget.dart';
import '../../widgets/feedbacks/filter_buttons_widget.dart';
import '../../widgets/feedbacks/feedback_card_widget.dart';

class FeedbacksPage extends StatefulWidget {
  const FeedbacksPage({Key? key}) : super(key: key);

  @override
  State<FeedbacksPage> createState() => _FeedbacksPageState();
}

class _FeedbacksPageState extends State<FeedbacksPage> {
  String selectedFilter = 'All';

  final List<Map<String, dynamic>> ratings = [
    {'stars': 5, 'percentage': 80, 'count': 92},
    {'stars': 4, 'percentage': 11, 'count': 13},
    {'stars': 3, 'percentage': 5, 'count': 6},
    {'stars': 2, 'percentage': 3, 'count': 3},
    {'stars': 1, 'percentage': 1, 'count': 1},
  ];

  final List<Map<String, dynamic>> feedbacks = [
    {
      'name': 'Sophia Bennett',
      'service': 'Haircut with Emily',
      'date': 'July 12, 2024',
      'review': 'Emily was attentive and gave me a fantastic haircut. The salon had a welcoming atmosphere.',
      'rating': 5.0,
      'timestamp': DateTime.parse('2024-07-12').millisecondsSinceEpoch,
    },
    {
      'name': 'Ethan Carter',
      'service': 'Manicure with Olivia',
      'date': 'July 10, 2024',
      'review': 'Olivia\'s manicure was impeccable, and she was very friendly. I\'m very pleased with the results.',
      'rating': 5.0,
      'timestamp': DateTime.parse('2024-07-10').millisecondsSinceEpoch,
    },
    {
      'name': 'Isabella Davis',
      'service': 'Facial with Chloe',
      'date': 'July 8, 2024',
      'review': 'Chloe\'s facial was incredibly relaxing and my skin feels rejuvenated. I highly recommend her.',
      'rating': 5.0,
      'timestamp': DateTime.parse('2024-07-08').millisecondsSinceEpoch,
    },
    {
      'name': 'Michael Johnson',
      'service': 'Hair Color with Sarah',
      'date': 'July 15, 2024',
      'review': 'Sarah did an amazing job with my hair color. The results exceeded my expectations!',
      'rating': 4.5,
      'timestamp': DateTime.parse('2024-07-15').millisecondsSinceEpoch,
    },
    {
      'name': 'Emma Wilson',
      'service': 'Massage with David',
      'date': 'July 5, 2024',
      'review': 'David\'s massage technique is excellent. Very relaxing and professional.',
      'rating': 4.0,
      'timestamp': DateTime.parse('2024-07-05').millisecondsSinceEpoch,
    },
    {
      'name': 'James Brown',
      'service': 'Beard Trim with Alex',
      'date': 'July 18, 2024',
      'review': 'Alex gave me the perfect beard trim. Attention to detail was impressive.',
      'rating': 3.5,
      'timestamp': DateTime.parse('2024-07-18').millisecondsSinceEpoch,
    },
  ];

  // Get filtered feedbacks based on selected filter
  List<Map<String, dynamic>> get filteredFeedbacks {
    switch (selectedFilter) {
      case 'Newest':
        return List.from(feedbacks)
          ..sort((a, b) => b['timestamp'].compareTo(a['timestamp']));
      case 'Top Rated':
        return List.from(feedbacks)
          ..sort((a, b) => b['rating'].compareTo(a['rating']));
      default:
        return feedbacks;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back, color: Colors.black, size: 28),
        ),
        title: const Text(
          'Feedbacks',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 24),
                
                // Rating Summary Card
                RatingSummaryWidget(
                  overallRating: 4.7,
                  reviewCount: 115,
                  ratings: ratings,
                ),
                
                const SizedBox(height: 24),
                
                // Filter Buttons
                FilterButtonsWidget(
                  selectedFilter: selectedFilter,
                  onFilterSelected: (filter) {
                    setState(() {
                      selectedFilter = filter;
                    });
                  },
                ),
                
                const SizedBox(height: 24),
                
                // Feedback List
                ...filteredFeedbacks.map((feedback) => FeedbackCardWidget(
                  feedback: feedback,
                  onViewDetails: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const FeedbackDetailsPage(),
                      ),
                    );
                  },
                  onReply: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ReplyToFeedbackPage(),
                      ),
                    );
                  },
                )).toList(),
                
                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }

}