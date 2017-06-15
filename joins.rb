#!/usr/bin/ruby
require 'ruby-prof'

def arr_generator(num, len)
  1.upto(len).map {|i| rand(num)}
end

sz = 10
arr_1 = arr_generator(10000, sz)
arr_2 = arr_generator(10000, sz)

def merge_join(arr_1, arr_2)
  result = []
  sorted_left = arr_1.sort
  sorted_right = arr_2.sort
  left_i = 0
  right_i = 0
  while (left_i < sorted_left.size) || (right_i < sorted_right.size)
    left = sorted_left[left_i]
    right = sorted_right[right_i]
    break if left.nil? || right.nil?
    if left == right
      result.push(sorted_left[left_i])
      left_i = left_i + 1
      right_i = right_i + 1
    elsif left > right
      right_i = right_i + 1
    elsif left < right
      left_i = left_i + 1
    end
  end
  result
end


def nested_loop(arr_1, arr_2)
  result = []
  arr_1.each do |i|
    arr_2.each do |j|
      result.push(i) if i == j
    end
  end
  result
end


RubyProf.start
merge_join(arr_1, arr_2)
result = RubyProf.stop
printer = RubyProf::FlatPrinter.new(result)
printer.print(STDOUT)

RubyProf.start
nested_loop(arr_1, arr_2)
result = RubyProf.stop
printer = RubyProf::FlatPrinter.new(result)
printer.print(STDOUT)

