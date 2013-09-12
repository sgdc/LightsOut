package com.kennygoff;

import flash.display.Sprite;
import flash.events.MouseEvent;

class Cell extends Sprite
{
  private var active : Bool;

  public function new(?x:Int, ?y:Int, ?width:Int, ?height:Int)
  {
    super();

    this.active = false;
    this.x = (x == null)? 0 : x;
    this.y = (y == null)? 0 : y;
    width = (width == null)? 50 : width;
    height = (height == null)? 50 : height;

    this.graphics.beginFill(0x66b5ff, 1);
    this.graphics.drawRect(0, 0, width, height);
    this.graphics.endFill();

    this.width = width;
    this.height = height;

    //this.addEventListener(MouseEvent.MOUSE_DOWN, _mouseDown);
  }

  public function toggleState()
  {
    this.active = !this.active;
    this.draw();
  }

  public function draw()
  {
    this.graphics.beginFill((active)? 0xdd6797 : 0x66b5ff, 1);
    this.graphics.drawRect(0, 0, this.width, this.height);
    this.graphics.endFill();
  }

  public function onMouseUp(e:MouseEvent)
  {
    this.toggleState();
    this.draw();
  }

  private function _mouseDown(e:MouseEvent)
  {
    this.addEventListener(MouseEvent.MOUSE_UP, _mouseUp);
  }

  private function _mouseUp(e:MouseEvent)
  {
    onMouseUp(e);
    this.removeEventListener(MouseEvent.MOUSE_UP, _mouseUp);
  }
}