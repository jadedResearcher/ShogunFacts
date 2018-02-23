import 'dart:html';
import 'dart:async';
import 'package:RenderingLib/RendereringLib.dart';


Element output;
TextAreaElement textAreaElement;

List<String> fontList = <String>["Times New Roman","Lucida Console","Courier New","Verdana","Arial","Strife","Georgia","Comic Sans MS","Impact","Trebuchet MS","Tahoma","Lucida Sans Unicode"];
int count = 0;
int maxCount = 113;
void main() {
  output = querySelector('#output');
  mainLoop();
}

Future<Null> mainLoop() async {
  Random rand = new Random();
  await makeImage(output, randomDennisFact(), rand.pickFrom(fontList));
  count ++;
  if(count < maxCount)     new Timer(new Duration(milliseconds: 100), () => mainLoop());
}



void dennis() {
  String sentence = textAreaElement.value;
  Element div = new DivElement();
  div.text = "${randomDennisFact()}";
  output.append(div);
}

String randomDennisFact() {
  Random rand = new Random();
  List<String> _animals = <String>["dennis"];
  List<String> _bodyParts = <String>["sporty frock coat","frock coat","head","muscles","arms","brain","legs","feet","hands","eyes","jimberjam","jimberjam","jimberjam","ye flask","trinket","parapet","nice jimberjam"];
  List<String> _numbers = <String>["one","two","three","four","five","six","seven","eight","nine"];
  List<String> _unitsOfTime = <String>["second","minute","hour","day"];
  List<String> _unitsOfSpace = <String>["inch","foot"];
  List<String> _unitsOfSpacePlural = <String>["inches","feet"];

  List<String> _adjatives = <String>["huge","surprisingly tiny","fragrant","magical","lustful","delicious","aesthetically pleasing","the subject of many documentaries","rapturous","musical","slender","thick","thicc","heavy","musky","pungent","soft","hard","silky"];

  List<String> _actions = <String>["pace","fight","gigglesnort","pace about nervously","mate","laugh","squeal","chitter","growl"];
  List<String> _fakeAlts = <String>["foot","sensory organ","mouth","weapon","tongue"];

  List<String> _shapes = <String>["corkscrew","spiral","triangle","perfect cyllinder","square","helix"];
  List<String> _nouns = <String>["computers","cars","statues","town houses","apples","irony","doritos"];
  _nouns.addAll(_animals);
  _nouns.addAll(_bodyParts);


  String animal = rand.pickFrom(_animals);
  String adj = rand.pickFrom(_adjatives);

  String bodyPart = rand.pickFrom(_bodyParts);
  String fakeAlt = rand.pickFrom(_fakeAlts);


  String action = rand.pickFrom(_actions);
  String noun = rand.pickFrom(_nouns);
  String shape = rand.pickFrom(_shapes);



  String unitOfSpace = rand.pickFrom(_unitsOfSpace);

  String number = rand.pickFrom(_numbers);
  String unitOfTime = rand.pickFrom(_unitsOfTime);
  String bodyPartPlural = bodyPart;

  if(number != "one") {
    bodyPartPlural = "${bodyPart}s";
    unitOfSpace = rand.pickFrom(_unitsOfSpacePlural);
    unitOfTime = "${unitOfTime}s";

  }

//almost all species of JR gigglesnort when they taunt shoguns
  List<String> ret = <String>["$animal has a record $bodyPart length of $number $unitOfSpace ","$animal has something that looks like a $bodyPart but it's actually a $fakeAlt","$animal yells so loud you can hear it for miles","$animal nervously paces $number times a ${rand.pickFrom(_unitsOfTime)}","$animal has a prehensile $bodyPart","$animal $bodyPart explodes at the end of pacing","scientists have yet to record $animal pacing on film","scientists are testing how $animal paces nervously in space","$animal doesn't have ${bodyPart}s","$animal paces every other year","$animal pacing lasts $number $unitOfTime","$animal nervously pacing lasts $number $unitOfTime","$animal can have $bodyPart $number times a $unitOfTime","$animal are only active for a $number $unitOfTime window a year","$animal has a bone in their $bodyPart","nearly all manifestations of $animal are nervous","$animal invented a simple economy simply to get $bodyPartPlural","$animal pacing is said to be $adj","$animal gains one $bodyPart for every year of life","$animal will die after pacing $number times","$animal is nervously attracted to $noun","$animal showing a nervous $bodyPart is a sign of submission","$animal collects flasks of $number small $bodyPartPlural when it is time to pace","$animal can pace with $number $bodyPartPlural at once","$animal has a $adj $bodyPart","$animal can die if they don't get $bodyPart","$animal can control every single muscle of their $bodyPart ","$animal can pace $number $unitOfSpace into the air","$animal can wear $bodyPartPlural","$animal has a $number $unitOfSpace $bodyPart", "almost all manifestations of $animal $action when they see $noun ","$animal has $number ${bodyPartPlural}", "$animal thinks of pacing $number times a $unitOfTime", "$animal has a $shape $bodyPart","$animal is a place", "$animal has a nice $bodyPart"];
    ret.addAll(<String>["$animal has a strength over ${number} thousand"]);

  return rand.pickFrom(ret);

}

int convertSentenceToNumber(String sentence) {
  print("converting sentence ${sentence}");
  int ret = 0;
  for(int s in sentence.codeUnits) {
    print ("code unit ${new String.fromCharCode(s)}");
    ret += s;
  }
  return ret;
}

Future<Null> drawRandomPartOfRandomImage(CanvasElement canvas, Random rand, int subSetWidth) async {
    int minNum = 1;
    int maxNum = 13;
    String randomImageName = "images/${rand.nextInt(13)+minNum}.jpg";

    ImageElement image = await Loader.getResource((randomImageName));
    //print("got image $image");
    canvas.context2D.imageSmoothingEnabled = false;

    int startXMin = 0;
    int startXMax = image.width -subSetWidth;
    //canvas.context2D.drawImage(image, 0, 0);
    canvas.context2D.drawImageToRect(image,new Rectangle(0,0,canvas.width,canvas.height), sourceRect: new Rectangle(rand.nextInt(startXMax),0,subSetWidth,image.height));

}


Future<Null> makeImage(Element div, String s, String font) async {
  int height = 333;
  int width = 130;
  CanvasElement canvas = new CanvasElement(width: width, height: height);
  Random rand = new Random();
  //canvas.context2D.setFillColorRgb(rand.nextInt(255), rand.nextInt(255), rand.nextInt(255));
  if(rand.nextDouble() <.87) { //13 % are solid color isntead of image
      await drawRandomPartOfRandomImage(canvas, rand,130);
  }else {
      canvas.context2D.setFillColorRgb(rand.nextInt(255), rand.nextInt(255), rand.nextInt(255));
      canvas.context2D.fillRect(0, 0, width, height);
  }
  canvas.context2D.setFillColorRgb(rand.nextInt(255), rand.nextInt(255), rand.nextInt(255));
  int fontsize = 48;
  canvas.context2D.font = "${fontsize}px $font";

  int buffer = 10;
  int bufferY = 10;
  Renderer.wrapTextAndResizeIfNeeded(canvas.context2D, s, font, 10, 30, fontsize, width-buffer, height-bufferY);
  output.append(canvas);

}

//first, make sure no line will go off screen width
//second, make sure all lines don't go off screen height
//canvas.context2D, s, font, 10, 30, fontsize, width-buffer, height-bufferY
int wrapTextAndResizeIfNeeded(CanvasRenderingContext2D ctx, String text, String font, num x, num y, num fontSize, int maxWidth, int maxHeight) {
    List<String> words = text.split(' ');
    WordWrapMetaData data = wrapLoop(words, ctx, maxWidth);
    //loop to keep within width. no easy calc for this, i THINK
    while(data.largestLine > maxWidth) {
        //print("Biggest line is ${data.largestLine} but can't be bigger than ${maxWidth}");
        fontSize = fontSize - 1.0;
        data.ctx.font = "${fontSize}px $font"; //since the data's context is what matters, make sure you use it
    }

    //take care of keeping in height
    if((data.lines.length * fontSize)>maxHeight) {
        int size = (maxHeight/data.lines.length).floor();
        ctx.font = "${size}px $font";
        fontSize = size;
    }

    num offsetY = 0.0;
    num offsetX = 0;
    if ( ctx.textAlign == 'center') offsetX = maxWidth ~/ 2;
    for (int i = 0; i < data.lines.length; i++) {
        ctx.fillText(data.lines[i], x + offsetX, y + offsetY);
        offsetY = offsetY + fontSize;
    }
    return data.lines.length;
}





 int simulateWrapTextToGetFontSize(CanvasRenderingContext2D ctx, String text, num x, num y, num lineHeight, int maxWidth, int maxHeight) {
    List<String> words = text.split(' ');
    List<String> lines = <String>[];
    int sliceFrom = 0;
    for (int i = 0; i < words.length; i++) {
        String chunk = words.sublist(sliceFrom, i).join(' ');
        bool last = i == words.length - 1;
        bool bigger = ctx
            .measureText(chunk)
            .width > maxWidth;
        if (bigger) {
            lines.add(words.sublist(sliceFrom, i).join(' '));
            sliceFrom = i;
        }
        if (last) {
            lines.add(words.sublist(sliceFrom, words.length).join(' '));
            sliceFrom = i;
        }
    }
    //need to return how many lines i created so that whatever called me knows where to put ITS next line.;
    return lines.length;

}

int wrap_text_and_fit_in_height(CanvasRenderingContext2D ctx, String font,String text, num x, num y, num lineHeight, int maxWidth, int maxHeight, String textAlign) {
    int numLines = simulateWrapTextToGetFontSize(ctx,text,x,y,lineHeight,maxWidth, maxHeight);
    if((numLines * lineHeight)>maxHeight) {
        int size = (maxHeight/numLines).floor();
        ctx.font = "${size}px $font";
        lineHeight = size;
    }
    return wrap_text(ctx, text, x, y, lineHeight, maxWidth, textAlign);
}



WordWrapMetaData wrapLoop(List<String> words, CanvasRenderingContext2D ctx, int maxWidth) {
    List<String> lines = new List<String>();
    int sliceFrom = 0;
    for (int i = 0; i < words.length; i++) {
          String chunk = words.sublist(sliceFrom, i).join(' ');
          bool last = i == words.length - 1;
          if (ctx.measureText(chunk).width > maxWidth) {
              lines.add(words.sublist(sliceFrom, i).join(' '));
              sliceFrom = i;
          }
          if (last) {
              lines.add(words.sublist(sliceFrom, words.length).join(' '));
              sliceFrom = i;
          }
    }
    return new WordWrapMetaData(lines, ctx);
}


//http://stackoverflow.com/questions/5026961/html5-canvas-ctx-filltext-wont-do-line-breaks
 int wrap_text(CanvasRenderingContext2D ctx, String text, num x, num y, num lineHeight, int maxWidth, String textAlign) {
    if (textAlign == null) textAlign = 'center';
    ctx.textAlign = textAlign;
    List<String> words = text.split(' ');
    List<String> lines = <String>[];
    int sliceFrom = 0;
    for (int i = 0; i < words.length; i++) {
    String chunk = words.sublist(sliceFrom, i).join(' ');
    bool last = i == words.length - 1;
    bool bigger = ctx.measureText(chunk).width > maxWidth;
    if (bigger) {
        lines.add(words.sublist(sliceFrom, i).join(' '));
        sliceFrom = i;
    }
    if (last) {
    lines.add(words.sublist(sliceFrom, words.length).join(' '));
    sliceFrom = i;
    }
    }
    num offsetY = 0.0;
    num offsetX = 0;
    if (textAlign == 'center') offsetX = maxWidth ~/ 2;
    for (int i = 0; i < lines.length; i++) {
    ctx.fillText(lines[i], x + offsetX, y + offsetY);
    offsetY = offsetY + lineHeight;
    }
    //need to return how many lines i created so that whatever called me knows where to put ITS next line.;
    return lines.length;
}





class Size2D {
  int width;
  int height;

  Size2D(int this.width, int this.height);

}

class WordWrapMetaData {
    List<String> lines;
    CanvasRenderingContext2D ctx;

    WordWrapMetaData(this.lines, this.ctx) {
        //print("made word wrap meta data with ${lines.length} lines");
    }

    num get largestLine {
        num biggestWidth = 0.0;
        for(String line in lines) {
            num size = ctx.measureText(line).width;
            if(size > biggestWidth) biggestWidth = size;
        }

        return biggestWidth;

    }
}