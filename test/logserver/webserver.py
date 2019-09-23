from flask import Flask, render_template
import mysql.connector as mysqldb

app = Flask(__name__)

class Database:
    def __init__(self):
        host = "127.0.0.1"
        user = "webusr"
        password = "webusr"
        db = "hpoc_deploy"
        port = "3306"
        self.con = mysqldb.connect(host=host, user=user, password=password, database=db, port=port)
        self.cur = self.con.cursor()

    def list_messages(self):
        self.cur.execute("SELECT hostname,module,replycode FROM deploy_status")
        result = self.cur.fetchall()
        return result

@app.route('/')
def employees():
    def db_query():
        db = Database()
        emps = db.list_messages()
        return emps
    
    res = db_query()
    return render_template('index.html', result=res, content_type='application/json')

if __name__ == "__main__":
    app.run(host='0.0.0.0')
