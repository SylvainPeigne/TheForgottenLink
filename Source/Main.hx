package;


import openfl.display.Sprite;
import flash.display.Bitmap;
import flash.events.MouseEvent;
import openfl.Assets;



class Main extends Sprite {
	
  private var game = new Array<Array<Int>>();
  private var cards = new Array<Array<Sprite>>();
	//var game = new Array<Int>();
  private var NB = 6;
  private var Gwidth:Int;
  private var Pair:Int;
  private var Saved:Array<Int>;
  
	public function new ()
  {
		super ();
		var nb:Int = 0;
    Gwidth = Std.int(Math.ceil(Math.sqrt(NB * 2)));
    Pair = 0;
    Saved = new Array<Int>();
    //trace("debug0");
    //game[0][0] = 0;
    //game[0] = 0;
    while (nb < NB * 2)
    {
      //trace("0");
      if (nb % Gwidth == 0)
      {
        //trace(nb);
        game[Std.int(nb / Gwidth)] = new Array<Int>();
        cards[Std.int(nb / Gwidth)] = new Array<Sprite>();
      }
      game[Std.int(nb / Gwidth)][nb % Gwidth] = 0;
      cards[Std.int(nb / Gwidth)][nb % Gwidth] = new Sprite();
      cards[Std.int(nb / Gwidth)][nb % Gwidth].addChild (new Bitmap (Assets.getBitmapData ("assets/card.png")));
      cards[Std.int(nb / Gwidth)][nb % Gwidth].y = Std.int(nb / Gwidth) * 100 + 150;
      //trace("[" + Std.int(nb / Gwidth) + "," + (nb % Gwidth) + "]");
      cards[Std.int(nb / Gwidth)][nb % Gwidth].x = nb % Gwidth * 100 + 150;
      cards[Std.int(nb / Gwidth)][nb % Gwidth].buttonMode = true;
  		addChild(cards[Std.int(nb / Gwidth)][nb % Gwidth]);
      
      cards[Std.int(nb / Gwidth)][nb % Gwidth].addEventListener (MouseEvent.MOUSE_DOWN, getCard);
      //trace("1");
      nb++;
      //trace("2");
    }
    
    //trace("debug1");
    nb = 0;
		while (nb < NB * 2)
    {
      //trace("1");
      game[Std.int(nb / Gwidth)][nb % Gwidth] = newRand(nb);
      nb++;
    }
    //trace("debug");
    //trace(game[0]);
    //trace(game[1]);
    //trace(game[2]);
	}
  private function newRand(nb:Int)
  {  
    while (true)
    {
      //trace("2");
      var tmp = Math.floor(Math.random() * NB) + 1;
      var x = 0;
      var bool = 0;
      while (x <= nb)
      {
        //trace(x);
        if (game[Std.int(x / Gwidth)][x % Gwidth] == tmp && bool == 0)
          bool = 1;
        else if (game[Std.int(x / Gwidth)][x % Gwidth] == tmp && bool == 1)
          break;
        else if (x == nb)
          return (tmp);
        x++;
      }
    }
    return(-1);
  }
  
  private function getCard(event:MouseEvent)
  {
    if (Pair == 0)
    {
      //trace("Pair = 0");
      Saved[0] = Std.int((event.stageY - 150) / 100);
      Saved[1] = Std.int((event.stageX - 150) / 100);
      Pair = 1;
      //trace("Pair set to " + Pair);
      removeChild(cards[Std.int((event.stageY - 150) / 100)][Std.int((event.stageX - 150) / 100)]);
      cards[Std.int((event.stageY - 150) / 100)][Std.int((event.stageX - 150) / 100)].addChild (new Bitmap (Assets.getBitmapData("assets/card(" + game[Std.int((event.stageY - 150) / 100)][Std.int((event.stageX - 150) / 100)] + ").png")));
      addChild(cards[Std.int((event.stageY - 150) / 100)][Std.int((event.stageX - 150) / 100)]);
    }
    else if (Pair == 1)
    {
      //trace("Pair = 1");
      removeChild(cards[Std.int((event.stageY - 150) / 100)][Std.int((event.stageX - 150) / 100)]);
      cards[Std.int((event.stageY - 150) / 100)][Std.int((event.stageX - 150) / 100)].addChild (new Bitmap (Assets.getBitmapData("assets/card(" + game[Std.int((event.stageY - 150) / 100)][Std.int((event.stageX - 150) / 100)] + ").png")));
      addChild(cards[Std.int((event.stageY - 150) / 100)][Std.int((event.stageX - 150) / 100)]);
      Saved[2] = Std.int((event.stageY - 150) / 100);
      Saved[3] = Std.int((event.stageX - 150) / 100);
      Pair = 2;
    }
    else if (Pair == 2)
    {
      if (game[Saved[0]][Saved[1]] == game[Saved[2]][Saved[3]])
      {
        //trace("chack !");
        removeChild(cards[Saved[2]][Saved[3]]);
        removeChild(cards[Saved[0]][Saved[1]]);
      }
      else
      {
        //trace("ko");
        cards[Saved[2]][Saved[3]].addChild (new Bitmap (Assets.getBitmapData ("assets/card.png")));
        cards[Saved[0]][Saved[1]].addChild (new Bitmap (Assets.getBitmapData ("assets/card.png")));
      }
      Pair = 0;
    }
  }
}