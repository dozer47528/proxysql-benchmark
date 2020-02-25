# ProxySQL Benchmark

## How to use

```sh
make prepare # Install mysql and proxysql to kubernetes cluster
make benchmark # Run benchmark
make log # Check benchmark result
make cleanup
```

## Configurations

### MySQL

- `./Makefile`: Install script
- `./mysql.yaml`: MySQL helm chart config

### ProxySQL

- `./Makefile`: Install script
- `./charts/proxysql/templates/configmap.yaml`: ProxySQL config

### Benchmark

- `./Makefile`: Install script
- `./charts/benchmark/templates/configmap.yaml`: Benchmark script