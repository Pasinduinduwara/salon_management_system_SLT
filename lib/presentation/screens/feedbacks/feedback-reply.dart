import 'package:flutter/material.dart';

class ReplyToFeedbackPage extends StatefulWidget {
  const ReplyToFeedbackPage({Key? key}) : super(key: key);

  @override
  State<ReplyToFeedbackPage> createState() => _ReplyToFeedbackPageState();
}

class _ReplyToFeedbackPageState extends State<ReplyToFeedbackPage> {
  final TextEditingController _replyController = TextEditingController();
  bool _isSubmitting = false;
  int likeCount = 2;
  bool isLiked = false;

  @override
  void dispose() {
    _replyController.dispose();
    super.dispose();
  }

  void _toggleLike() {
    setState(() {
      if (isLiked) {
        likeCount--;
        isLiked = false;
      } else {
        likeCount++;
        isLiked = true;
      }
    });
  }

  void _showSuccessSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.green,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        margin: const EdgeInsets.all(16),
      ),
    );
  }

  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        margin: const EdgeInsets.all(16),
      ),
    );
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
                const SizedBox(height: 32),
                
                // User Profile Section
                _buildUserProfile(),
                
                const SizedBox(height: 28),
                
                // Star Rating
                _buildStarRating(),
                
                const SizedBox(height: 20),
                
                // Review Text
                _buildReviewText(),
                
                const SizedBox(height: 20),
                
                // Like and Dislike Section
                _buildLikeDislikeSection(),
                
                const SizedBox(height: 28),
                
                // Reply Text Field
                _buildReplyTextField(),
                
                const SizedBox(height: 24),
                
                // Send Reply Button
                _buildSendReplyButton(),
                
                const SizedBox(height: 32),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildUserProfile() {
    return Row(
      children: [
        // Avatar
        Container(
          width: 64,
          height: 64,
          decoration: BoxDecoration(
            color: Colors.grey.shade200,
            shape: BoxShape.circle,
          ),
          child: Icon(
            Icons.person_outline,
            color: Colors.grey.shade400,
            size: 32,
          ),
        ),
        const SizedBox(width: 16),
        // User Info
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Sophia Bennett',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                'sophiabennett@gmail.com',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey.shade600,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildStarRating() {
    return Row(
      children: List.generate(
        5,
        (index) => const Padding(
          padding: EdgeInsets.only(right: 4),
          child: Icon(
            Icons.star,
            color: Colors.black87,
            size: 28,
          ),
        ),
      ),
    );
  }

  Widget _buildReviewText() {
    return const Text(
      'The service was excellent, and the staff was very friendly. I especially loved the ambiance of the salon. Will definitely come back!',
      style: TextStyle(
        fontSize: 15,
        color: Colors.black87,
        height: 1.6,
        fontWeight: FontWeight.w400,
      ),
    );
  }

  Widget _buildLikeDislikeSection() {
    return Row(
      children: [
        // Like Button
        InkWell(
          onTap: _toggleLike,
          borderRadius: BorderRadius.circular(8),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
            child: Row(
              children: [
                Icon(
                  isLiked ? Icons.thumb_up : Icons.thumb_up_outlined,
                  color: isLiked ? const Color(0xFF1565C0) : Colors.grey.shade600,
                  size: 22,
                ),
                const SizedBox(width: 6),
                Text(
                  '$likeCount',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: isLiked ? const Color(0xFF1565C0) : Colors.grey.shade700,
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(width: 20),
        // Dislike Button
        InkWell(
          onTap: () {
            // Dislike action
          },
          borderRadius: BorderRadius.circular(8),
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Icon(
              Icons.thumb_down_outlined,
              color: Colors.grey.shade600,
              size: 22,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildReplyTextField() {
    return Container(
      height: 200,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Colors.grey.shade300,
          width: 1.5,
        ),
      ),
      child: TextField(
        controller: _replyController,
        maxLines: null,
        expands: true,
        textAlignVertical: TextAlignVertical.top,
        decoration: InputDecoration(
          hintText: 'Write your reply here...',
          hintStyle: TextStyle(
            fontSize: 16,
            color: Colors.black38,
            fontWeight: FontWeight.w400,
          ),
          border: InputBorder.none,
          contentPadding: EdgeInsets.zero,
        ),
        style: const TextStyle(
          fontSize: 16,
          color: Colors.black,
          height: 1.5,
        ),
      ),
    );
  }

  Widget _buildSendReplyButton() {
    return Align(
      alignment: Alignment.centerRight,
      child: SizedBox(
        width: 160,
        height: 56,
        child: ElevatedButton(
          onPressed: _isSubmitting
              ? null
              : () async {
                  if (_replyController.text.trim().isEmpty) {
                    _showErrorSnackBar('Please write a reply');
                    return;
                  }

                  setState(() => _isSubmitting = true);

                  // Simulate sending reply
                  await Future.delayed(const Duration(milliseconds: 800));

                  if (!mounted) return;

                  setState(() => _isSubmitting = false);

                  _showSuccessSnackBar('Reply sent successfully!');
                  
                  // Clear the text field
                  _replyController.clear();

                  // Navigate back after a short delay
                  Future.delayed(const Duration(milliseconds: 500), () {
                    if (mounted) {
                      Navigator.pop(context);
                    }
                  });
                },
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF1565C0),
            foregroundColor: Colors.white,
            disabledBackgroundColor: Colors.grey.shade400,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            elevation: 0,
          ),
          child: _isSubmitting
              ? const SizedBox(
                  width: 24,
                  height: 24,
                  child: CircularProgressIndicator(
                    color: Colors.white,
                    strokeWidth: 2,
                  ),
                )
              : const Text(
                  'Send Reply',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
        ),
      ),
    );
  }
}