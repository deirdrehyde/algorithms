require_relative 'graph'

# Implementing topological sort using both Khan's and Tarian's algorithms

def topological_sort(vertices)
  queue = []
  sorted = []
  vertices.each do |vertex|
    queue << vertex if vertex.in_edges == []
  end
  until queue == []
    current = queue.shift
    sorted << current
    edges = current.out_edges.dup
    edges.each do |edge|
      if edge.to_vertex.in_edges.count <= 1
        queue.push(edge.to_vertex)
      end
      edge.destroy!
    end
  end
  vertices.length == sorted.length ? sorted : []
end
