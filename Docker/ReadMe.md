 Here are the steps to update the Dockerfile and build a Docker image:

1.     Build the Docker image locally using the following command in the terminal, where intuitive-lab-df is the name you want to give to your Docker image and . refers to the current directory:
	
	Command # docker build -t intuitive-lab-df .

2. Using the Docker image, create and start a container using the following command, where cont-intuitive-lab-df is the name you want to give to your container and intuitive-lab-df is the name of the Docker image:

	Command # docdocker run -d --name cont-intuitive-lab-df intuitive-lab-df
	
3. To upload the Docker image to DockerHub registry:

	Command #  docker push patidar.systeme/intuitive-lab-df:latest