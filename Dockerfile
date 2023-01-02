FROM dart:stable AS build

# Resolve app dependencies.
WORKDIR /app
COPY pubspec.* ./
RUN dart pub get

# Copy app source code and AOT compile it.
COPY . .
# Ensure packages are still up-to-date if anything has changed
RUN dart pub get --offline
RUN dart compile exe bin/server.dart -o bin/server

# Build minimal serving image from AOT-compiled `/server` and required system
# libraries and configuration files stored in `/runtime/` from the build stage.
FROM scratch
COPY --from=build /runtime/ /
COPY --from=build /app/bin/server /app/bin/

# Inject environment variables.
ARG BOT_TOKEN
ENV BOT_TOKEN=$BOT_TOKEN
ARG HOST_URL
ENV HOST_URL=$HOST_URL
ARG BOT_PORT
ENV BOT_PORT=$BOT_PORT
ARG SERVER_PORT
ENV SERVER_PORT=$SERVER_PORT
ARG MYID
ENV MYID=$MYID

# Start server.
EXPOSE 8443
CMD ["/app/bin/server"]
