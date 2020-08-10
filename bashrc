#Add to bashrc and run " source ~/.bashrc "
#Or git clone https://github.com/Murakazzz/dockerip.git && cp bashrc /usr/local/bin/dockerip && chmod +x /usr/local/bin/dockerip
dockerip() {
    docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' "$@"
}

dockerips() {
	for dock in $(docker ps|tail -n +2|cut -d" " -f1)
	do
		local dock_ip=$(dockerip $dock)
		regex="s/$dock\s\{4\}/${dock:0:4}  ${dock_ip:-local.host}/g;$regex"
	done

	docker ps -a | sed -e "$regex"
}
