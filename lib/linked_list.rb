# frozen_string_literal: true

# this class contains all methods related to managing a list of related nodes
class LinkedList
  attr_reader :nodes

  def initialize(*args)
    @nodes = []
    args.each do |arg|
      if arg.is_a?(Array)
        arg.each do |arg_element|
          append(arg_element)
        end
      else
        append(arg)
      end
    end
  end

  def append(value)
    @nodes << Node.new(value)
    # Make sure the node we just added gets added to the previous node's next_node field.
    @nodes[-2] ? @nodes[-2].next_node = @nodes[-1] : return
    return self
  end

  def prepend(value)
    @nodes.prepend(Node.new(value, @nodes[0]))
    return self
  end

  def insert_at(idx, *values)
    # if we split the array, we can take care of out-of-bounds or negative indexes at this point
    first_half = LinkedList.new(@nodes[0..idx - 1].to_a.map(&:value))
    second_half = LinkedList.new(@nodes[idx..-1].to_a.map(&:value))
    first_half.append(second_half.nodes.shift.value) if idx.negative?

    # now we just need to append to the first half of the split array
    # would be nice to just make the halves linked lists as well, but i don't have a #concat yet
    values.each do |value|
      first_half.append(value)
      #first_half[-2] ? first_half[-2].next_node = first_half[-1] : next
    end

    # at the end, we just have to fix one next_node entry and concat
    #first_half[-1].next_node = second_half[0]
    @nodes = first_half.concat(second_half)

    return self
  end

  def remove_at(idx)
    deleted = @nodes.delete_at(idx)
    # gotta fix the next_node references after we remove the node
    @nodes[idx - 1] ? @nodes[idx - 1].next_node = @nodes[idx] : return
    return deleted
  end

  def concat(linked_list)
    tail.next_node = linked_list.head
    @nodes.concat(linked_list.nodes)
    return self
  end

  def size
    return @nodes.length
  end

  def head
    return @nodes[0]
  end

  def tail
    return @nodes[-1]
  end

  def at(idx)
    return nodes[idx]
  end

  def pop
    return @nodes.pop
  end

  def contains?(value)
    return @nodes.any? { |node| node.value == value }
  end

  def find(value)
    return @nodes.index { |node| node.value == value }
  end

  def to_s
    # this method doesn't really care about next_node relations
    # but i figure checking that isn't a #to_s's job
    string = ''
    @nodes.each do |node|
      string += "( #{node.value} ) -> "
    end
    string += 'nil'
    return string
  end

  # needed a way to iterate for some integrity checking later
  def each
    return @nodes.each unless block_given?

    @nodes.each do |node|
      yield node
    end
  end
end

# this class defines an object which can keep track of a value and
# one related object of the same type
class Node
  attr_accessor :next_node

  def initialize(value = nil, next_node = nil)
    @value = value
    @next_node = next_node
  end

  def value
    return @value
  end

  def to_s
    return "( #{value} ) -> #{next_node ? "( #{next_node.value} )" : 'nil'}"
  end
end


def integrity_check(linked_list)
  previous_node = Node.new(nil,linked_list.head)
  index = 0

  linked_list.each do |node|
    if previous_node.next_node.value != node.value
      puts "Chain broken at position #{index}!!"
      puts "Previous node's next node value was: #{previous_node.next_node.value}"
      puts "It should have been: #{node.value}"
      break
    end
    puts "Check complete" if node == linked_list.tail
    previous_node = node
    index += 1
  end
end

list = LinkedList.new(2, 3)

puts list
puts "Size: #{list.size}"
list.insert_at(3, 10, 12, 54)
puts list
puts "Size: #{list.size}"
puts "Tail: #{list.tail}"
puts "Head: #{list.head}"
puts "Sixth node : #{list.at(5)}"
puts "List contains 54? #{list.contains?(54)}"
puts "Popped tail: #{list.pop}"
puts "List contains 54? #{list.contains?(54)}"
puts "Index of 9: #{list.find(9)}"
puts "Index of 10: #{list.find(10)}"
puts list
puts "Remove third node:"
puts list.remove_at(2)

puts "Integrity check: "
integrity_check(list)

puts "Insert 22, 33 second to last: "
list.insert_at(-2, 22, 33)
puts list

puts "Integrity check: "
integrity_check(list)

puts "Insert 5, 8 in second place:"
list.insert_at(1, 5, 8)
puts list

puts "Integrity check: "
integrity_check(list)

