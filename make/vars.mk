APP ?= gen_config

BASE_DIR := $(shell pwd)
REBAR_REPO ?= https://github.com/rebar/rebar.git
REBAR ?= $(BASE_DIR)/rebar
DEPS ?= deps
