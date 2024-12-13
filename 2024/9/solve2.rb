class Block
  def initialize(index, length)
    @index = index
    @length = length
  end

  def index
    @index
  end

  def length
    @length
  end

  def length=(length)
    @length = length
  end

  def is_free_space?
    @index == '.'
  end

  def is_file?
    @index.is_a? Integer
  end
end

def blocks_to_array(blocks)
  arr = []
  blocks.each do |block|
    arr += [block.index] * block.length
  end

  arr
end

input = IO.read('input.txt')

disk_map = []
file_index = 0
checksum = 0

input.chars.map(&:to_i).each_with_index do |block, index|
  if block.to_i > 0
    if index.even?
      disk_map << Block.new(file_index, block.to_i)
      file_index += 1
    else
      disk_map << Block.new('.', block.to_i)
    end
  end
end

(disk_map.size - 1).downto(0).each do |block_index|
  block = disk_map[block_index]
  next unless block.is_file?

  file_index = block_index
  file = block

  (0..file_index).each do |free_space_index|
    free_space = disk_map[free_space_index]
    if free_space.is_free_space? and free_space.length >= file.length and free_space_index < file_index
      disk_map[free_space_index] = file

      free_space_length = file.length

      next_block = disk_map[file_index + 1]
      if !next_block.nil? and next_block.is_free_space?
        free_space_length += next_block.length
        disk_map.delete(next_block)
      end

      previous_block = disk_map[file_index - 1]
      if previous_block.is_free_space?
        free_space_length += previous_block.length
        disk_map.delete(previous_block)
        file_index -= 1
      end

      disk_map[file_index] = Block.new('.', free_space_length)

      remaining_memory = free_space.length - file.length
      if remaining_memory > 0
        disk_map.insert(free_space_index + 1, Block.new('.', remaining_memory))
      end

      break
    end
  end
end

blocks_to_array(disk_map).each_with_index do |block, index|
  unless block == '.'
    checksum += block * index
  end
end

puts checksum