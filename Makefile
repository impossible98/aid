SHELL := /bin/bash
# 定义常量
COLOR_RESET ?= \033[0m
COLOR_GREEN ?= \033[32;01m
# 定义变量
PYTHON_VERSION := $(shell python --version | awk '{print $$2}')
PIP_VERSION := $(shell pip --version | awk '{print $$2}')
# 启动开发服务器
dev: install
	uvicorn main:app --reload
# 确保依赖是最新的
install: version
	pip install --quiet --requirement requirements.txt
# 查看提交历史记录
log:
	git log --oneline --decorate --graph --all
# 推送代码
push:
	git push
	git push --tags
# 启动服务器
start:
	uvicorn main:app --host 0.0.0.0 --port 6453
# 打印版本信息
version:
	@echo -e "$(COLOR_GREEN)"
	@echo "=============================="
	@echo "  Python: v$(PYTHON_VERSION) $(shell which python)"
	@echo "  pip:    v$(PIP_VERSION) $(shell which pip)"
	@echo "=============================="
	@echo -e "$(COLOR_RESET)"
