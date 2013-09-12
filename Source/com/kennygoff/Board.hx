package com.kennygoff;

import flash.display.Sprite;
import flash.events.MouseEvent;

class Board extends Sprite
{
  var cells : Array<Array<Cell>>;
  var columns : Int;
  var rows : Int;
  var cellSize : Int;
  var cellPadding : Int;

  public function new(?x:Int, ?y:Int, ?columns:Int, ?rows:Int, ?cellSize:Int, ?cellPadding:Int)
  {
    super();

    this.x = (x == null)? 0 : x;
    this.y = (y == null)? 0 : y;
    this.columns = (columns == null)? 0 : columns;
    this.rows = (rows == null)? 0 : rows;
    this.cellSize = (cellSize == null)? 80 : cellSize;
    this.cellPadding = (cellPadding == null)? 10 : cellPadding;

    var width = (cellSize + cellPadding) * columns + cellPadding;
    var height = (cellSize + cellPadding) * rows + cellPadding;

    this.graphics.beginFill(0xFFFFFF, 0);
    this.graphics.drawRect(0, 0, width, height);
    this.graphics.endFill();

    this.width = width;
    this.height = height;

    this._initBoard(this.columns, this.rows, this.cellSize, this.cellPadding);

    this.addEventListener(MouseEvent.MOUSE_DOWN, _mouseDown);
    this.mouseChildren = false;
  }

  public function draw()
  {
    this.graphics.beginFill(0xFFFFFF, 1);
    this.graphics.drawRect(0, 0, this.width, this.height);
    this.graphics.endFill();

    for(col in this.cells)
    {
      for(cell in col)
      {
        cell.draw();
      }
    }
  }

  private function _initBoard(columns:Int, rows:Int, cellSize:Int, cellPadding:Int)
  {
    cells = new Array<Array<Cell>>();
    for(c in 0...columns)
    {
      var tmpArr = new Array<Cell>();
      for(r in 0...rows)
      {
        var cell = new Cell(
          (cellSize + cellPadding) * c + cellPadding,
          (cellSize + cellPadding) * r + cellPadding,
          cellSize,
          cellSize);
        tmpArr.push(cell);
        this.addChild(cell);
      }
      cells.push(tmpArr);
    }
  }

  public function onMouseUp(e:MouseEvent)
  {
    trace(e.localX, e.localY);
    var x = Math.floor(e.localX);
    var y = Math.floor(e.localY);

    var cell = getCellFromCoordinates(x, y);

    if (cell != null) {
      trace(cell);
      triggerCell(cell[0], cell[1]);
      draw();
    }
  }

  public function triggerCell(c:Int, r:Int)
  {
    cells[c][r].toggleState();
    if(r - 1 >= 0) cells[c][r - 1].toggleState();
    if(c + 1 < cells.length) cells[c + 1][r].toggleState();
    if(r + 1 < cells[c].length) cells[c][r + 1].toggleState();
    if(c - 1 >= 0) cells[c - 1][r].toggleState();
  }

  public function getCellFromCoordinates(x:Int, y:Int)
  {
    trace(x, y);
    var tile = this.cellSize + this.cellPadding;

    if (x > tile * this.columns) return null;
    if (y > tile * this.rows) return null;

    if (x % tile > this.cellPadding && y % tile > this.cellPadding) {
      return [Math.floor(x / tile), Math.floor(y / tile)];
    } else {
      return null;
    }
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