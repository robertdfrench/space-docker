SD_ROOT=$(PWD)
SD_SHARED=$(SD_ROOT)/shared
DOCKER_RUN=docker run --privileged --mount type=bind,source="$(SD_SHARED)",target=/shared

$(SD_SHARED)/.bootstrap: host.dockerimg $(SD_SHARED)/client.singularityimg $(SD_SHARED)/Singularity
	$(DOCKER_RUN) host.dockerimg singularity bootstrap /shared/client.singularityimg $(SD_SHARED)/Singularity
	touch $(SD_SHARED)/.bootstrap

$(SD_SHARED)/client.singularityimg: host.dockerimg
	$(DOCKER_RUN) host.dockerimg singularity create /shared/client.singularityimg

host.dockerimg: Dockerfile $(SD_SHARED)
	docker build -t=host.dockerimg .
	touch host.dockerimg

$(SD_SHARED)/Singularity: Singularity $(SD_SHARED)
	cp Singularity $(SD_SHARED)

$(SD_SHARED):
	mkdir -p $(SD_SHARED)

clean:
	rm -rf shared
	rm -f host.dockerimg
