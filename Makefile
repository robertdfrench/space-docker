SD_ROOT=$(PWD)
SD_SHARED=$(SD_ROOT)/shared

$(SD_SHARED)/client.singularityimg: host.dockerimg $(SD_SHARED)/Singularity
	docker run --privileged host.dockerimg singularity create $(SD_SHARED)/client.singularityimg
	docker run --privileged host.dockerimg singularity bootstrap $(SD_SHARED)/client.singularityimg $(SD_SHARED)/Singularity

host.dockerimg: Dockerfile
	docker build -t=host.dockerimg .

$(SD_SHARED)/Singularity: Singularity $(SD_SHARED)
	cp Singularity $(SD_SHARED)

$(SD_SHARED):
	mkdir -p $(SD_SHARED)

clean:
	rm -rf shared
	rm host.dockerimg
