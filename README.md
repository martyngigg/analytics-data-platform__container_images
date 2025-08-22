# Analytics Data Platform: Container Images

This repository stores scripts to build and publish custom container images required for
[ISIS Analytics Data Platform](https://github.com/ISISNeutronMuon/analytics-data-platform/).

To build and an image:

```sh
> ./build-image dockerfile_dir
```

The fully qualified image name will be printed at the end of the build.

To publish an image, create credentials for the container registry:

```sh
> cp dotenv.sample .env
> # Edit the new '.env' file and supply your credentials...
```

This only needs to be done once:

```sh
> source .env  # activates credentials (do once per shell session)
> ./push-image fully_qualified_image_name
```
