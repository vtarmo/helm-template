deploy:
	@helm dependency update helm-template
	@helm package helm-template
	@mv ./helm-template-*.tgz docs
	@helm repo index docs --url https://vtarmo.github.io/helm-template
	
	