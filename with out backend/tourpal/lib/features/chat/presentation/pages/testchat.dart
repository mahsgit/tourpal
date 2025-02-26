// import 'dart:io';
// import 'package:bubble/bubble.dart';
// import 'package:chat_bubbles/bubbles/bubble_normal_audio.dart';
// import 'package:flutter/material.dart';
// import 'package:just_audio/just_audio.dart';
// import 'package:http/http.dart' as http;
// import 'package:path_provider/path_provider.dart';

// class Message {
//   final String type; // 'text', 'image', or 'voice'
//   final String content; // message text or image/voice file path
//   final bool isUser;
//   final String name;
//   final String? date;
//   final File? profileImage;

//   Message({
//     required this.type,
//     required this.content,
//     required this.isUser,
//     required this.name,
//      this.date="20/20/2020",
//     this.profileImage,
//   });
// }

// class ChatScreen extends StatefulWidget {
//   final List<Message> messages;

//   ChatScreen({required this.messages});

//   @override
//   _ChatScreenState createState() => _ChatScreenState();
// }

// class _ChatScreenState extends State<ChatScreen> {
//   final AudioPlayer _audioPlayer = AudioPlayer();
//   Duration _duration = Duration();
//   Duration _position = Duration();
//   bool _isPlaying = false;
//   bool _isLoading = false;
//   bool _isPaused = false;

//   @override
//   void initState() {
//     super.initState();
//     _audioPlayer.positionStream.listen((position) {
//       setState(() {
//         _position = position;
//       });
//     });

//     _audioPlayer.durationStream.listen((duration) {
//       setState(() {
//         _duration = duration ?? Duration();
//       });
//     });

//     _audioPlayer.playerStateStream.listen((state) {
//       setState(() {
//         _isPlaying = state.playing;
//         _isPaused =
//             state.processingState == ProcessingState.ready && !_isPlaying;
//         _isLoading = state.processingState == ProcessingState.loading ||
//             state.processingState == ProcessingState.buffering;
//       });
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: ListView.builder(
//         itemCount: widget.messages.length,
//         itemBuilder: (context, index) {
//           final message = widget.messages[index];
//           return Padding(
//             padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
//             child: Row(
//               mainAxisAlignment: message.isUser
//                   ? MainAxisAlignment.start
//                   : MainAxisAlignment.end,
//               children: [
//                 if (message.isUser) _buildProfileAvatar(message.profileImage),
//                 SizedBox(width: 10),
//                 Expanded(child: _buildMessageContent(message)),
//                 if (!message.isUser) _buildProfileAvatar(message.profileImage),
//               ],
//             ),
//           );
//         },
//       ),
//     );
//   }

//   Widget _buildProfileAvatar(File? profileImage) {
//     return CircleAvatar(
//       backgroundImage: profileImage != null ? FileImage(profileImage) : null,
//       child: profileImage == null ? Icon(Icons.person) : null,
//     );
//   }

//   Widget _buildMessageContent(Message message) {
//     return Column(
//       crossAxisAlignment:
//           message.isUser ? CrossAxisAlignment.start : CrossAxisAlignment.end,
//       children: [
//         Text(
//           message.name,
//           style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
//         ),
//         SizedBox(height: 5),
//         _buildMessageBubble(message),
//         SizedBox(height: 5),
//         Text(
//           message.date!,
//           style: TextStyle(fontSize: 12, color: Colors.grey),
//         ),
//       ],
//     );
//   }

//   Widget _buildMessageBubble(Message message) {
//     switch (message.type) {
//       case 'text':
//         return Bubble(
//           child: Text(message.content),
//           color: message.isUser ? Colors.blue : Colors.grey[300],
//           nip: message.isUser ? BubbleNip.leftTop : BubbleNip.rightTop,
//         );
//       case 'image':
//         return Container(
//           constraints: BoxConstraints(maxWidth: 200),
//           child: Image.file(File(message.content)),
//         );
//       case 'voice':
//         return BubbleNormalAudio(
//           color: Color(0xFFE8E8EE),
//           duration: _duration.inSeconds.toDouble(),
//           position: _position.inSeconds.toDouble(),
//           isPlaying: _isPlaying,
//           isLoading: _isLoading,
//           isPause: _isPaused,
//           onSeekChanged: _changeSeek,
//           onPlayPauseButtonClick: () => _playPauseAudio(message.content),
//           sent: message.isUser,
//         );
//       default:
//         return SizedBox.shrink();
//     }
//   }

//   void _changeSeek(double value) {
//     final newPosition = Duration(seconds: value.toInt());
//     _audioPlayer.seek(newPosition);
//   }

//   Future<void> _playPauseAudio(String url) async {
//     if (_isPlaying) {
//       await _audioPlayer.pause();
//     } else {
//       if (_isPaused) {
//         await _audioPlayer.play();
//       } else {
//         setState(() {
//           _isLoading = true;
//         });
//         try {
//           // Fetch the audio from the URL and play it
//           await _audioPlayer.setUrl(url);
//           await _audioPlayer.play();
//         } catch (e) {
//           print('Error loading audio: $e');
//         }
//         setState(() {
//           _isLoading = false;
//         });
//       }
//     }
//   }

//   @override
//   void dispose() {
//     _audioPlayer.dispose();
//     super.dispose();
//   }
// }

// void main() {
//   runApp(MaterialApp(
//     home: ChatScreen(
//       messages: [
//         Message(
//           type: 'text',
//           content: 'Hello mjid !',
//           isUser: true,
//           name: 'User',
//           date: '8/23/2024',
//           profileImage: File('images/image.png'),
//         ),
//         Message(
//           type: 'text',
//           content: 'Hello mjid !',
//           isUser: false,
//           name: 'User',
//           date: '8/23/2024',
//           profileImage: File('images/image.png'),
//         ),
//         Message(
//           type: 'image',
//           content: 'image.jpg',
//           isUser: false,
//           name: 'Bot',
//           date: '8/23/2024',
//           profileImage: File('images/image.png'),
//         ),
//         Message(
//           type: 'voice',
//           content:
//               'https://example.com/audio.mp3', // Example URL for audio file
//           isUser: true,
//           name: 'User',
//           date: '8/23/2024',
//           profileImage: File('images/image.png'),
//         ),
//       ],
//     ),
//   ));
// }
