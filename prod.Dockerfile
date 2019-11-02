FROM mcr.microsoft.com/dotnet/core/sdk:3.0-buster AS publish
WORKDIR /publish
COPY dockerdotnetdemo.csproj .
RUN dotnet restore
COPY . .
RUN dotnet publish --output ./out

FROM mcr.microsoft.com/dotnet/core/aspnet:3.0-buster-slim
LABEL author = "Luis Marques"
WORKDIR /app
COPY --from=publish /publish/out .
ENV ASPNETCORE_URLS=http://*:5000
EXPOSE 5000
ENTRYPOINT ["dotnet", "dockerdotnetdemo.dll"]