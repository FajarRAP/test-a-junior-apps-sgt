import 'dart:ui';

import 'package:flutter/material.dart';

import 'widgets/info_card.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Positioned.fill(
            child: Image.asset(
              'assets/images/background.png',
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            top: 100,
            left: 0,
            right: 0,
            child: Column(
              children: [
                Text(
                  'Montreal',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 34,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                Text(
                  '19°',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 96,
                    fontWeight: FontWeight.w200,
                  ),
                ),
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    text: 'Mostly Clear\n',
                    style: const TextStyle(
                      color: Color(0x99EBEBF5),
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                    children: <InlineSpan>[
                      TextSpan(
                        text: 'H:22°C ',
                        style: const TextStyle(color: Colors.white),
                      ),
                      TextSpan(
                        text: 'L:18°C',
                        style: const TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                Image.asset('assets/images/house.png'),
              ],
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: ClipRRect(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(32),
              ),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(32),
                    ),
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      colors: <Color>[
                        Color(0xFF2E335A),
                        Color(0xFF1C1B33),
                      ],
                      end: Alignment.bottomRight,
                      stops: [-0.0468, 0.9545],
                    ).withOpacity(.2),
                  ),
                  height: 350,
                  child: DefaultTabController(
                    initialIndex: 0,
                    length: 2,
                    child: Column(
                      children: <Widget>[
                        TabBar(
                          dividerColor: Colors.transparent,
                          indicatorAnimation: TabIndicatorAnimation.elastic,
                          tabs: <Widget>[
                            Tab(
                              icon: Text(
                                'Hourly Forecast',
                                style: const TextStyle(
                                  color: Color(0x99EBEBF5),
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            Tab(
                              icon: Text(
                                'Weekly Forecast',
                                style: const TextStyle(
                                  color: Color(0x99EBEBF5),
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 24),
                        SizedBox(
                          height: 160,
                          child: TabBarView(
                            children: <Widget>[
                              ListView.separated(
                                itemBuilder: (context, index) => InfoCard(),
                                separatorBuilder: (context, index) =>
                                    const SizedBox(width: 12),
                                itemCount: 7,
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                scrollDirection: Axis.horizontal,
                              ),
                              ListView.separated(
                                itemBuilder: (context, index) => InfoCard(),
                                separatorBuilder: (context, index) =>
                                    const SizedBox(width: 12),
                                itemCount: 7,
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                scrollDirection: Axis.horizontal,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
