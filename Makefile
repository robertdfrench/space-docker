test: penis.img shared
	docker run penis.img singularity --debug create /Users/rf9/Projects/space-docker/shared/ponis.img

penis.img: Dockerfile
	docker build -t=penis.img .

shared:
	mkdir -p shared

clean:
	rm -rf shared
	rm penis.img
