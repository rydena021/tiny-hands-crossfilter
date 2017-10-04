import json
from textblob import TextBlob

with open('temp.json') as json_data:
    tweets = json.load(json_data)
    new_array = []
for tweet in tweets:
    analysis = TextBlob(tweet["text"])
    sentiment = [analysis.sentiment.polarity, analysis.sentiment.subjectivity]
    new_array.append(sentiment)

print(new_array)










# consumer_key= 'CONSUMER_KEY_HERE'
# consumer_secret= 'CONSUMER_SECRET_HERE'

# access_token='ACCESS_TOKEN_HERE'
# access_token_secret='ACCESS_TOKEN_SECRET_HERE'

# auth = tweepy.OAuthHandler(consumer_key, consumer_secret)
# auth.set_access_token(access_token, access_token_secret)

# api = tweepy.API(auth)

