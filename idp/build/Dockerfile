FROM mcr.microsoft.com/dotnet/sdk:6.0 AS build
RUN dotnet dev-certs https -ep /.aspnet/https/aspnetapp.pfx -p 123456789123456789 && dotnet dev-certs https --trust


FROM luizcarlosfaria/oidc-mock-server:latest

COPY --from=build /.aspnet/https/aspnetapp.pfx /root/.aspnet/https/aspnetapp.pfx
RUN ls -l /root/.aspnet/https/

RUN apt-get update \
&& apt-get upgrade -y \
&& apt-get install curl -y 

ENV ASPNETCORE_HTTPS_PORT=8001
ENV ASPNETCORE_URLS="https://+;http://+"
ENV ASPNETCORE_HTTPS_PORT=8001 
ENV ASPNETCORE_Kestrel__Certificates__Default__Password="123456789123456789" 
ENV ASPNETCORE_Kestrel__Certificates__Default__Path=/root/.aspnet/https/aspnetapp.pfx
