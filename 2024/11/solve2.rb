def blink(stones)
  new_stones = Hash.new { 0 }

  stones.each do |stone, number|
    case
    when stone == 0
      new_stones[1] += number
    when stone.digits.length.even?
      first, second = stone.to_s.chars.each_slice(stone.digits.length / 2).map(&:join).map(&:to_i)
      new_stones[first] += number
      new_stones[second] += number
    else
      new_stones[stone * 2024] += number
    end
  end

  new_stones
end

stones = IO.readlines('input.txt')[0].split.map(&:to_i)
stones = stones.tally

75.times do
  stones = blink(stones)
end

puts stones.values.sum