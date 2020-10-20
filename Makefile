build:
	docker build -t blur-service .
	cd controller && docker build -t blur-worker .

rabbitmq:
	docker run \
		-it \
		--rm \
		--name rabbitmq \
		--network net-blur \
		-p 5672:5672 \
		-p 15672:15672 \
		rabbitmq:3-management
run:
	docker run \
		--name blur-service \
		--network net-blur \
		--mount type=bind,source=/Users/marcelo/source-images,target=/source-images \
		-p 8080:8080 \
		blur-service &
	docker run \
		--name blur-worker \
		--network net-blur \
		--mount type=bind,source=/Users/marcelo/source-images,target=/source-images \
		--mount type=bind,source=/Users/marcelo/blurred-images,target=/blurred-images \
		blur-worker

stop:
	docker stop blur-service
	docker stop blur-worker

rm:
	docker rm blur-service
	docker rm blur-worker


		
# docker run -it --rm --name rabbitmq --network net-blur -p 5672:5672 -p 15672:15672 rabbitmq:3-management
# docker run --rm --name blur-service --network net-blur --mount type=bind,source=/Users/marcelo/source-images,target=/source-images -p 8080:8080 blur-service
# docker run --rm --name blur-worker --network net-blur --mount type=bind,source=/Users/marcelo/source-images,target=/source-images --mount type=bind,source=/Users/marcelo/blurred-images,target=/blurred-images blur-worker



# docker run --rm --name blur-service --network net-blur -v source-images:/source-images -p 8080:8080 blur-service
# docker run --rm --name blur-worker --network net-blur -v source-images:/source-images -v blurred-images:/blurred-images blur-worker
