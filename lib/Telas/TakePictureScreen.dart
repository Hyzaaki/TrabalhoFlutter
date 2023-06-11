import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class TakePictureScreen extends StatefulWidget {
  TakePictureScreen({Key? key, required this.lerImagem}) : super(key: key);

  final Function(XFile stateImagem) lerImagem;
  @override
  TakePictureScreenState createState() => TakePictureScreenState();
}

class TakePictureScreenState extends State<TakePictureScreen> {
  late CameraDescription camera;
  late CameraController cameraController;
  XFile? imagem;
  Size? size;

  @override
  void initState() {
    super.initState();
    _loadCameras();
  }

  _loadCameras() async {
    try{
      var cameras = await availableCameras();
      camera = cameras.first;
      print('camera.toString()');
      print(cameras.length);
      print(camera.toString());
      _previewCamera(camera);
    }
    catch(ex){
      print(ex);
    }
  }

  _previewCamera(CameraDescription ca) async {
    var _cameraController = new CameraController(ca, ResolutionPreset.high, enableAudio: false, imageFormatGroup: ImageFormatGroup.jpeg);

    try{
      await _cameraController.initialize();
    }
    catch(ex ){
      print('error');
      print(ex);
    }

    if(mounted) {
      setState(() {
        cameraController = _cameraController;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(title: const Text('Camera'), backgroundColor: Colors.grey[900],),
      body: Container(
        color: Colors.grey[900],
        child: Center(
          child: _arquivoWidget(),
        ),
      ),
      floatingActionButton:
      (imagem != null)
          ? FloatingActionButton.extended(onPressed: _onPressedFinalizar, label: Text('Finalizar'),)
          : null,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  _onPressedFinalizar(){
    widget.lerImagem(imagem!);
    Navigator.pop(context);
  }

  _arquivoWidget(){
    return Container(
      width: size!.width -50,
      height: size!.height - (size!.height/3),
      child:
        imagem == null
        ? _cameraPreviewWidget()
        : Image.file(File(imagem!.path), fit: BoxFit.contain),
    );
  }

  _cameraPreviewWidget(){
    print('aaaaaaa _cameraPreviewWidget');
    print(cameraController.cameraId);
    print(cameraController == null);
    print(cameraController.value.isInitialized);
    final CameraController? _cameraController = cameraController;
    if(_cameraController == null || !_cameraController.value.isInitialized){
      return Text('Camera nao inizializada');
    }
    else{
      return Stack(
        alignment: AlignmentDirectional.bottomCenter,
        children: [
          CameraPreview(cameraController),
          _botaoCapturaWidget(),
        ],
      ); 
    }
  }

  _botaoCapturaWidget(){
    print('11aquias3');
    return Padding(
      padding: EdgeInsets.only(bottom: 24),
      child: CircleAvatar(
        radius: 32,
        backgroundColor: Colors.black.withOpacity(0.5),
        child: IconButton(
          icon: Icon(Icons.camera_alt, color: Colors.white, size: 30,),
          onPressed: tirarFoto,
        ),
      ),
    );
  }

  tirarFoto() async{
    print('aquias3');
    final CameraController? _cameraController = cameraController;
    if(_cameraController == null || !_cameraController.value.isInitialized){
      print('tirarFoto nao inicializado');
    }
    else{
      try {
        XFile file = await _cameraController.takePicture();
        if (mounted) {
          setState(() {
            imagem = file;
          });
        }
      }
      catch(ex){
        print(ex);
      }
    }
  }
}