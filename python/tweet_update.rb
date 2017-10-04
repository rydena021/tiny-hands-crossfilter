require 'json'

file = File.read('tweet_update.json')
raw_tweets = JSON.parse(file)
updated_tweets = []

raw_tweets.each do |tweet|
  tweet_hash = Hash.new

  tweet_hash["created_at"] = tweet["created_at"]
  tweet_hash["id_str"] = tweet["id_str"]
  tweet_hash["text"] = tweet["text"]
  tweet_hash["tweet"] = "<a href=https://twitter.com/realdonaldtrump/status/" + tweet["id_str"] + ">" + tweet["text"] + "</a>"
  tweet_hash["sentiment"] = nil
  tweet_hash["polarity"] = nil
  tweet_hash["subjectivity"] = nil
  tweet_hash["device"] = tweet["source"]
  tweet_hash["in_reply_to_user_id_str"] = tweet["in_reply_to_user_id_str"]
  tweet_hash["is_retweet"] = tweet["is_retweet"]

  updated_tweets << tweet_hash
end


File.open("temp.json","w") do |f|
  f.write(updated_tweets.to_json)
end

# "created_at":"Tue Mar 28 22:41:09 +0000 2017",
# "id_str":"846854703183020032",
# "text":"Why doesn't Fake News talk about Podesta ties to Russia as covered by @FoxNews or money from Russia to Clinton - sale of  Uranium?",
# "tweet":"<a href=https://twitter.com/realdonaldtrump/status/846854703183020032>Why doesn't Fake News talk about Podesta ties to Russia as covered by @FoxNews or money from Russia to Clinton - sale of  Uranium?</a>",
# "sentiment":"negative",
# "polarity":-0.5,
# "subjectivity":1.0,
# "device":"iPhone",
# "in_reply_to_user_id_str":null,
# "is_retweet":false



# file = File.read('companies.json')
# data_hash = JSON.parse(file)

# data_hash = data_hash.map do |k|
#   k = JSON.parse(k)
#   [k["label"], k["values"]]
# end

# data_hash = Hash[data_hash]

# jobs_array.each do |k,v|
#   data_hash[k] = data_hash.fetch(k,[]) + [v]
# end

# data_hash = data_hash.map {|k,v| {label: k, values: v}}

# companies_json = []

# data_hash.each do |hash|
#   companies_json << hash.to_json
# end

# File.open('companies.json', 'w') do |f|
#   f << companies_json
# end

# page = HTTParty.put('https://api.myjson.com/bins/33750',
#   :body => companies_json.to_json,
#   :headers => {'Content-Type' => 'application/json; charset=utf-8'})

# puts companies_json.to_json.inspect
# json ruby parsing

# [
#   {
#     "created_at":"Tue Mar 28 22:41:09 +0000 2017",
#     "id_str":"846854703183020032",
#     "text":"Why doesn't Fake News talk about Podesta ties to Russia as covered by @FoxNews or money from Russia to Clinton - sale of  Uranium?",
#     "tweet":"<a href=https://twitter.com/realdonaldtrump/status/846854703183020032>Why doesn't Fake News talk about Podesta ties to Russia as covered by @FoxNews or money from Russia to Clinton - sale of  Uranium?</a>",
#     "sentiment":"negative",
#     "polarity":-0.5,
#     "subjectivity":1.0,
#     "device":"iPhone",
#     "in_reply_to_user_id_str":null,
#     "is_retweet":false
#   },

#   {
#     "created_at":"Tue Mar 28 21:48:40 +0000 2017",
#     "id_str":"846841493952319489",
#     "text":"A NEW ERA IN AMERICAN ENERGY! \n#MadeInTheUSA🇺🇸\nWatch here:  ",
#     "tweet":"<a href=https://twitter.com/realdonaldtrump/status/846841493952319489>A NEW ERA IN AMERICAN ENERGY! \n#MadeInTheUSA🇺🇸\nWatch here:  </a>",
#     "sentiment":"positive",
#     "polarity":0.06818181818181818,
#     "subjectivity":0.22727272727272727,
#     "device":"iPhone","in_reply_to_user_id_str":null,
#     "is_retweet":false
#   },

#   {
#     "created_at":"Tue Mar 28 20:57:17 +0000 2017",
#     "id_str":"846828561491202048",
#     "text":"It was an honor to welcome @GLFOP to the @WhiteHouse today with @VP Pence &amp; Attorney General Sessions. THANK YOU fo… ",
#     "tweet":"<a href=https://twitter.com/realdonaldtrump/status/846828561491202048>It was an honor to welcome @GLFOP to the @WhiteHouse today with @VP Pence &amp; Attorney General Sessions. THANK YOU fo… </a>",
#     "sentiment":"positive",
#     "polarity":0.42500000000000004,
#     "subjectivity":0.7,
#     "device":"iPhone",
#     "in_reply_to_user_id_str":null,
#     "is_retweet":false
#   }
# ]
# require 'unirest'

# class SentimentAnalyzer
#   def self.add_sentiment
#     sql = "SELECT * FROM tweets WHERE (tweets.id BETWEEN 3942 AND 4940)"
#     ActiveRecord::Base.connection.execute(sql).map do |tweet_hash|
#       tweet = Tweet.find(tweet_hash['id'])
#       text = tweet.text
#       uri = URI::encode(text)
#       if tweet.sentiment_score.nil?
#         response = Unirest.get "https://jamiembrown-tweet-sentiment-analysis.p.mashape.com/api/?text=#{uri}",
#         headers:{
#           "X-Mashape-Key" => "Key disabled",
#           "Accept" => "application/json"
#         }
#         tweet.update_column(:sentiment_score, response.body["score"])
#       end
#     end
#   end

#   def self.json_write(array, date)
#     sentiment_hash = {
#       positive: 0,
#       negative: 0,
#       neutral: 0
#     }
#     array.each do |tweet|
#       sentiment_hash[:positive] += 1 if tweet.sentiment == "positive"
#       sentiment_hash[:negative] += 1 if tweet.sentiment == "negative"
#       sentiment_hash[:neutral] += 1 if tweet.sentiment == "neutral"
#     end
#     File.open("app/assets/data/sentiment_jsons/#{date.to_date.to_s}.json", 'wb') do |file|
#       file.write(JSON.pretty_generate(sentiment_hash))
#     end
#   end


#   def self.call_json_write
#     start_date = DateTime.parse("2015-06-16").beginning_of_month
#     end_date = DateTime.current.beginning_of_month

#     date_months = (start_date..end_date).map { |d| DateTime.new(d.year, d.month, 1) }
#     date_months.uniq
#     date_months.each_with_index do |date, index|
#       range = date..(date_months[index + 1] || end_date)
#         SentimentAnalyzer.json_write(Tweet.where(posted_at: range), date)
#     end
#   end
# end
