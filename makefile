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

publish:
	cd public && git add . && git ci --amend --no-edit && git push origin -f master