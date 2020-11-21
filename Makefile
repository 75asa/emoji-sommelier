# variables ----

	STAGE := dev
	SERVICE_NAME := emoji-syncher
	PROJECT := emoji-syncher

# docker -------

buildup:
	docker-compose up -d --build
up:
	docker-compose up -d
downv:
	docker-compose down -v
down:
	docker-compose down
ps:
	docker-compose ps
restart:
	docker-compose restart

# gcloud -------

push-gcr:
	export STAGE=$(STAGE)
	export PROJECT=$(PROJECT)
	gcloud builds submit \
  --project="$(PROJECT)" \
  --config cloudbuild.yml
deploy-gcr:
	export STAGE=$(STAGE)
	export SERVICE_NAME=$(SERVICE_NAME)
	export PROJECT=$(PROJECT)
	gcloud run deploy $(SERVICE_ANME) \
  --project="$(PROJECT)" \
  --image="gcr.io/$(PROJECT)/$(SERVICE_NAME)/$(STAGE)" \
  --platform=managed \
  --region=asia-northeast1 \
  --allow-unauthenticated
open-gcr:
	open https://console.cloud.google.com/run?hl=ja&project=$(PROJECT)

