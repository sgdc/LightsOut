package com.kennygoff;

import flash.display.Sprite;

class LightsOut extends Sprite
{
  public function new()
  {	
    super();

    var board = new Board(0, 0, 5, 5, 80, 10);
    addChild(board);
    board.draw();
  }
}