FROM mcr.microsoft.com/dotnet/core/sdk:3.0 AS build-env
WORKDIR /app

COPY . ./

RUN dotnet restore "./coretoheroku.csproj"
RUN ASPNETCORE_ENVIRONMENT=Production dotnet publish "./coretoheroku.csproj" -c Release -o out


FROM mcr.microsoft.com/dotnet/core/aspnet:3.0 AS runtime
WORKDIR /app
COPY --from=build-env /app/out .
CMD ASPNETCORE_URLS=http://*:$PORT dotnet coretoheroku.dll
