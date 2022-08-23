# Infraestrutura | eshop-cloudnative-infra

Projeto destinado à gerenciar a infraestrutura de "produção".

* Em `/01-ClusterSetup/` temos scripts e configurações para a construção e configuração do cluster Kubernetes.
* Em `/02-Resources/` temos a construção dos componentes de infraestrutura necessários para o projeto.

Ambas as pastas possuem um script `00-main.sh` que pode ser usado da seguinte forma:

| Script | Descrição |
| ------ | ------ |
| `./00-main.sh -i` | Realiza a **instação** dos componentes | 
| `./00-main.sh -u` | Realiza a **desinstalação** dos componentes | 

## [luizcarlosfaria/eshop-cloudnative](../../../../luizcarlosfaria/eshop-cloudnative)

Esse projeto é parte do projeto [luizcarlosfaria/eshop-cloudnative](../../../../luizcarlosfaria/eshop-cloudnative)
  
## Nossa pseudo-infraestrutura de produção

Vale lembrar que esse projeto tem a finalidade de demonstrar aborgagens mais próximas do dia-a-dia de produção.

Em alguns casos, principalmente aqui, teremos mais recursos dentro do Kubernetes, exatamente para simular o ambiente cloud.

## Infra Stack

### K3D

O [k3d](https://k3d.io/) suporte com a criação de um ambiente Kubernetes fake dentro do docker. Dessa forma subir isso em um servidor de testes é simples, da mesma forma como dropar e recriar essa infra periodicamente se torna ainda mais fácil.

O k3d orquestra o Rancher [k3s](https://k3s.io/) que por sua vez é uma distribuição enxuta de Kubernetes.

### Dashboard

Nosso Kubernetes já nasce com dashboard configurado automaticamente, esse dashboard ajuda a visualizar todos os objetos do nosso cluster.


### Namespaces

Para a criação da nossa infra 2 namespaces são criados:

#### eshop-resources

Destinado à infraestrutura, como Cluster Postgres.

#### eshop-services

Destinado aos serviços de negócio que dão vida ao projeto.

### CloudNativePG - Cluster PostgreSQL

O [CloudNativePG](https://cloudnative-pg.io/) um operador do Kubernetes que cobre todo o ciclo de vida de um cluster de banco de dados PostgreSQL altamente disponível com uma arquitetura primary/standby, usando replicação de streaming nativa.

Com ele a criação de um novo cluster gerenciado depende apenas de um simples yaml.

### PgAdmin

Uma instância do PgAdmin4 já configurada com nosso cluster é super interessante para demonstrar nosso cluster em ação. Também nos permite administrar e acompanhas a instância primária e as secundárias.


### Echo Server

Prata da casa, o Echo Server é usado aqui para demonstrar o funcionamento do cluster, ainda nos processos iniciais de setup. Ele nos assegura que o ambiente está funcionando, inclusive que o ingress controller está respondendo aos eventos.