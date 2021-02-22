FROM hotio/mono@sha256:1414e5d40ecfb932ad6babadd8adf239ff574a9b05a28ca0c822314e6bbc64ec

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