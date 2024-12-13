def blink(stones)
  index = 0

  stones.size.times do
    stone = stones[index]

    case
    when stone == 0
      stones[index] = 1
    when stone.digits.length.even?
      first, second = stone.to_s.chars.each_slice(stone.digits.length / 2).map(&:join).map(&:to_i)
      stones[index] = first
      stones.insert(index + 1, second)
      index += 1
    else
      stones[index] = stone * 2024
    end

    index += 1
  end

  stones
end

stones = IO.readlines('input.txt')[0].split.map(&:to_i)

25.times do
  stones = blink(stones)
end

puts stones.size