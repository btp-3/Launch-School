# frozen_string_literal: true

LANGUAGE = 'en'
require 'yaml'
MESSAGES = YAML.load_file('calculator_messages.yml')

def clear_screen
  Kernel.system('clear')
end

def messages(message, lang = LANGUAGE)
  MESSAGES[lang][message]
end

def prompt(key)
  message = messages(key, LANGUAGE)
  puts "=> #{message}"
end

def operation_to_msg(operator)
  word = case operator
         when '1' then prompt('adding')
         when '2' then prompt('subtracting')
         when '3' then prompt('multiplying')
         when '4' then prompt('dividing')
         end
  word
end

def valid_number?(number)
  number.to_i.to_s == number || number.to_f.to_s == number
end

def valid_name?(name)
  true unless name.empty?
end

def obtain_operator
  prompt('operator_prompt')

  operator = ''
  loop do
    operator = gets.chomp
    %w[1 2 3 4].include?(operator) ? break : prompt('operator_choice')
  end

  operator
end

def obtain_name
  name = ''

  loop do
    name = gets.capitalize.chomp
    name.empty? ? prompt('valid_name') : break
  end

  name
end

def obtain_num
  number = ''
  loop do
    prompt('number')
    number = gets.chomp

    valid_number?(number) ? break : prompt('valid_number')
  end

  number
end

def zero_div_error?(num)
  num == '0'
end

def calculate(num1, num2, operator)
  result = case operator
           when '1' then num1.to_i + num2.to_i
           when '2' then num1.to_i - num2.to_i
           when '3' then num1.to_i * num2.to_i
           when '4'
             zero_div_error?(num1) ? prompt('zer_div') : (num1.to_i / num2.to_f)
           end
  operation_to_msg(operator)
  puts format(messages('result'), result: result)
end

def calculate_again?
  answer = ''
  loop do
    prompt('play_again')
    answer = gets.chomp
    break
  end

  answer
end

# --------------------------------------------- #

clear_screen

prompt('welcome')

name = obtain_name
puts "Hi #{name}! Let's get started!"

loop do
  number1 = obtain_num
  number2 = obtain_num

  operator = obtain_operator

  calculate(number1, number2, operator)

  answer = calculate_again?
  break unless answer.downcase.start_with?('y')

  clear_screen
end

prompt('exit')
