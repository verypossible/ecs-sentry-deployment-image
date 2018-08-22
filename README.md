# ecs-sentry-deployment-image

Docker image for use with deployments to AWS ECS

This is a simple image which can be used as a base image in CircleCI to deploy updated Docker
images to ECS using either:

- [ECS Deploy (Python)](https://github.com/fabfuel/ecs-deploy) (recommanded)
- [ecs-deploy (bash)](https://github.com/silinternational/ecs-deploy).

The Python implemention has more capabilities and has proven to work well, which is why it's our
recommendation.

It also contains [sentry-cli](https://github.com/getsentry/sentry-cli) to set releases in Sentry.

# Example

A CircleCI config could have a deploy step with the following:

```
  deploy:
    docker:
      - image: verypossible/ecs-sentry-deployment-image:latest
    steps:
      - checkout
      - run: |
          RELEASE=$(date -u +'%y.%m.%dT%H:%M:%S').$(git rev-parse --short HEAD)

          sentry-cli releases new $RELEASE
          sentry-cli releases set-commits --auto $RELEASE
          start=$(date +%s)

          ecs deploy $ECS_CLUSTER $ECS_SERVICE -i web 12345.dkr.ecr.us-east-1.amazonaws.com/yourrepo:TAG --timeout 300

          now=$(date +%s)
          sentry-cli releases deploys $RELEASE new -e prod -t $((now-start))
          sentry-cli releases finalize $RELEASE
```

Doing this with the `bash` version `ecs-deploy` would look like:

```
ecs-deploy -i 12345.dkr.ecr.us-east-1.amazonaws.com/yourrepo:TAG -c cluster-name -n service-name -t 300
```

# Building

To build this yourself and push it to your own repo, open up the `Makefile` and adjust the `NAME`
argument to suit your needs. Then:

```bash
> make
> make push
```

