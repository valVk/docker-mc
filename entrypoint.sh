ls -la /root/.ssh


[[ -d node_modules ]] || npm i \
&& DEBUG=myapp:* npm start