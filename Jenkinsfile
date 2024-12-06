pipeline{
	agent any
	environment{
		PROJECT_ID = 'my-project-01-418111'
		CLUSTER_NAME = 'kube'
		LOCATION = 'asia-northeast3-a'
		CREDENTIALS_ID = '22705cf8-ea10-47f2-ba4c-49e98416bdfa'
	}
	stages{
		stage("Checkout code"){
			steps{
				checkout scm
			}
		}
		stage("Build image"){
			steps{
				script{
					myapp = docker.build("hongyjin/yorijori:${env.BUILD_ID}")
					}
				}
			}
		stage("Push image"){
			steps{
				script{
					docker.withRegistry('https://registry.hub.docker.com', 'dockerhub'){
						myapp.push("latest")
						myapp.push("${env.BUILD_ID}")
						}
					}
				}
			}
		stage("Deploy to GKE"){
			when{
				branch 'master'
			}
			steps{
				sh "sed -i 's/yorijori:latest/yorijori:${env.BUILD_ID}/g' deployment.yaml"
			step([$class: 'KubernetesEngineBuilder', projectId: env.PROJECT_ID, clusterName: env.CLUSTER_NAME, location: env.LOCATION, manifestPattern: 'deployment.yaml', credentialsId: env.CREDENTIALS_ID, verifyDeployments: true])
				}
			}
		
		}
	}
