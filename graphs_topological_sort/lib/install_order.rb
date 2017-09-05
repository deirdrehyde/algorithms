# Given an Array of tuples, where tuple[0] represents a package id,
# and tuple[1] represents its dependency, determine the order in which
# the packages should be installed. Only packages that have dependencies
# will be listed, but all packages from 1..max_id exist.

# N.B. this is how `npm` works.

# Import any files you need to

require_relative 'graph'
require_relative 'topological_sort'

def install_order(arr)
  max_id = 0
  ordered = {}
  arr.each do |tuple|
    ordered[tuple[0]] ||= Vertex.new(tuple[0])
    ordered[tuple[1]] ||= Vertex.new(tuple[1])
    Edge.new(ordered[tuple[1]], ordered[tuple[0]])
    max_id = tuple.max if tuple.max > max_id
  end
  packages = []
  (1..max_id).each do |i|
    packages << i unless ordered[i]
  end
  packages + topological_sort(ordered.values).map { |node| node.value }
end
