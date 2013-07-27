from flask import Flask
from flask.ext.mongoengine import MongoEngine
from flask.ext.restful import reqparse,abort,Api,Resource


app = Flask(__name__)
api = Api(app)
app.config["MONGODB_SETTINGS"] = {"DB": "my_tumble_log"}
app.config["SECRET_KEY"] = "KeepThisS3cr3t"

db = MongoEngine(app)


def register_blueprints(app):
    # Prevents circular imports
    from tumblelog.views import posts
    from tumblelog.admin import admin
    app.register_blueprint(posts)
    app.register_blueprint(admin)

register_blueprints(app)

TODOS = {
    'todo1': {'task': 'build an API'},
    'todo2': {'task': '?????'},
    'todo3': {'task': 'profit!'},
}


def abort_if_todo_doesnt_exist(todo_id):
    if todo_id not in TODOS:
        abort(404, message="Todo {} doesn't exist".format(todo_id))

parser = reqparse.RequestParser()
parser.add_argument('task', type=str)

# Todo
#   show a single todo item and lets you delete them
class Todo(Resource):
    def get(self, todo_id):
        abort_if_todo_doesnt_exist(todo_id)
        return TODOS[todo_id]

    def delete(self, todo_id):
        abort_if_todo_doesnt_exist(todo_id)
        del TODOS[todo_id]
        return '', 204

    def put(self, todo_id):
        args = parser.parse_args()
        task = {'task': args['task']}
        TODOS[todo_id] = task
        return task, 201


# TodoList
#   shows a list of all todos, and lets you POST to add new tasks
class TodoList(Resource):
    def get(self):
        return TODOS

    def post(self):
        args = parser.parse_args()
        todo_id = 'todo%d' % (len(TODOS) + 1)
        TODOS[todo_id] = {'task': args['task']}
        return TODOS[todo_id], 201
# PostList
#   shows a list of all post, and lets you POST to add new tasks
from flask import jsonify
class PostList(Resource):
    def get(self):
#        posts = Post.objects.all()
        results = {'body':'posts[1].body'}
        return results

    def post(self):
        args = parser.parse_args()
        post_id = 'post%d' % (len(TODOS) + 1)
        return 'post success.', 201

##
## Actually setup the Api resource routing here
##
api.add_resource(TodoList, '/api/v1/todos')
api.add_resource(Todo, '/api/v1/todos/<string:todo_id>')
api.add_resource(PostList, '/api/v1/posts')

if __name__ == '__main__':
    app.run()
