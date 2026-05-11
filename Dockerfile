# Etapa 1: Construcción
FROM node:20-alpine AS build
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .
RUN npm run build

# Etapa 2: Servidor de Producción (Nginx)
FROM nginx:alpine
# Copiamos los archivos estáticos desde la etapa de build
COPY --from=build /app/dist /usr/share/nginx/html
# Configuración de puerto
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]