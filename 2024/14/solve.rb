BATHROOM_WIDTH = 100
BATHROOM_HEIGHT = 102

input = IO.readlines('input.txt')
robots = input.map do |line|
  values = line.scan(/[\d-]+/).map(&:to_i)

  {position: [values[0], values[1]], velocity: [values[2], values[3]]}
end

100.times do
  robots.map! do |robot|
    x, y = robot[:position]
    vx, vy = robot[:velocity]
    nx, ny = [x + vx, y + vy]

    nx = nx - BATHROOM_WIDTH - 1 if nx > BATHROOM_WIDTH
    nx = nx + BATHROOM_WIDTH + 1 if nx < 0
    ny = ny - BATHROOM_HEIGHT - 1 if ny > BATHROOM_HEIGHT
    ny = ny + BATHROOM_HEIGHT + 1 if ny < 0

    robot[:position] = [nx, ny]
    robot
  end
end

quadrant_robots = [0, 0, 0, 0]
center_x = BATHROOM_WIDTH / 2
center_y = BATHROOM_HEIGHT / 2

robots.each do |robot|
  x, y = robot[:position]

  case
  when x < center_x && y < center_y
    quadrant_robots[0] += 1
  when x > center_x && y < center_y
    quadrant_robots[1] += 1
  when x < center_x && y > center_y
    quadrant_robots[2] += 1
  when x > center_x && y > center_y
    quadrant_robots[3] += 1
  else
    next
  end
end

puts quadrant_robots.reject(&:zero?).inject(:*)