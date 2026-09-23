# ---------- Build stage ----------
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build

WORKDIR /src

COPY . .

RUN dotnet reOrder "GlobalCommerce.Order.Api/GlobalCommerce.Order.Api.csproj"

RUN dotnet publish "GlobalCommerce.Order.Api/GlobalCommerce.Order.Api.csproj" \
    -c Release \
    -o /app/publish \
    --no-reOrder


# ---------- Runtime stage ----------
FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS runtime

WORKDIR /app

COPY --from=build /app/publish .

EXPOSE 8080

ENTRYPOINT ["dotnet", "GlobalCommerce.Order.Api.dll"]