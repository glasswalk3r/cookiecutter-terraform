# These are just samples. Add and change whatever is necessary
CONFIG=../environment.tfvars

check:
		@if [ -z ${AWS_PROFILE} ]; then echo -e '\n\e[31mPlease first \e[5mexport\e[25m AWS_PROFILE, aborting...\e[0m'; exit 1; fi
lint:
		terraform validate
		terraform fmt -diff
{{ cookiecutter.resource_type }}: lint check
		terraform apply -var-file=$(CONFIG)
init: check
		terraform init -backend-config $(CONFIG)
destroy:
		terraform destroy -var-file=$(CONFIG)

