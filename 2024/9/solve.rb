input = IO.read('input.txt')
disk_map = []

file_index = 0

input.chars.map(&:to_i).each_with_index do |block, index|
  if index.even?
    (1..block).each {|i| disk_map << file_index}
    file_index += 1
  else
    (1..block).each { disk_map << '.' }
  end
end

disk_size = disk_map.size
previous_map = []

until previous_map == disk_map
  previous_map = disk_map.dup

  reverse_index = disk_map.reverse.index {|block| block != "."}
  block_index = disk_size - reverse_index - 1
  first_free_space_index = disk_map.index(".")

  disk_map[block_index], disk_map[first_free_space_index] = disk_map[first_free_space_index], disk_map[block_index] if first_free_space_index < block_index
end

checksum = 0

disk_map.each_with_index do |block, index|
  unless block == '.'
    checksum += block * index
  end
end

puts checksum