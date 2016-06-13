require_relative 'initialize.rb'

class Main
	attr_reader :pagi
	def initialize
		@pag = 0
		@flag = false
		@exit = false
		@a1 = "                   1 - Reddit"
		@a2 = "                   2 - Mashable"
		@a3 = "                   3 - Digg"
		@a4 = "                   4 - Todas las anteriores"
		@a9 = "                   9 - Salir"
	end

	def choose_fonts
		@selection = []
		while (!@exit)
			system("clear")
			print "\n\n\n            Escoge las fuentes de noticias que quieras\n\n\n\n"
			puts @a1
			puts @a2
			puts @a3
			puts @a4
			puts @a9
			i = gets.chomp

			if ((i == "1")&&(@a1 != ""))
				@selection << Reddit.new.get_news
				@a1 = ""
		        @a4 = ""
		        if (@a2 != @a3)
					puts "Si quiere escoger otra fuente ingrese S de lo contrario enter..."
					h = gets.chomp
					if (h == "S")
						@flag = false
					else
						@flag = true
						@exit = true
					end
				else
					@flag = true
				end
			elsif ((i == "2")&&(@a2 != ""))
				@selection << Mashable.new.get_news
				@a2 = ""
				@a4 = ""
				if (@a1 != @a3)
					puts "Si quiere escoger otra fuente ingrese S de lo contrario enter..."
					h = gets.chomp
					if (h == "S")
						@flag = false
					else
						@flag = true
						@exit = true
					end
				else
					@flag = true
				end
			elsif ((i == "3")&&(@a3 != ""))
				@selection << Digg.new.get_news
				@a3 = ""
				@a4 = ""
				if (@a2 != @a1)
					puts "Si quiere escoger otra fuente ingrese S de lo contrario enter..."
					h = gets.chomp
					if (h == "S")
						@flag = false
					else
						@flag = true
						@exit = true
					end
				else
					@flag = true
				end
			elsif ((i == "4")&&(@a1 != "")&&(@a2 != "")&&(@a3 != ""))
				@selection << Reddit.new.get_news << Mashable.new.get_news << Digg.new.get_news
				@flag = true
				@a1 = ""
				@a2 = ""
				@a3 = ""
			elsif (i == "9")
				@exit = true
			else
				puts "Ingrese un opcion valida"
			end

			if (@a1 == @a2)&&(@a1 == @a3)
				@exit = true
			end
		end
		@selection
	end

	def items_by_pag
		g = true
		while (g)
			system("clear")
			print "\n\n\n         Escoge cuantos elemtos quieres  ver por pag\n\n\n\n\n"
			puts  "                   1-(5 Elemntos)   2-(10 Elementos)"
			i = gets.chomp
			if i == "1"
				@pagi = 5
				g = false
			elsif i == "2"
				@pagi = 10
				g = false
			end
		end
		@pagi
	end

	def run_newspaper(arr)
		@flag = true
		while (@flag)
			Tools.new.print_articles(arr[@pag])
			print (" "*25)+"@Pag = #{@pag + 1} | Numero de paginas = #{arr.length} \n\n"

			if @pag == 0
				bar = "                   5(Entrar en alguna noticia)      9(Salir)    2(siguiente)>>"
			elsif (@pag < (arr.length)-1)
				bar = " << 1(Atras)       5(Entrar en alguna noticia)      9(Salir)   2(Siguiente)>>"
			else
				bar = " << 1(Atras)       5(Entrar en alguna noticia)      9(Salir)"
			end

			puts bar
			i = gets.chomp

			if ((i == "1")&&(@pag > 0))
				@pag -= 1
			elsif ((i == "2")&&(@pag < (arr.length)-1))
				@pag += 1
			elsif (i == "5")
				puts "   Ingrese el ID del articulo al cual quiere ingresar"
				i = gets.chomp
				if (i.to_i > 0)&&(i.to_i <= arr[@pag].length)
					Tools.new.open_in_browser(arr[@pag][((i.to_i)-1)].url)
				else
					puts "Ingresa un valor valido"
				end
			elsif (i == "9")
				@flag = false
				@exit = true
			else
				puts "Ingrese un valor correcto, presione enter para continuar..."
				gets.chomp
			end
		end
	end
end

arr = Main.new.choose_fonts
num_items = Main.new.items_by_pag
order = Tools.new.ordenar(arr)
arr = Tools.new.pagination(order, num_items)
Main.new.run_newspaper(arr)
