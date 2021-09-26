# wildfly-server-dockerfile

Em meus estudos sobre docker resolvi criar essa imagem personalizada com base no ambiente de desenvolvimento
Java/JakartaEE, esse Dockerfile em seu processo de build pode ser configurado links com as versões tanto do JDK quanto do servidor Wildfly que será criada a imagem pronta para usar em sua aplicação.
Na criação do Dockerfile foi utilizado o recurso do Docker Multi-Stage Build que impacta na redução do tamanho da imagem posibilitando separar a imagens em camadas e utilizar só o necessario para gerala.


* Procedimento da criação da imagem Build.

```
docker build --build-arg LINK_JAVA=https://github.com/AdoptOpenJDK/openjdk11-binaries/releases/download/jdk-11.0.11%2B9/OpenJDK11U-jre_x64_linux_hotspot_11.0.11_9.tar.gz --build-arg LINK_SERVER=https://download.jboss.org/wildfly/20.0.0.Final/wildfly-20.0.0.Final.tar.gz -t wildfly-server .

```

* Como funciona...

No processo de build da imagem foi utilizado a instrução --build-arg posibilitando a passagem do link nas variaves ARG, LINK_JAVA e LINK_SERVER que estão configurada no Dockerfile, ficando mais facil de trocar a versão do JDK ou do servidor Wildfly quando necessario sem precisar alterar o Dockerfile.

* Repositorio DockerHub

https://hub.docker.com/r/rodrigocastanho/wildfly-server 

