FROM hotio/mono@sha256:8dd109c26d38571a742e720e55510285d0511496615627086c2d88ddc0400440

ARG DEBIAN_FRONTEND="noninteractive"

EXPOSE 8989

ARG BRANCH
ARG VERSION
ARG PACKAGE_VERSION=${VERSION}
RUN mkdir "${APP_DIR}/bin" && \
    curl -fsSL "https://github.com/danimart1991/Sonarr/releases/download/${BRANCH}.${VERSION}/Sonarr.${BRANCH}.${VERSION}.linux.tar.gz" | tar xzf - -C "${APP_DIR}/bin" && \
    rm -rf "${APP_DIR}/bin/Sonarr.Update" && \
    echo "PackageVersion=${PACKAGE_VERSION}\nPackageAuthor=[danimart1991](https://github.com/danimart1991)\nUpdateMethod=Docker\nBranch=${BRANCH}" > "${APP_DIR}/package_info" && \
    chmod -R u=rwX,go=rX "${APP_DIR}"

COPY root/ /