import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tracker/screens/profile_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _formKey = GlobalKey<FormState>();
  final _searchController = TextEditingController();
  List<QueryDocumentSnapshot>? _users = [];
  bool showSearchBox = false;

  void _searchUsers() async {
    final query = _searchController.text.trim();
    if (query.isEmpty) return;
    final snapshots = await FirebaseFirestore.instance
        .collection('users')
        .where('name', isGreaterThanOrEqualTo: query)
        .where('name', isLessThanOrEqualTo: '$query\uf8ff')
        .get();
    setState(() {
      _users = snapshots.docs;
    });
  }

  void _openChatPage(String phoneNumber) {
// TODO: Implement opening chat page
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tracer'),
        actions: <Widget>[
          IconButton(
            onPressed: () {
              setState(() {
                showSearchBox = true;
              });
            },
            icon: const Icon(Icons.search),
            tooltip: 'Search',
          ),
          if (showSearchBox)
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
                child: TextFormField(
                  key: _formKey,
                  autofocus: true,
                  controller: _searchController,
                  decoration: InputDecoration(
                    hintText: 'Search users',
                    border: InputBorder.none,
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.clear),
                      onPressed: () {
                        setState(() {
                          showSearchBox = false;
                          _searchController.clear();
                          _users = [];
                        });
                      },
                    ),
                  ),
                  onChanged: (value) => _searchUsers(),
                ),
              ),
            ),
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ProfileScreen()),
              );
            },
            icon: const Icon(Icons.info_outline),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _users?.length ?? 0,
              itemBuilder: (context, index) {
                final user = _users?[index].data() as Map<String, dynamic>?;
                if (user == null) {
                  return const SizedBox();
                }
                return ListTile(
                  title: Text(user['name']),
                  subtitle: Text(user['phoneNumber']),
                  onTap: () => _openChatPage(user['phoneNumber']),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
