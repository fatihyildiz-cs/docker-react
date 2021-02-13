# first phase
# phase that builds the application (the static files to be served by nginx)
# this phase outputs the "build" folder in the working directory (/app/build)
# this "build" folder is the only thing we care about
FROM node:alpine
WORKDIR '/app'
COPY package.json .
RUN npm install
COPY . .
RUN npm run build

# second phase
# all phases can only have 1 from statement. 
# so it knows that a new phase is being started and drops the previous one.
# default command of the nginx image will start the nginx, so no need to specify a command
FROM nginx
# aws elasticbeanstalk maps to this port
EXPOSE 80
COPY --from=0 /app/build /usr/share/nginx/html