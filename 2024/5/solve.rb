input = IO.read('input.txt')
parts = input.split(/\n\n/)
rules = parts[0].split(/\n/).map {|line| line.split('|').map(&:to_i)}
updates = parts[1].split(/\n/).map {|line| line.split(',').map(&:to_i)}
result = 0

correct_updates = updates.filter do |update|
  rules_to_apply = rules.filter do |rule|
    update.include? rule[0] and update.include? rule[1]
  end

  rules_to_apply.all? do |rule|
    first, second = rule
    update.index(first) < update.index(second)
  end
end

correct_updates.each do |update|
  result += update[(update.count/2).floor]
end

puts result