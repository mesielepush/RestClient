require "rest-client"

class Bing
	URL = "https://www.bing.com/search?q="

	def translate(query)
		query.split(" ").join("+")
	end

	def print_links(response)
		links = response.body.split('<h2><a href="').drop(1)
		links.map! { |link| link.split('" ')[0] }
		puts links
	end

	def search
		while true

			puts "\nWrite your search."
			query = gets.chomp
			break if query == 'exit'

			res = RestClient.get(URL + translate(query))
			puts '##########################'
			puts ''
			print_links(res)
			puts ''
			puts '##########################'
			puts ''
			puts 'BTW the cookies:'
			res.cookies.each do |x,y|
				puts 'NAME: '+x+ ' ID: '+y
			end
			puts '##########################'
		end
	end
end

a = Bing.new
a.search