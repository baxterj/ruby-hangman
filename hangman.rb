class Game 
   def initialize(word)
      @guessed_letters = []
      @word = word.downcase
      @guessed = @word.gsub(/./, '_')
      @lives_left = 5

      # Start the game!
      # Normally one has to be careful with while loops that don't specify an end condition.
      # Here we know that the turn method will actually terminate the program eventually, so 
      # we aren't too worried.
      while true do
         turn
      end
   end

   def turn
      puts "Progress: " + insert_spaces(@guessed)
      
      input = handle_input

      if (@guessed_letters.include?(input))
         puts "You already tried that, go again"
         return
      end

      @guessed_letters << input
      found_letter = test_letter(input)
      process_lives(found_letter)

      # Input handled, now see if the game is over.  We need to check why and act appropriately
      if (winner? or out_of_lives?)
         puts "Game over, the word was #{@word}"
         puts "You are a winner!" if winner?
         puts "You are a failure!" if out_of_lives?
         exit
      end
      
   end

   def handle_input
      puts "Make a guess"
      input = gets.chomp.downcase
      if (input.size != 1)
         puts("Input must be one character")
      end
      return input
   end

   def test_letter(input)
      found = false
      for i in 0..@word.length-1 do
         if (@word[i] == input)
            @guessed[i] = @word[i]
            found = true
         end
      end
      return found
   end

   def process_lives(found)
      if (found)
         puts "Letter is in word, congratulations"
      else
         @lives_left -= 1
         puts "Letter not in word, lose a life! Lives remaining: #{@lives_left}"
      end
   end

   def out_of_lives?
      return @lives_left <= 0
   end

   def winner?
      return @word == @guessed
   end

   def insert_spaces(word)
      spaced = ""
      word.each_char do |x|
         x += " "
         spaced << x
      end
      return spaced
   end

end

Game.new("quaggan")