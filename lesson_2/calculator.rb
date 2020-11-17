# ask the user for two numbers
# ask the user for an operation to perform
# perform the operation on the two numbers
# output the results

def prompt(message)
	Kernel.puts("=> #{message}")
end

def valid_number?(number)
	number.to_i != 0
end

def operation_to_msg(op)
	case op
	when '1' then 'Adding'
	when '2' then 'Subtracting'
	when '3' then 'Multiplying'
	when '4' then 'Dividing'
	end
end


prompt("Welcome to Calculator! Please enter your name: ")

name = ""
loop do 
	name = gets().chomp()

	if name.empty?()
		prompt("That doesn't seem right..")
	else
		break
	end
end

prompt("Hi, #{name}!")

loop do 

	number1 = ""
	loop do 
		prompt("What's the first number?")
		number1 = Kernel.gets().chomp()

		if valid_number?(number1)
			break
		else
			prompt("Hmm.. that doesn't look like a number!")
		end
	end

	number2 = ""
	loop do 
		prompt("What's the second number?")
		number2 = Kernel.gets().chomp()

		if valid_number?(number2)
			break
		else
			prompt("Hmm.. that doesn't look like a number!")
		end
	end

	operator_prompt = <<-MSG
		What operation would you like to perform?
		1) Addition
		2) Subtraction
		3) Multiplication
		4) Division

	MSG

	prompt(operator_prompt)
	
	operator = ""
	loop do 
		operator = Kernel.gets().chomp()

		if %w(1 2 3 4).include?(operator)
			break
		else
			prompt("Please enter 1, 2, 3, or 4")
		end
	end

	prompt("#{operation_to_msg(operator)} the two numbers...")

	result = case operator
					 when '1' then number1.to_i() + number2.to_i()
					 when '2' then number1.to_i() - number2.to_i()
					 when '3' then number1.to_i() * number2.to_i()
					 when '4' then number1.to_f() / number2.to_f()
	end

	prompt("The result is #{result}.")

	prompt("Do you want to play again? (Y to calculate)")
	answer = gets().chomp()
	break unless answer.downcase.start_with?('y')

end

prompt("Thanks for playing!")
