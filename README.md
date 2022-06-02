# odin-linked-list

This is my implementation of a Linked List type in Ruby, made for the The Odin Project online course.

The class has the following methods:

## #append(value)
Adds the given value as trailing to the list. Returns self.

## #prepend(value)
Adds the given value as leading to the list. Returns self.

## #insert_at(idx, *values)
Inserts the given value before the existing element at the specified index. Returns self.

If index is out of bounds, extends the list.

If index is negative, adds the given value after the elements at the specified index.

Accepts multiple arguments.

## #remove_at(idx)
Removes the Node at the given index. Returns the deleted node.

## #concat(linked_list)
Appends the given linked list. Returns self.

## #size
Returns the number of nodes in the list.

## #head
Returns the leading node.

## #tail
Returns the trailing node.

## #at(idx)
Returns the node at the given index.

## #pop
Removes and returns the trailing node.

## #contains?(value)
Returns true if the linked list contains a node with the given value and false otherwise.

## #find(value)
Returns the index of the node with the given value if there is one and nil otherwise.

## #to_s
Returns a string representation of the list according to the schema:
( head.value ) -> (next_node.value) ... -> ( tail.value ) -> nil

## #each
Enumerates through each node with the given block. If no block was given, returns an Enumerator.