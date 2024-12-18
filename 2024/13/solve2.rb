input = IO.read('input.txt')
machine_lines = input.split(/\n\n/)

machines = machine_lines.map do |line|
  values = line.scan(/\d+/).map(&:to_i)

  {buttons: [[values[0], values[1]], [values[2], values[3]]], prize: [values[4], values[5]]}
end

tokens = 0

machines.each do |machine|
  ax, ay = machine[:buttons][0]
  bx, by = machine[:buttons][1]
  px, py = machine[:prize]
  px += 10000000000000
  py += 10000000000000

  c = (ax * by - ay * bx)
  a = (px * by - py * bx) / c
  b = (ax * py - ay * px) / c

  if a * ax + b * bx == px and a * ay + b * by == py
    tokens += a * 3 + b
  end
end

puts tokens