require 'yaml'

class StartG

    @@codes = ""
    @@life = 0
    @@question = ""
    @@wrong_guesses = ""
    @@loaded = false

    def save_game
        puts "Enter A Name To save Your GAME!"
        file_n = gets.chomp
        file_name = "#{file_n}.yml"
        saved_on = false
        while saved_on == false
            if Dir.glob("saved/*").include? file_name
                puts "name Already Exists"
                next
            else
                file_named = "saved/#{file_name}"
                saving = {code: @@codes, guesses: @@life, guessed: @@question, wrn_gues: @@wrong_guesses}
                min = YAML.dump(saving)
                File.open(file_named, "w") {|file| file.write(min)}
                saved_on = true
            end
            puts "GAME SAVED #{file_n}"
        end
    end

    def load_game
        nop = false
        games = Dir.glob("saved/*")
        puts "just enter the Name In the Middle \nWhats between '/' and '.' \n#{games}"
        while nop == false
            puts "Enter The Saved Game Name?"
            f_game = gets.chomp
            l_game = "saved/#{f_game}.yml"
            if Dir.glob("saved/*").include? l_game
                game_initializing = YAML.load(File.read(l_game))
                @@codes = game_initializing[:code]
                @@life = game_initializing[:guesses]
                @@question = game_initializing[:question]
                @@wrong_guesses = game_initializing[:wrn_gues]
                nop = true
                @@loaded = true
            else
                puts "Wrong Name"
                next
            end
        end
    end

    def random_line
        filed = File.readlines("5desk.txt").sample()
        filed.delete!(" ")
        return filed
    end
    
    def line_san
        line = false
        while line == false
            random_code = random_line()
            if random_code.length > 4 && random_code.length < 13
                line = true
            else
                next    
            end
        end
        @@codes = random_code.downcase
    end
    
    def guess_times
        @@life = @@codes.length
    end
    
    def the_game
        ask_code = @@codes.split("")
        @@question = "_" * @@codes.length
        puts "The Code IS #{@@question}"
        puts "Guess A Letter Or A Word \nTo Guess a Letter Enter L \nTo Guess a Word Enter W"
        puts "You choose To Guess The Word You'll Have To Guess To Whole Word"
        while @@life > 0
            health = " YOUR HEALTH! #{@@life}
                    Wrong Guesses = #{@@wrong_guesses}
                    _______
                    o     |
                   /|\\    |
                   /-\\    |"
            puts health
            puts "Guess A Letter Or A Word \nTo Guess a Letter Enter L \nTo Guess a Word Enter W"
            if @@loaded == false
                puts "Load Game? Enter 1\nSave Game Enter 2"
            else
                puts "Save Game Enter 2"
            end    
            puts @@question
            ask_to_play = gets.chomp.downcase
            if ask_to_play == "2"
                save_game()
                return puts "Saved"
            elsif ask_to_play == "1"
                load_game()
                next
            elsif ask_to_play == "l"
                puts "The Code IS #{@@codes.length} Letters Long #{@@question}"
                lett = gets.chomp.downcase
                if lett.length > 1 || lett.length < 1
                    puts "Only Guess a Single Letter"
                    next
                else
                    if @@wrong_guesses.include? lett
                        puts "Already Guessed"
                        next
                    end    
                    if @@codes.include? lett
                        j = @@codes.index(lett)
                        @@question[j] = lett
                    else
                        @@wrong_guesses += "#{lett} "
                    end
                end
                @@life -= 1
            elsif ask_to_play == "w"
                puts "The Code IS #{@@codes.length} Letters Long #{@@question}"
                wlet = gets.chomp.downcase
                if wlet > 1
                    if wlet == @@codes
                        puts "Congratulations You Won The Game The Word Was #{@@codes}"
                        @@life = 0
                    else
                        puts "Wrong Word Guess! #{@@question}"
                        @@life -= 1
                    end
                else
                    puts "You'll Have To Guess The Whole Word #{@@question}"
                    next
                end
            else
                puts "only Choose 1 Or 2 L Or W"
                next
            end
        end
        puts "The Word Is! #{@@codes} Your Wrong Guesses #{@@wrong_guesses}"
    end
    
    def initialize()
        puts @name
        random_line()
        line_san()
        guess_times()
        the_game()
    end
end

myhang = StartG.new()