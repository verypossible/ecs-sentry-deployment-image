# ecs-sentry-deployment-image

Docker image for use with deployments to AWS ECS

This is a simple image which can be used as a base image in CircleCI to deploy updated Docker
images to ECS using [ecs-deploy](https://github.com/silinternational/ecs-deploy).

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

          ecs-deploy -i 12345.dkr.ecr.us-east-1.amazonaws.com/yourrepo:ABC123 -c cluster-name -n service-name -t 300

          now=$(date +%s)
          sentry-cli releases deploys $RELEASE new -e prod -t $((now-start))
          sentry-cli releases finalize $RELEASE
```
