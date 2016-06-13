class Tools
	def initialize
	end

	def ordenar (arr)
		list = []
		arr.each { |x|
			x.each { |y|
				list << y
			}
		}
		list.sort! { |a, b|
			b.date <=> a.date
		}
		list
	end

	def pagination(arr, num)
		pag = (arr.length).divmod(num)
		x = 0
		book = []
		for i in 0...pag[0] do
			book << []
			for j in 1..num do
				book[i] << arr[x]
				x += 1
			end
		end
		if (pag[1]!=0)
			i+=1
			book << []
			for j in 1..pag[1] do
				book[i] << arr[x]
				x += 1
			end
		end
		book
	end

	def print_articles(arr)
		system("clear")
		i = 1
		arr.each { |y|
			puts ((" "*35)+(y.source)+(" "*(45-(y.source).length))).colorize(:black).on_light_cyan.underline
			print ("  ID = #{i} \n")
			print "  Title = #{y.title} \n"
			print "  By = #{y.author} \n"
			print Time.at(y.date).strftime "  Fecha = %d-%m-%Y | Hora = %I:%M:%S %p \n\n" 
			print "  Link = #{y.url} \n"
			puts ("-"*80)
			puts (" "*60)
			sleep 0.1
			i += 1
		}
	end

	def open_in_browser(url)	
		system("xdg-open", url)
	end

end