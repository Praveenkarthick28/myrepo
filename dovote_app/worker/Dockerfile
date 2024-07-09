# because of dotnet, we always build on amd64, and target platforms in cli
FROM --platform=${BUILDPLATFORM} mcr.microsoft.com/dotnet/sdk:7.0 AS build
ARG TARGETPLATFORM
ARG TARGETARCH
ARG BUILDPLATFORM
RUN echo "I am running on $BUILDPLATFORM, building for $TARGETPLATFORM"

WORKDIR /source
COPY *.csproj .
RUN dotnet restore -a $TARGETARCH
# restoring all the dependencies

COPY . .
#copy all the code to workdir

RUN dotnet publish -c release -o /app -a $TARGETARCH --self-contained false --no-restore
#--no-restore is avoid restoring again

#app image
FROM mcr.microsoft.com/dotnet/runtime:7.0
WORKDIR /app
COPY --from=build /app .
ENTRYPOINT ["dotnet", "Worker.dll"]
