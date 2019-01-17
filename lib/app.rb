require 'twitter'
require 'dotenv'

require_relative 'list.rb'

  Dotenv.load

@client = Twitter::REST::Client.new do |config|
  config.consumer_key        = ENV["TWITTER_CONSUMER_KEY"]
  config.consumer_secret     = ENV["TWITTER_CONSUMER_SECRET"]
  config.access_token        = ENV["TWITTER_ACCESS_TOKEN"]
  config.access_token_secret = ENV["TWITTER_ACCESS_TOKEN_SECRET"]
end

@client = Twitter::Streaming::Client.new do |config|
    config.consumer_key        = ENV["TWITTER_CONSUMER_KEY"]
    config.consumer_secret     = ENV["TWITTER_CONSUMER_SECRET"]
    config.access_token        = ENV["TWITTER_ACCESS_TOKEN"]
    config.access_token_secret = ENV["TWITTER_ACCESS_TOKEN_SECRET"]
end


def send_tweet(n , list)
		nlist = []
		n.times do
			pseudo = list[rand(list.length)]
			while nlist.include?(pseudo)
				pseudo = list[rand(list.length)] 
			end
			nlist << pseudo
		end
		
		####code instructions to do here####
			print "Sending"
			nlist.each do |pseudo|
				@client.follow(pseudo.delete('@'))
				@client.update("Hello! #{pseudo} :: #bonjour_monde @the_hacking_pro")
				print "."
			end
			puts "tweets sent!"
		####################################
end

def send_tweet_to(someone, tweet)
	print "Sending to #{someone.delete('@')}..."
	@client.follow(someone.delete('@'))
	@client.update("#{someone} :: #{tweet}")
	puts "tweet sent!"
end

def like_bonjour
	print "Progressing"
	@client.search("#bonjour_monde", result_type: "recent").take(30).each do |tweet|
		@client.fav tweet
		print "."
	end
	puts "Done!"
end

def follow_users(n, hashtag)
	print "Following"
  @client.search("#{hashtag}", result_type: "recent").take(n).each do |tweet|
    if tweet.user != 'Princy97380047'
    	@client.follow(tweet.user) 
    	print "."
    else
    	next
    end
  end
  puts "Done!"
end

def take_their_id(n, hashtag)
	id_list = []
	print "Recupering"
	i = 0
	id_list = @client.search("#{hashtag}", result_type: "random").take(n)
  puts "Done!"
  puts id_list.inspect 	
end


#send_tweet_to('@jo_rakoto',"#bonjour_monde")
#send_tweet(5, List)
#like_bonjour
#@client.follow("the_hacking_pro")