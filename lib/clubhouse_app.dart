import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';

class ClubHouseApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Clubhouse UI',
      theme: ThemeData(
        appBarTheme: const AppBarTheme(backgroundColor: Palette.background),
        scaffoldBackgroundColor: Palette.background,
        primaryColor: Colors.white,
        accentColor: Palette.green,
        iconTheme: const IconThemeData(color: Colors.black),
        // fontFamily: GoogleFonts.montserrat().fontFamily,
        // textTheme: GoogleFonts.montserratTextTheme(),
      ),
      home: HomeScreen(),
    );
  }
}

// HomeScreen
class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            CupertinoIcons.search,
            size: 20.0,
          ),
          onPressed: () {},
        ),
        actions: [
          IconButton(
            icon: const Icon(
              CupertinoIcons.envelope_open,
              size: 20.0,
            ),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(
              CupertinoIcons.calendar,
              size: 20.0,
            ),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(
              CupertinoIcons.bell,
              size: 20.0,
            ),
            onPressed: () {},
          ),
          GestureDetector(
            onTap: () {},
            child: Padding(
              padding: const EdgeInsets.fromLTRB(8.0, 10.0, 20.0, 10.0),
              child: UserProfileImage(
                imageUrl: currentUser.imageUrl,
                size: 36.0,
              ),
            ),
          )
        ],
      ),
      body: Stack(
        alignment: Alignment.center,
        children: [
          ListView(
          padding: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 120.0),
          children: [
            UpCommingRoom(
              upcommingRooms: upcomingRoomsList,
            ),

            const SizedBox(height: 12.0,),

            ...roomsList.map((e) => RoomCard(room: e,))
          ],
        ),
        Positioned(
          left: 0,
          right: 0,
          bottom: 0,
          child: Container(
            height: 100.0,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Theme.of(context).scaffoldBackgroundColor.withOpacity(0.1),
                  Theme.of(context).scaffoldBackgroundColor,
                ]
              )
            ),
          ),
        ),
        Positioned(
          bottom: 60.0,
          child: Container(
            padding: const EdgeInsets.all(12.0),
            decoration: BoxDecoration(
              color: Theme.of(context).accentColor,
              borderRadius: BorderRadius.circular(24.0),
            ),
            child: const Text.rich(
              TextSpan(
                children: [
                  WidgetSpan(
                    child: Icon(
                      CupertinoIcons.add,
                      size: 21.0,
                      color: Colors.white,
                    )
                  ),
                  TextSpan(
                    text: 'Start a room',
                    style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w500)
                  )
                ]
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 60.0,
          right: 40.0,
          child: Stack(
            alignment: Alignment.center,
            children: [
              IconButton(icon: const Icon(CupertinoIcons.circle_grid_3x3_fill, size: 28.0,), onPressed: (){

              }
              ),
              Positioned(
                right: 4.6,
                bottom: 11.8,
                child: Container(
                  height: 16.0,
                  width: 16.0,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Theme.of(context).accentColor,
                  ),
                ),
              ),
            ],
          ),
        )
        ],
      ),
    );
  }
}


// Room card 
class RoomCard extends StatelessWidget {
  final Room room;
  const RoomCard({Key key, this.room}) : super(key: key); 
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${room.club} 🏠'.toUpperCase(),
                style: Theme.of(context).textTheme.overline.copyWith(
                  fontSize: 12.0,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 1.0
                ),
                overflow: TextOverflow.ellipsis,
              ),
              Text(room.name, style: Theme.of(context).textTheme.bodyText1.copyWith(
                fontSize: 15.0,
                fontWeight: FontWeight.bold
              ),
              ),
              const SizedBox(height: 12.0,),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Container(
                      height: 100.0,
                      child: Stack(
                        children: [
                          Positioned(
                            left: 28.0,
                            top: 20.0,
                            child: UserProfileImage(imageUrl: room.speakers[1].imageUrl, size: 48.0,),
                          ),
                          UserProfileImage(
                            imageUrl: room.speakers[0].imageUrl,
                            size: 48.0,
                          )
                        ],
                      ),
                    ),
                  ),

                  Expanded(flex: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ...room.speakers.map((e) => Text('${e.givenName} ${e.familyName}', style: Theme.of(context).textTheme.bodyText1.copyWith(
                        fontSize: 16.0),
                      ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 4.0),
                        child: Text.rich(TextSpan(children: [
                          TextSpan(text: '${room.speakers.length + room.followedBySpeakers.length + room.others.length}'),
                          const WidgetSpan(child: Icon(CupertinoIcons.person_fill, size: 18.0, color: Colors.grey,
                          )
                          ),
                          TextSpan(text: '${room.speakers.length}'),
                          const WidgetSpan(child:Icon(CupertinoIcons.chat_bubble_fill, size: 18, color: Colors.grey,))

                        ]
                        ),
                        style: TextStyle(color: Colors.grey[600]),

                        ),
                      )
                    ],
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}


// UpcommingRom
class UpCommingRoom extends StatelessWidget {
  final List<Room> upcommingRooms;
  const UpCommingRoom({Key key, this.upcommingRooms}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Palette.secondaryBackground,
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 32.0, top: 4.0, bottom: 4.0),
        child: Column(
          children: upcommingRooms
              .map((e) => Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                              top: e.club.isNotEmpty ? 2.0 : 0.0),
                          child: Text(e.time),
                        ),
                        const SizedBox(
                          width: 12.0,
                        ),
                        Expanded(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              if (e.club.isNotEmpty)
                                Flexible(
                                  child: Text(
                                    "${e.club} 🏠".toUpperCase(),
                                    style: Theme.of(context)
                                        .textTheme
                                        .overline
                                        .copyWith(
                                            fontWeight: FontWeight.w600,
                                            letterSpacing: 1.0),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              Flexible(
                                  child: Text(
                                e.name,
                                overflow: TextOverflow.ellipsis,
                              ))
                            ],
                          ),
                        )
                      ],
                    ),
                  ))
              .toList(),
        ),
      ),
    );
  }
}

// User Profile Image
class UserProfileImage extends StatelessWidget {
  final String imageUrl;
  final double size;
  const UserProfileImage({Key key, @required this.imageUrl, this.size = 48.0})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(size / 2 - size / 18),
      child: Image.network(
        imageUrl,
        height: size,
        width: size,
        fit: BoxFit.cover,
      ),
    );
  }
}

// Palette
class Palette {
  static const Color background = Color(0xFFF0F0E4);
  static const Color secondaryBackground = Color(0xFFE7E4D3);
  static const Color green = Color(0xFF2AAF61);
}

// Data
class User {
  final String givenName;
  final String familyName;
  final String imageUrl;

  const User({
    @required this.givenName,
    @required this.familyName,
    @required this.imageUrl,
  });
}

const User currentUser = User(
  givenName: 'Marcus',
  familyName: 'Ng',
  imageUrl:
      'https://images.unsplash.com/photo-1578133671540-edad0b3d689e?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1351&q=80',
);

const List<User> _allUsers = [
  User(
    givenName: 'Marcus',
    familyName: 'Ng',
    imageUrl:
        'https://images.unsplash.com/photo-1578133671540-edad0b3d689e?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1351&q=80',
  ),
  User(
    givenName: 'David',
    familyName: 'Brooks',
    imageUrl:
        'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=634&q=80',
  ),
  User(
    givenName: 'Jane',
    familyName: 'Doe',
    imageUrl:
        'https://images.unsplash.com/photo-1494790108377-be9c29b29330?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=634&q=80',
  ),
  User(
    givenName: 'Matthew',
    familyName: 'Hinkle',
    imageUrl:
        'https://images.unsplash.com/photo-1492562080023-ab3db95bfbce?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1331&q=80',
  ),
  User(
    givenName: 'Amy',
    familyName: 'Smith',
    imageUrl:
        'https://images.unsplash.com/photo-1534528741775-53994a69daeb?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=700&q=80',
  ),
  User(
    givenName: 'Ed',
    familyName: 'Morris',
    imageUrl:
        'https://images.unsplash.com/photo-1521119989659-a83eee488004?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=664&q=80',
  ),
  User(
    givenName: 'Carolyn',
    familyName: 'Duncan',
    imageUrl:
        'https://images.unsplash.com/photo-1544005313-94ddf0286df2?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=634&q=80',
  ),
  User(
    givenName: 'Paul',
    familyName: 'Pinnock',
    imageUrl:
        'https://images.unsplash.com/photo-1519631128182-433895475ffe?ixlib=rb-1.2.1&auto=format&fit=crop&w=1350&q=80',
  ),
  User(
      givenName: 'Elizabeth',
      familyName: 'Wong',
      imageUrl:
          'https://images.unsplash.com/photo-1515077678510-ce3bdf418862?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjF9&auto=format&fit=crop&w=675&q=80'),
  User(
    givenName: 'James',
    familyName: 'Lathrop',
    imageUrl:
        'https://images.unsplash.com/photo-1528892952291-009c663ce843?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=592&q=80',
  ),
  User(
    givenName: 'Jessie',
    familyName: 'Samson',
    imageUrl:
        'https://images.unsplash.com/photo-1517841905240-472988babdf9?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=634&q=80',
  ),
];

class Room {
  final String club;
  final String name;
  final String time;
  final List<User> speakers;
  final List<User> followedBySpeakers;
  final List<User> others;

  const Room({
    @required this.club,
    @required this.name,
    this.time = '',
    this.speakers = const [],
    this.followedBySpeakers = const [],
    this.others = const [],
  });
}

const List<Room> upcomingRoomsList = [
  Room(
    club: 'Flutter',
    name: 'Flutter Engage Recap 🔴',
    time: '3:00 PM',
  ),
  Room(
    club: 'New User Onboarding',
    name: 'Welcome to Clubhouse 👋',
    time: '7:00 PM',
  ),
  Room(
    club: '',
    name: 'Clubhouse Turns 1',
    time: '9:00 PM',
  ),
];

final List<Room> roomsList = [
  Room(
    club: 'Social Society',
    name: 'Welcome to Clubhouse 🎉 (Walkthrough with Q&A)',
    speakers: (List<User>.from(_allUsers)..shuffle()).getRange(0, 4).toList(),
    followedBySpeakers: List<User>.from(_allUsers)..shuffle(),
    others: List<User>.from(_allUsers)..shuffle(),
  ),
  Room(
    club: 'Good Time',
    name: '⏰ A Very Important Person on Good Time',
    speakers: (List<User>.from(_allUsers)..shuffle()).getRange(0, 4).toList(),
    followedBySpeakers: List<User>.from(_allUsers)..shuffle(),
    others: List<User>.from(_allUsers)..shuffle(),
  ),
  Room(
    club: 'NYU girls roasting tech guys',
    name: 'love and bitcoin edition 💰',
    speakers: (List<User>.from(_allUsers)..shuffle()).getRange(0, 4).toList(),
    followedBySpeakers: List<User>.from(_allUsers)..shuffle(),
    others: List<User>.from(_allUsers)..shuffle(),
  ),
];
