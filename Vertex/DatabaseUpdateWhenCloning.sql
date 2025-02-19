--select * from oauth_client_details

update oauth_client_details set web_server_redirect_uri = 'http://127.0.0.1:61097/ui/authorize,https://127.0.0.1/ui/authorize,http://vertextest:61097/ui/authorize'