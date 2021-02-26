import 'dart:math';

import 'package:flutter/material.dart';
import 'package:foodietinder/particle_model/particle_model.dart';
import 'package:foodietinder/particle_model/particle_painter.dart';
import 'package:simple_animations/simple_animations.dart';

class Particles extends StatefulWidget {
  final int numberOfParticles;

  Particles(this.numberOfParticles);

  @override
  _ParticlesState createState() => _ParticlesState();
}

class _ParticlesState extends State<Particles> {
  final Random random = Random();

  final List<ParticleModel> particles = [];

  final List<Paint> paints = [
    Paint()..color = Color.fromARGB(255, 98, 156, 44).withAlpha(130),
    Paint()..color = Color.fromARGB(255, 155, 184, 36).withAlpha(130),
    Paint()..color = Color.fromARGB(255, 18, 81, 30).withAlpha(130),
    Paint()..color = Color.fromARGB(255, 234, 206, 51).withAlpha(130),
    Paint()..color = Color.fromARGB(255, 26, 144, 47).withAlpha(130),
  ];

  @override
  void initState() {
    List.generate(widget.numberOfParticles, (index) {
      particles
          .add(ParticleModel(random, paints[random.nextInt(paints.length)]));
    });
    super.initState();
  }

  Widget _buildImage() {
    return Rendering(
      startTime: Duration(seconds: 30),
      onTick: _simulateParticles,
      builder: (context, time) {
        return CustomPaint(
          painter: ParticlePainter(particles, time),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return _buildImage();
  }

  _simulateParticles(Duration time) {
    particles.forEach((particle) => particle.maintainRestart(time));
  }
}
