echo "=========Files from BUILDER=========="
ls -la /root/.ssh
echo "=========Files from GITHUB=========="
ls -la /opt/app2
echo "===================================="
[[ -d node_modules ]] || npm i \
&& DEBUG=myapp:* npm start