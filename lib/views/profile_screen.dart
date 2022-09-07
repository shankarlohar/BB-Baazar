import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            elevation: 0,
            backgroundColor: Colors.white,
            expandedHeight: 140,
            flexibleSpace: LayoutBuilder(
              builder: (context, constraints) {
                return FlexibleSpaceBar(
                  title: AnimatedOpacity(
                    opacity: constraints.biggest.height <= 120 ? 1 : 0,
                    duration: Duration(
                      microseconds: 300,
                    ),
                    child: Text(
                      "Account",
                    ),
                  ),
                  background: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.red,
                          Colors.redAccent,
                        ],
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(25.0),
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 50,
                            backgroundImage:
                                AssetImage('assets/images/app_logo/image.jpg'),
                          ),
                          SizedBox(
                            width: 25,
                          ),
                          Text(
                            "Guest",
                            style: TextStyle(
                              fontSize: 25,
                              color: Colors.white,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          SliverToBoxAdapter(
            child: Column(
              children: [
                Container(
                  height: 80,
                  width: MediaQuery.of(context).size.width * 0.9,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(
                      50,
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.red.shade100,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(
                              25,
                            ),
                            bottomLeft: Radius.circular(
                              25,
                            ),
                          ),
                        ),
                        child: TextButton(
                          onPressed: () {},
                          child: SizedBox(
                            height: 40,
                            width: MediaQuery.of(context).size.width * 0.2,
                            child: Center(
                              child: Text(
                                "Cart",
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.red.shade100,
                        ),
                        child: TextButton(
                          onPressed: () {},
                          child: SizedBox(
                            height: 40,
                            width: MediaQuery.of(context).size.width * 0.2,
                            child: Center(
                              child: Text(
                                "Order",
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.red.shade100,
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(
                              25,
                            ),
                            bottomRight: Radius.circular(
                              25,
                            ),
                          ),
                        ),
                        child: TextButton(
                          onPressed: () {},
                          child: SizedBox(
                            height: 40,
                            width: MediaQuery.of(context).size.width * 0.2,
                            child: Center(
                              child: Text(
                                "Wish List",
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                RepeatedDividor(
                  title: "Accunt Info",
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    height: 300,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(
                        20,
                      ),
                    ),
                    child: Column(
                      children: [
                        RepeatedListTile(
                          title: "Email Address",
                          subtitle: "shankarloharmail@gmail.com",
                          leading: Icons.email,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Divider(
                            color: Colors.grey,
                            thickness: 1,
                          ),
                        ),
                        RepeatedListTile(
                          title: "Phone number",
                          subtitle: "+91 9831159686",
                          leading: Icons.phone,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Divider(
                            color: Colors.grey,
                            thickness: 1,
                          ),
                        ),
                        RepeatedListTile(
                          title: "Address",
                          subtitle: "Cossipore, Kolkata, 700002",
                          leading: Icons.location_pin,
                        ),
                      ],
                    ),
                  ),
                ),
                RepeatedDividor(
                  title: "Account Settings",
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    height: 300,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(
                        20,
                      ),
                    ),
                    child: Column(
                      children: [
                        RepeatedListTile(
                          title: "Edit Profile",
                          subtitle: "",
                          leading: Icons.edit,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Divider(
                            color: Colors.grey,
                            thickness: 1,
                          ),
                        ),
                        RepeatedListTile(
                          title: "Change Password",
                          subtitle: "",
                          leading: Icons.lock,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Divider(
                            color: Colors.grey,
                            thickness: 1,
                          ),
                        ),
                        RepeatedListTile(
                          title: "Logout",
                          subtitle: "",
                          leading: Icons.logout,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class RepeatedListTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData leading;
  const RepeatedListTile({
    required this.title,
    required this.subtitle,
    required this.leading,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      subtitle: Text(
        subtitle,
      ),
      leading: Icon(
        leading,
        color: Colors.red,
      ),
    );
  }
}

class RepeatedDividor extends StatelessWidget {
  final String title;
  const RepeatedDividor({
    required this.title,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          height: 40,
          width: 50,
          child: Divider(
            color: Colors.black,
            thickness: 1,
          ),
        ),
        Text(
          title,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w700,
            color: Colors.black,
          ),
        ),
        SizedBox(
          height: 40,
          width: 50,
          child: Divider(
            color: Colors.black,
            thickness: 1,
          ),
        ),
      ],
    );
  }
}