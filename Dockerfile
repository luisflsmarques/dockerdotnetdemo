#FROM mcr.microsoft.com/dotnet/core/aspnet:3.0-buster-slim AS base
#WORKDIR /app
#EXPOSE 80
#EXPOSE 443

#FROM mcr.microsoft.com/dotnet/core/sdk:3.0-buster AS build
#WORKDIR /src
#COPY ["dockerdotnetdemo.csproj", ""]
#RUN dotnet restore "./dockerdotnetdemo.csproj"
#COPY . .
#WORKDIR "/src/."
#RUN dotnet build "dockerdotnetdemo.csproj" -c Release -o /app/build

#FROM build AS publish
#RUN dotnet publish "dockerdotnetdemo.csproj" -c Release -o /app/publish

#FROM base AS final
#WORKDIR /app
#COPY --from=publish /app/publish .
#ENTRYPOINT ["dotnet", "dockerdotnetdemo.dll"]

FROM mcr.microsoft.com/dotnet/core/sdk:3.0-buster AS build
LABEL author="Luis Marques"
#the line below says - if i change my project, restart web server kesterl
ENV DOTNET_USE_POLLING_FILE_WATCHER=1
ENV ASPNETCORE_URLS=http://*:5000
WORKDIR /app
CMD ["/bin/bash", "-c", "dotnet restore && dotnet run"]
