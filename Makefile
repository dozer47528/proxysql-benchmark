prepare:
	helm upgrade -i mysql --namespace benchmark stable/mysql -f mysql.yaml --wait --timeout 120s

	helm upgrade -i proxysql ./charts/proxysql --namespace benchmark \
		--set resources.requests.memory=128Mi \
		--set resources.limits.memory=128Mi \
		--set resources.requests.cpu=2 \
		--set resources.limits.cpu=2 \
		--wait --timeout 120s

benchmark:
	helm delete benchmark 2>/dev/null || true
	kubectl delete pod -l app.kubernetes.io/name=benchmark
	kubectl get pod --sort-by=.metadata.creationTimestamp -o jsonpath="{.items[0].metadata.name}"
	helm upgrade -i benchmark ./charts/benchmark --namespace benchmark \
		--set resources.requests.memory=128Mi \
		--set resources.limits.memory=128Mi \
		--set resources.requests.cpu=1 \
		--set resources.limits.cpu=1
	sleep 5
	kubectl logs -f `kubectl get pod -l app.kubernetes.io/name=benchmark -o jsonpath="{.items[0].metadata.name}"`

clean:
	helm delete benchmark || true
	helm delete proxysql || true
	helm delete mysql || true
