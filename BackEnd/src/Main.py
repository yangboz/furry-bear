#Mongo DB testing
import pymongo
connection = pymongo.Connection('localhost',27017)
db = connection.posts
collection = db.post
print db.posts.find()

#import datetime
#post = {
#        "author":"Mike",
#        "text":"My first blog post!",
#        "tags":['mongodb','python','pymongo'],
#        "date":datetime.datetime.utcnow()
#        }
#posts = db.posts
#posts.insert(post)