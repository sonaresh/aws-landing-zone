TF ?= terraform
VARS ?= ../env/lab.auto.tfvars

.PHONY: fmt
fmt:
	$(TF) fmt -recursive

define RUN_STACK
	$(TF) -chdir=$(1) init
	$(TF) -chdir=$(1) plan  -var-file=$(VARS)
endef

define APPLY_STACK
	$(TF) -chdir=$(1) apply -var-file=$(VARS)
endef

define DESTROY_STACK
	$(TF) -chdir=$(1) destroy -var-file=$(VARS)
endef

plan-governance:
	$(call RUN_STACK,01-governance)

apply-governance:
	$(call APPLY_STACK,01-governance)

plan-identity:
	$(call RUN_STACK,02-identity)

apply-identity:
	$(call APPLY_STACK,02-identity)

plan-security:
	$(call RUN_STACK,03-security-baseline)

apply-security:
	$(call APPLY_STACK,03-security-baseline)

plan-backup:
	$(call RUN_STACK,04-backup-policies)

apply-backup:
	$(call APPLY_STACK,04-backup-policies)

plan-dr:
	$(call RUN_STACK,06-regional/us-east-2)

apply-dr:
	$(call APPLY_STACK,06-regional/us-east-2)

plan-security-lake:
	$(call RUN_STACK,90-optional-expensive/security-lake)

apply-security-lake:
	$(call APPLY_STACK,90-optional-expensive/security-lake)

destroy-security-lake:
	$(call DESTROY_STACK,90-optional-expensive/security-lake)
