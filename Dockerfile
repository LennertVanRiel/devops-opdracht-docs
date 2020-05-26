From mcr.microsoft.com/dotnet/core/sdk:3.1 AS build-env
WORKDIR /app

COPY repo/API/api_lennert/*.csproj ./
RUN dotnet restore

COPY repo/API/api_lennert/. ./
RUN dotnet publish -c Release -o out

FROM mcr.microsoft.com/dotnet/core/aspnet:3.1
WORKDIR /app
COPY --from=build-env /app/out .
ENTRYPOINT ["dotnet", "api_lennert.dll"]
