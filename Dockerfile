# # Normal image build
# FROM openjdk:11
# WORKDIR /boot/app
# COPY gradlew .
# COPY gradle gradle
# COPY build.gradle .
# COPY settings.gradle .
# COPY src src
# RUN chmod +x ./gradlew
# RUN ls
# RUN ./gradlew clean build
# RUN ls
# ARG JAR_FILE="/build/libs/*.jar"
# COPY ${JAR_FILE} demo.jar
# EXPOSE 8080
# ENTRYPOINT ["java", "-jar", "demo.jar"]

# Multistage pipeline
FROM openjdk:11-jdk-slim-bullseye AS base
LABEL maintainer="sloppy-jerry-choI"
LABEL description="multi stage pipeline practice"

# build
FROM base AS build
WORKDIR /boot/app
COPY gradlew .
COPY gradle gradle
COPY build.gradle .
COPY settings.gradle .
COPY src src
RUN chmod +x ./gradlew
RUN ./gradlew clean bootJar
RUN mkdir -p build/dependency && (cd build/dependency; jar -xf ../libs/*-SNAPSHOT.jar)

# build된 결과물로 image build
FROM base
VOLUME /tmp
ARG DEPENDENCY="/boot/app/build/dependency"
COPY --from=build ${DEPENDENCY}/BOOT-INF/lib /app/lib
COPY --from=build ${DEPENDENCY}/META-INF /app/META-INF
COPY --from=build ${DEPENDENCY}/BOOT-INF/classes /app
ENTRYPOINT ["java","-cp","app:app/lib/*","com.example.demo.DemoApplication"]
