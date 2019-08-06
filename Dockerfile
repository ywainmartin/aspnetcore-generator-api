# Build Stage
FROM microsoft/aspnetcore-build:2 AS build-env


WORKDIR /generator


#restore

COPY api/api.csproj ./api/
RUN dotnet restore api/api.csproj
COPY api.UnitTest/api.UnitTest.csproj ./api.UnitTest/
RUN dotnet restore api.UnitTest/api.UnitTest.csproj

#display all the directories
#RUN ls -alR

#copy src

COPY . .

#test

RUN dotnet test  api.UnitTest/api.UnitTest.csproj

#publish

RUN dotnet publish api/api.csproj -o /publish

#run time stage

FROM microsoft/aspnetcore:2
COPY --from=build-env /publish /publish
WORKDIR /publish
ENTRYPOINT [ "dotnet" , "api.dll" ]