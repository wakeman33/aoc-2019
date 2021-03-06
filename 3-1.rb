wire_one, wire_two = File.readlines(ARGV[0])

wire_one_movements = wire_one.split(',')
wire_two_movements = wire_two.split(',')
puts wire_one_movements.length
puts wire_two_movements.length

wire_one = {head: {x: 0, y: 0}, prev: {x: 0, y: 0}}
wire_two = {head: {x: 0, y: 0}, prev: {x: 0, y: 0}}
$small

def add_vector(line_info, direction, distance)
  head = line_info[:head]
  prev = line_info[:prev]

  # Move head to prev
  prev[:x] = head[:x]
  prev[:y] = head[:y]

  case direction
  when 'U'
    head[:y] += distance
  when 'D'
    head[:y] -= distance
  when 'R'
    head[:x] += distance
  when 'L'
    head[:x] -= distance
  else
    puts "Unknown Direction"
  end

end

def parse_vector(line_vector)
  [line_vector.slice(0, 1), line_vector.slice(1, line_vector.length).to_i]
end

def print_points(wire_one_info, wire_two_info)
  puts "Wire One Points"
  puts 'x1: ' + wire_one_info[:head][:x].to_s + ', y1: ' + wire_one_info[:head][:y].to_s
  puts 'x2: ' + wire_one_info[:prev][:x].to_s + ', y2: ' + wire_one_info[:prev][:y].to_s

  puts "Wire Two Points"
  puts 'x1: ' + wire_two_info[:head][:x].to_s + ', y1: ' + wire_two_info[:head][:y].to_s
  puts 'x2: ' + wire_two_info[:prev][:x].to_s + ', y2: ' + wire_two_info[:prev][:y].to_s
end

def check_wire_secments(wire_one_info, wire_two_info, direction_1, direction_2)
  # qy1 < py1 && qy1 > py2       py1 > qy1 > py2 
  # px1 < qx1 && px1 > qx2       qx1 > px1 > qx2j
  if (wire_two_info[:head][:y] <= wire_one_info[:head][:y] && wire_two_info[:prev][:y] >= wire_one_info[:head][:y]) ||
     (wire_two_info[:prev][:y] <= wire_one_info[:head][:y] && wire_two_info[:head][:y] >= wire_one_info[:head][:y])
    if (wire_one_info[:head][:x] <= wire_two_info[:head][:x] && wire_one_info[:prev][:x] >= wire_two_info[:head][:x]) ||
       (wire_one_info[:prev][:x] <= wire_two_info[:head][:x] && wire_one_info[:head][:x] >= wire_two_info[:head][:x])
      puts "wires have crossed!!!"


      if wire_one_info[:head][:x] ==  wire_one_info[:prev][:x]
        x = wire_one_info[:head][:x]
      else
        x = wire_two_info[:head][:x]
      end

      if wire_one_info[:head][:y] ==  wire_one_info[:prev][:y]
        y = wire_one_info[:head][:y]
      else
        y = wire_two_info[:head][:y]
      end
      puts x
      puts y
      print_points(wire_one_info, wire_two_info)
      
      distance = x.abs + y.abs
      puts "Distance: " + distance.to_s
      if $small.nil?
        puts "NIL!"
        $small= distance
      elsif $small> distance
        puts "smaller"
        $small= distance
      end
    end
  end
end

wire_one_movements.each do |line_one_vector|
  wire_two = {head: {x: 0, y: 0}, prev: {x: 0, y: 0}}
  direction_1, distance_1 = parse_vector(line_one_vector)
  add_vector(wire_one, direction_1, distance_1)

  wire_two_movements.each do |line_two_vector|
    direction_2, distance_2 = parse_vector(line_two_vector)

    add_vector(wire_two, direction_2, distance_2)
    check_wire_secments(wire_one, wire_two, direction_1, direction_2)
  end
end

puts "Shortest"
puts $small
puts "Wire One Ending Info"
puts wire_one[:head][:x]
puts wire_one[:head][:y]
puts wire_one[:prev][:x]
puts wire_one[:prev][:y]


puts "\n" * 4


puts "Wire Two Ending Info"
puts wire_two[:head][:x]
puts wire_two[:head][:y]
puts wire_two[:prev][:x]
puts wire_two[:prev][:y]

