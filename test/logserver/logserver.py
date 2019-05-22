#!/usr/bin/env python3

from http.server import BaseHTTPRequestHandler, HTTPServer
import logging
import urllib
import mysql.connector as mariadb
from flask import Flask

class S(BaseHTTPRequestHandler):
    def _set_response(self):
        self.send_response(200)
        self.send_header('Content-type', 'text/html')
        self.end_headers()

    def do_POST(self):
        content_length = int(self.headers['Content-Length']) # <--- Gets the size of data
        post_data = self.rfile.read(content_length) # <--- Gets the data itself
        #logging.info("POST request,\nPath: %s\nHeaders:\n%s\n\nBody:\n%s\n",str(self.path), str(self.headers), post_data.decode('utf-8'))
        message=urllib.parse.unquote(self.path)
        message_list=message[1:].split("|")
        db_actions(message_list[0],message_list[2],message_list[3],message_list[4],'insert')

        self._set_response()
        #self.wfile.write("POST request for {}".format(self.path).encode('utf-8'))

# MariaDB related stuff. get the query and what is the module to run (create,insert, update, etc)
def db_actions(date,host_ip,module,module_msg,action):
    # open the mariadb connection
    mariadb_connection=mariadb.connect(user='webusr',password='webusr',database='hpoc_deploy',host='127.0.0.1',port='3306')
    cursor=mariadb_connection.cursor()

    # check if the host_ip exists in the database
    query='select count(*) from deploy_status where hostname=\'' + host_ip + '\''
    cursor.execute(query)
    
    row=cursor.fetchone()
    if row[0]==0:
        # if the hostname does not exist in the table, add it to the table and move forward
        query="insert into deploy_status(hostname) values(\'" + host_ip +"\')"
        cursor.execute(query)
        mariadb_connection.commit()
    else:
        #update deploy_status set replycode='Cluster status: ', module='cluster_check' where hostname='10.42.100.37'
        query="update deploy_status set replycode=\'" + module_msg +"\', module=\'" + module + "\' where hostname=\'" + host_ip +"\'" 
        cursor.execute(query)
        mariadb_connection.commit()

    #close the mariadb connection
    mariadb_connection.close()
    return

# Function for running the HTTP server
def run(server_class=HTTPServer, handler_class=S, port=8080):
    logging.basicConfig(level=logging.INFO)
    server_address = ('', port)
    httpd = server_class(server_address, handler_class)
    logging.info('Starting httpd...\n')
    try:
        httpd.serve_forever()
    except KeyboardInterrupt:
        pass
    httpd.server_close()
    logging.info('Stopping httpd...\n')

if __name__ == '__main__':
    from sys import argv

    if len(argv) == 2:
        run(port=int(argv[1]))
    else:
        run()
