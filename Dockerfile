# Etapa de compilación
FROM node:20-alpine AS build
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .
RUN npm run build

# Etapa de producción
FROM nginx:alpine
# Esta línea busca la carpeta de salida (dist o build) automáticamente
COPY --from=build /app/dist /usr/share/nginx/html
# Si tu proyecto usa 'build' en vez de 'dist', cambia la línea anterior por:
# COPY --from=build /app/build /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]