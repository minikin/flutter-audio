import 'package:audio/src/app/widgets/waveform_item.dart';
import 'package:audio/src/services/models/tune.dart';
import 'package:audio/src/services/models/waveform.dart';
import 'package:flutter/material.dart';

class PlayerItem extends StatelessWidget {
  final Tune tune;
  final Waveform waveform;

  const PlayerItem({
    @required this.tune,
    @required this.waveform,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(8, 8, 8, 8),
      width: double.infinity,
      height: 300,
      child: Stack(
        children: [
          Image.asset(
            tune.artwork,
            fit: BoxFit.cover,
            height: 300,
            width: double.infinity,
            color: Colors.black38,
            colorBlendMode: BlendMode.hardLight,
          ),
          Positioned(
            top: 0,
            child: Container(
              width: 330,
              child: Row(
                children: [
                  _playButtom(),
                  Container(
                    width: 230,
                    child: Column(
                      children: [
                        Container(
                          height: 30,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                child: Text(
                                  tune.artist,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 24,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                              _actionButtom(icon: Icon(Icons.cloud_download)),
                            ],
                          ),
                        ),
                        Container(
                          height: 30,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Expanded(
                                child: Text(
                                  tune.title,
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.grey[300],
                                  ),
                                ),
                              ),
                              _actionButtom(icon: Icon(Icons.share)),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: -45,
            left: 8,
            right: 8,
            child: WaveFormItem(waveform: waveform),
          ),
        ],
      ),
    );
  }

  Widget _playButtom() {
    return Center(
      child: Container(
        child: IconButton(
          iconSize: 80,
          icon: Icon(Icons.play_circle_filled),
          color: Colors.orange,
          onPressed: () {
            print('filled background');
          },
        ),
      ),
    );
  }

  Widget _actionButtom({
    @required Icon icon,
  }) {
    return Center(
      child: Container(
        child: Ink(
          decoration: ShapeDecoration(
            color: Colors.orange,
            shape: CircleBorder(),
          ),
          child: IconButton(
            icon: icon,
            color: Colors.orange,
            onPressed: () {
              print('filled background');
            },
          ),
        ),
      ),
    );
  }
}
