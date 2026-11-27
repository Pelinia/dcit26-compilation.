/*lab 7
angelo_monterroyo
jose_michael_paredes
karl_pelinia
bscs 3-1
*/
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() => runApp(const MyApp());

const Color kGreen = Color(0xFF236F4A);
const Color kLightGreen = Color(0xFFE3F1E9);

// ---------- Model ----------
class RandomUser {
  const RandomUser({
    required this.fullName,
    required this.gender,
    required this.email,
    required this.pictureLarge,
    required this.street,
    required this.city,
    required this.state,
    required this.country,
    required this.postcode,
    required this.timezone,
    required this.dob,
    required this.age,
    required this.registered,
    required this.registeredYears,
    required this.phone,
    required this.cell,
    required this.idName,
    required this.idValue,
    required this.nationality,
    required this.username,
    required this.uuid,
  });

  final String fullName;
  final String gender;
  final String email;
  final String pictureLarge;
  final String street;
  final String city;
  final String state;
  final String country;
  final String postcode;
  final String timezone;
  final String dob;
  final String age;
  final String registered;
  final String registeredYears;
  final String phone;
  final String cell;
  final String idName;
  final String idValue;
  final String nationality;
  final String username;
  final String uuid;

  // Every field is read defensively: missing values become '' and are
  // displayed as "Not provided". Password, salt, md5, sha1 and sha256
  // are intentionally never parsed.
  factory RandomUser.fromJson(Map<String, dynamic> json) {
    String s(dynamic v) => v == null ? '' : v.toString().trim();
    Map<String, dynamic> m(dynamic v) =>
        v is Map<String, dynamic> ? v : <String, dynamic>{};

    final name = m(json['name']);
    final location = m(json['location']);
    final street = m(location['street']);
    final tz = m(location['timezone']);
    final dob = m(json['dob']);
    final reg = m(json['registered']);
    final id = m(json['id']);
    final picture = m(json['picture']);
    final login = m(json['login']);

    final streetText = [s(street['number']), s(street['name'])]
        .where((e) => e.isNotEmpty)
        .join(' ');
    final tzText = [s(tz['offset']), s(tz['description'])]
        .where((e) => e.isNotEmpty)
        .join(' - ');
    final fullName = [s(name['title']), s(name['first']), s(name['last'])]
        .where((e) => e.isNotEmpty)
        .join(' ');

    return RandomUser(
      fullName: fullName,
      gender: s(json['gender']),
      email: s(json['email']),
      pictureLarge: s(picture['large']),
      street: streetText,
      city: s(location['city']),
      state: s(location['state']),
      country: s(location['country']),
      postcode: s(location['postcode']),
      timezone: tzText,
      dob: s(dob['date']).split('T').first,
      age: s(dob['age']),
      registered: s(reg['date']).split('T').first,
      registeredYears: s(reg['age']),
      phone: s(json['phone']),
      cell: s(json['cell']),
      idName: s(id['name']),
      idValue: s(id['value']),
      nationality: s(json['nat']),
      username: s(login['username']),
      uuid: s(login['uuid']),
    );
  }
}

// ---------- Service ----------
Future<RandomUser> fetchRandomUser() async {
  final response = await http
      .get(Uri.parse('https://randomuser.me/api/'))
      .timeout(const Duration(seconds: 15));

  if (response.statusCode != 200) {
    throw Exception('Failed to load user (status ${response.statusCode})');
  }
  final data = jsonDecode(response.body) as Map<String, dynamic>;
  final results = data['results'] as List<dynamic>?;
  if (results == null || results.isEmpty) {
    throw const FormatException('No user data returned');
  }
  return RandomUser.fromJson(results.first as Map<String, dynamic>);
}

// ---------- App ----------
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lab 7 - Networking',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: kGreen),
        useMaterial3: true,
        appBarTheme: const AppBarTheme(
          backgroundColor: kGreen,
          foregroundColor: Colors.white,
        ),
      ),
      home: const HomeScreen(),
    );
  }
}

// ---------- Reusable avatar with loading + error fallback ----------
class UserAvatar extends StatelessWidget {
  const UserAvatar({super.key, required this.url, required this.radius});

  final String url;
  final double radius;

  @override
  Widget build(BuildContext context) {
    final size = radius * 2;
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: kLightGreen,
        border: Border.all(color: kGreen, width: 2),
      ),
      clipBehavior: Clip.antiAlias,
      child: url.isEmpty
          ? Icon(Icons.person, size: radius, color: kGreen)
          : Image.network(
              url,
              fit: BoxFit.cover,
              // Loading indicator for the network image
              loadingBuilder: (context, child, progress) {
                if (progress == null) return child;
                return const Center(
                  child: CircularProgressIndicator(color: kGreen),
                );
              },
              // Fallback if the image fails to load
              errorBuilder: (context, error, stack) => Icon(
                Icons.broken_image_outlined,
                size: radius,
                color: Colors.grey,
              ),
            ),
    );
  }
}

// ---------- Home screen ----------
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  RandomUser? _user;
  bool _loading = false;
  String? _error;

  @override
  void initState() {
    super.initState();
    // Request on initialization, NOT inside build()
    _loadUser();
  }

  Future<void> _loadUser() async {
    setState(() {
      _loading = true;
      _error = null;
    });
    try {
      final user = await fetchRandomUser();
      if (!mounted) return;
      setState(() => _user = user);
    } catch (e) {
      if (!mounted) return;
      setState(() => _error = 'Could not load a user. Check your internet '
          'connection and try again.');
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Random User')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: _buildBody(),
        ),
      ),
    );
  }

  Widget _buildBody() {
    // First load: nothing to show yet
    if (_loading && _user == null) {
      return const Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CircularProgressIndicator(color: kGreen),
          SizedBox(height: 16),
          Text('Loading user...'),
        ],
      );
    }

    // Error with no user to fall back on
    if (_error != null && _user == null) {
      return _ErrorView(message: _error!, onRetry: _loadUser);
    }

    final user = _user!;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Tap the picture -> pass the exact user currently shown
        GestureDetector(
          onTap: _loading
              ? null
              : () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProfileScreen(user: user),
                    ),
                  );
                },
          child: UserAvatar(url: user.pictureLarge, radius: 70),
        ),
        const SizedBox(height: 6),
        const Text('Tap the picture to view profile',
            style: TextStyle(fontSize: 12, color: Colors.grey)),
        const SizedBox(height: 16),
        Text(
          user.fullName.isEmpty ? 'Name not provided' : user.fullName,
          style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
        if (user.email.isNotEmpty)
          Text(user.email,
              style: const TextStyle(fontSize: 13, color: Colors.grey)),
        const SizedBox(height: 8),
        const Text('Generated sample data',
            style: TextStyle(fontSize: 11, fontStyle: FontStyle.italic)),
        // Refresh failed but we still have a previous user
        if (_error != null) ...[
          const SizedBox(height: 12),
          Text(_error!,
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.red)),
        ],
        const SizedBox(height: 24),
        SizedBox(
          width: double.infinity,
          child: FilledButton(
            style: FilledButton.styleFrom(
              backgroundColor: kGreen,
              padding: const EdgeInsets.symmetric(vertical: 14),
            ),
            onPressed: _loading ? null : _loadUser,
            child: _loading
                ? const SizedBox(
                    height: 18,
                    width: 18,
                    child: CircularProgressIndicator(
                        strokeWidth: 2, color: Colors.white),
                  )
                : Text(_error != null ? 'RETRY' : 'NEW USER'),
          ),
        ),
      ],
    );
  }
}

class _ErrorView extends StatelessWidget {
  const _ErrorView({required this.message, required this.onRetry});

  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Icon(Icons.wifi_off, size: 56, color: Colors.red),
        const SizedBox(height: 12),
        Text(message, textAlign: TextAlign.center),
        const SizedBox(height: 16),
        FilledButton(
          style: FilledButton.styleFrom(backgroundColor: kGreen),
          onPressed: onRetry,
          child: const Text('RETRY'),
        ),
      ],
    );
  }
}

// ---------- Profile screen ----------
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key, required this.user});

  // Receives the exact user shown on Home. No refetching here.
  final RandomUser user;

  String _v(String value) => value.isEmpty ? 'Not provided' : value;

  @override
  Widget build(BuildContext context) {
    final location = [user.street, user.city, user.state, user.country]
        .where((e) => e.isNotEmpty)
        .join(', ');
    final ageText = user.age.isEmpty ? '' : '${user.age} years old';
    final dobText = [user.dob, ageText].where((e) => e.isNotEmpty).join('  •  ');
    final regText = [
      user.registered,
      if (user.registeredYears.isNotEmpty) '${user.registeredYears} yrs ago',
    ].where((e) => e.isNotEmpty).join('  •  ');
    final idText = [user.idName, user.idValue].where((e) => e.isNotEmpty).join(': ');

    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Center(child: UserAvatar(url: user.pictureLarge, radius: 60)),
          const SizedBox(height: 12),
          Center(
            child: Text(
              user.fullName.isEmpty ? 'Name not provided' : user.fullName,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
          ),
          const Center(
            child: Padding(
              padding: EdgeInsets.only(top: 4, bottom: 16),
              child: Text(
                'Generated sample data - not a real person',
                style: TextStyle(fontSize: 11, fontStyle: FontStyle.italic),
              ),
            ),
          ),
          _Section(title: 'Personal', rows: {
            'Gender': _v(user.gender),
            'Date of birth / age': _v(dobText),
            'Nationality': _v(user.nationality),
          }),
          _Section(title: 'Location', rows: {
            'Address': _v(location),
            'Postcode': _v(user.postcode),
            'Timezone': _v(user.timezone),
          }),
          _Section(title: 'Contact', rows: {
            'Email': _v(user.email),
            'Phone': _v(user.phone),
            'Cell': _v(user.cell),
          }),
          _Section(title: 'Account', rows: {
            'Username': _v(user.username),
            'UUID': _v(user.uuid),
            'Registered': _v(regText),
            'ID': _v(idText),
          }),
        ],
      ),
    );
  }
}

class _Section extends StatelessWidget {
  const _Section({required this.title, required this.rows});

  final String title;
  final Map<String, String> rows;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title,
                style: const TextStyle(
                    color: kGreen, fontWeight: FontWeight.bold, fontSize: 15)),
            const Divider(),
            for (final entry in rows.entries)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 120,
                      child: Text(entry.key,
                          style: const TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 13)),
                    ),
                    Expanded(
                      child: Text(entry.value,
                          style: TextStyle(
                            fontSize: 13,
                            color: entry.value == 'Not provided'
                                ? Colors.grey
                                : null,
                          )),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}