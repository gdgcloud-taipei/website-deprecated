run:
	docker run -d --name gcpugtaipei --rm -ti -v $(PWD):/src -p 1313:1313 -u hugo klakegg/hugo:0.53 server -w --bind=0.0.0.0

# ex: make new GDGCloud Taipei meetup 47 -> /src/content/blog/gcpug-taipei-meetup-47/index.md created
args=`arg="$(filter-out $@,$(MAKECMDGOALS))" && echo $${arg:-${1}}`
new:
	docker exec gcpugtaipei hugo new --kind post-bundle content/blog/$(shell docker run -it --rm vandot/casbab kebab "$(call args,defaultstring)")

build:
	docker exec -it gcpugtaipei hugo
	printf 'taipei.gdgcloud.tw' > public/CNAME	

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

deploy-key:
	gcloud kms encrypt --plaintext-file=/Users/cage/.ssh/id_rsa --ciphertext-file=./gcpugtaipei.github.io.enc --location=global --keyring gcpugtaipei-website --key gcpugtaipei-github-io-key