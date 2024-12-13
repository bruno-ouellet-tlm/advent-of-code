OPERATIONS = [:+, :*, :concat]

def find_equal(result, operands, acc)
  return false if acc > result

  OPERATIONS.any? do |op|
    possibility = op == :concat ? "#{acc}#{operands[0]}".to_i : acc.send(op, operands[0])

    if operands.size == 1
      possibility == result
    else
      find_equal(result, operands[1..], possibility)
    end
  end
end

equations = IO.readlines('input.txt')

calibration_results = equations.sum do |equation|
  result, operands = equation.split(':')
  result = result.to_i
  operands = operands.split(' ').map(&:to_i)

  find_equal(result, operands[1..], operands[0]) ? result : 0
end

puts calibration_results