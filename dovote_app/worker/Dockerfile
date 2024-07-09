# because of dotnet, we always build on amd64, and target platforms in cli
FROM mcr.microsoft.com/dotnet/sdk:7.0 AS build

WORKDIR /source
COPY *.csproj .
RUN dotnet restore 
# restoring all the dependencies

COPY . .
#copy all the code to workdir

RUN dotnet publish -c release -o /app --self-contained false --no-restore
#--no-restore is avoid restoring again

#app image
FROM mcr.microsoft.com/dotnet/runtime:7.0
WORKDIR /app
COPY --from=build /app .
ENTRYPOINT ["dotnet", "Worker.dll"]