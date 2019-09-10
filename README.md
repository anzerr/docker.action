
### `Intro`
github action to login, build and push to a registry

### `Example`
``` yaml
jobs:
  docker:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v1
      - uses: anzerr/docker.action@master
        with:
          username: ${{ secrets.DOCKER_USERNAME }}
          password: ${{ secrets.DOCKER_PASSWORD }}
          registry: docker.pkg.github.com
          args: |
            docker build -t $(gha name -r -u anzerr -t app) -t $(gha name -r -u anzerr -t app -v latest) . &&
            docker push $(gha name -r -u anzerr -t app) &&
            docker push $(gha name -r -u anzerr -t app -v latest)
      - uses: anzerr/docker.action@master
        with:
          username: ${{ secrets.DOCKER_USERNAME }}
          password: ${{ secrets.DOCKER_HUB_PASSWORD }}
          args: |
            docker build -t $(gha name -u anzerr) -t $(gha name -u anzerr -v latest) . &&
            docker push $(gha name -u anzerr) &&
            docker push $(gha name -u anzerr -v latest)
```