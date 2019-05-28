run:
	docker run -d --name gcpugtaipei --rm -ti -v `pwd`:`pwd` -w `pwd` -p 1313:1313 monachus/hugo:v0.53

build:
	# rm -rf public 	
	docker exec -it gcpugtaipei hugo
	printf 'taipei.gcpug.tw' > public/CNAME	

build_and_analyse:
	docker exec gcpugtaipei hugo && cd scripts && ./analyse.sh

analyse:
	cd scripts && ./analyse.sh

algoliasearch:
	cd scripts && python hugo_algolia.py ALGOLIA_API_KEY=$ALGOLIA_API_KEY

cloudbuild-local-docker-image:
	cd scripts && cloud-build-local --config cloudbuild.yaml --dryrun=false --write-workspace=./tmp .	

cloudbuild-local:
	cloud-build-local --config cloudbuild.yaml --dryrun=false --write-workspace=./tmp .	

prepare-algolia-api-key:
	# prepare cloudbuild.yaml ALGOLIA_API_KEY base64 string
	echo -n $ALGOLIA_API_KEY | gcloud kms encrypt --location global --keyring gcpugtaipei-website --key algolia --plaintext-file=- --ciphertext-file=- | base64