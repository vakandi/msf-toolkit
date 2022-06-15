
echo "\033[1;33m$(curl -s localhost:4040/api/tunnels | grep -Eo "(tcp)://[a-zA-Z0-9./?=_%:-]*" | sed "s#tcp://##g")\033[0m"
