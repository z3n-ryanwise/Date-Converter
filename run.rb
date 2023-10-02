require 'faker'
require 'time'

def get_menu_selection
  system('clear')
  puts 'What do you want to do?'
  puts '1 - Convert ISO.8601 date to Time'
  puts '2 - Convert Epoch to ISO.8601'
  puts '3 - Convert DD/MM/YYYY to ISO.8601'
  puts '0 - Exit'
  puts
  gets.strip.to_i || 99
end

def process_selection(sel)
  case sel
  when 0
    exit(0)
  when 1
    iso_to_time
  when 2
    epoch_to_iso
  when 3
    # Parse works here too!
    iso_to_time
  else
    puts "#{sel} is not an option"
  end
end

def get_input_or_false
  puts
  puts 'Hit enter to return to menu'
  puts 'Input number or string to convert'
  puts
  response = gets.strip
  return false if response == ''

  response
end

def pbcopy(input)
  str = input.to_s
  IO.popen('pbcopy', 'w') { |f| f << str }
  str
end

def iso_to_time
  input = get_input_or_false
  return unless input

  result = pbcopy(Time.parse(input))
  puts "#{result} copied to clipboard!"
  iso_to_time
end

def epoch_to_iso
  input = get_input_or_false
  return unless input

  result = pbcopy(Time.at(input.to_i, in: 'UTC').iso8601)
  puts "#{result} copied to clipboard!"
  epoch_to_iso
end

def dmy_to_iso
  input = get_input_or_false
  return unless input

  result = pbcopy(Time.at(Time.parse(date), in: 'UTC'))
  puts "#{result} copied to clipboard!"
  epoch_to_iso
end

loop do
  selection = get_menu_selection
  process_selection(selection)
end
