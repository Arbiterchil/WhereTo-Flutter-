
import 'package:WhereTo/ATrial/animation_clip.dart';
import 'package:flutter/material.dart';

class AnimationWaveTrial extends StatefulWidget {
  @override
  _AnimationWaveTrialState createState() => _AnimationWaveTrialState();
}

class _AnimationWaveTrialState extends State<AnimationWaveTrial>
  with SingleTickerProviderStateMixin
 {

   Animation<double> animation;
   AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(seconds: 3),
      vsync: this)..repeat();
    animation = Tween<double>(begin: -500,end: 0 ).animate(_controller);
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return  AnimationClip(
      animation
    );
  }
}