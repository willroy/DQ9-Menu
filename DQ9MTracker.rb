#!/usr/bin/env ruby
require 'curses'

class CursesStuff
  def initialize
    @scrn = window.new(7, 40, 7, 2)
    @scrn.box("|", "~")
    @mitems = {"0" => "Money Management", "1" => "Option 2", "2" => "Option 3"}
    @select = 0
    @count = 0
  end
  def put
    $scrn.pos(3+count, 3)
    count += 1
  end
  def revertpos
    @count = 0
  end
  def printmenu()
    revertpos()
    mitems.each do |k, v|
      @scrn.attrset(k == postition? A_STANDOUT : A_NORMAL)
      @scrn.addstr "item_#{i}"
    end
  end
  def scroll
    case char
      when "w" position -= 1 unless @postion = 0
      when "s" position += 1 unless @postion = 2
    end
  end
end

class Money_Management
  def addamounts(ary)
    total = 0
    ary.each {|i| total += i}
    total
  end
  def askamounts
    puts "Add amounts and then type Q to quit"
    ary = Array.new
    while true
      print "=> "
      input = gets.chomp
      ary.push(input.to_i()) unless input == "Q"
      break if input == "Q"
    end
    ary
  end 
end

money = Money_Management.new()
ary = askamounts()
puts addamounts(ary)
