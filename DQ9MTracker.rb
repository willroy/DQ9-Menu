#!/usr/bin/env ruby
require 'curses'
include Curses

class CursesStuff 
  def initialize(scrn)
    @scrn = scrn
    @mitems = {"0" => "Money Management", "1" => "Option 2", "2" => "Option 3"}
    @select = 0
    @count = 0
  end
  def put
    @scrn.setpos(3+@count, 3)
    @count += 1
  end
  def get
    return @scrn.getstr()
  end
  def getchar
    return @scrn.getch()
  end
  def revertpos
    @count = 0
  end
  def attrsett(k)
    @scrn.attrset(k == @select? A_STANDOUT : A_NORMAL)
  end
end

class CursesMenu 
  def initialize(curses)
    @mitems = {"0" => "Money Management", "1" => "Option 2", "2" => "Option 3"}
    @select = 0
    @count = 0
    @enter = false
    @c = curses
  end
  def menuloop
    while true
      @enter = false
      scroll
      printmenu
      return @select if @enter == true
    end
  end
  def printmenu
    @c.revertpos()
    @mitems.each do |k, v|
      @c.attrsett(k)
      @c.put 
    end
  end
  def scroll
    case @c.getchar()
      when "w" 
        @select -= 1 unless @select == 0
      when "s" 
        @select += 1 unless @select == 2
      when "x" 
        @enter == true 
      when "q"
        abort
    end
  end
end

class Money_Management
  def initialize(curses)
    @curses = curses
    @ary = Array.new
  end
  def addamounts
    total = 0
    @ary.each {|i| total += i}
    total
  end
  def askamounts
    put "Add amounts and then type Q to quit"
    while true
      put "Type Then enter"
      input = get 
      @ary.push(input.to_i()) unless input == "Q"
      break if input == "Q"
    end
  end
end
scrn = Window.new(30, 50, 5, 2)
scrn.box("|", "~")
curses = CursesStuff.new(scrn)
menu = CursesMenu.new(curses)
money = Money_Management.new(curses)
while true
  choice = menu.menuloop()
  money.askamounts if choice == "0"
end
