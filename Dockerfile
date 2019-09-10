FROM anzerr/node:12 as node
FROM docker:19.03.2 as runtime
LABEL "com.github.actions.name"="Docker util"
LABEL "com.github.actions.description"="publish docker image"
LABEL "com.github.actions.icon"="anchor"
LABEL "com.github.actions.color"="blue"

LABEL "repository"="https://github.com/anzerr/docker.action"
LABEL "maintainer"="anzerr"

RUN apk update \
  && apk upgrade \
  && apk add --no-cache git

COPY --from=node /usr/local/bin/node /usr/local/bin/
COPY --from=node /usr/local/lib/* /usr/local/lib/
COPY --from=node /opt/* /opt/
COPY --from=node /usr/lib/libgcc* /usr/lib/libstdc* /usr/lib/
RUN ln -s /usr/local/lib/npm/bin/npm-cli.js /usr/local/bin/npm && \
	ln -s /usr/local/lib/npm/bin/npx-cli.js /usr/local/bin/npx && \
	chmod +x /usr/local/bin/npm /usr/local/bin/npx && \
	npm i -g git+https://git@github.com/anzerr/gha.cli.git

ADD entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]