# -*- coding: utf-8 -*-
# @Author: Tasdik Rahman
# @Date:   2016-03-12
# @Last Modified by:   Tasdik Rahman
# @Last Modified time: 2016-04-05 16:32:19
# @GPLv3 License
# @http://tasdikrahman.me
# @https://github.com/prodicus/plino

clean:
	-find . -name '*.pyc' -delete
	-find . -name '__pycache__' -delete

run: clean
	# to be used when testing locally
	gunicorn --pythonpath plino app:app

build: clean
	# deploys app to heroku as well pushes the latest commits to the github
	# remote
	git push -u origin master
	git push -u heroku master

.PHONY: help
help:
	@echo "\nPlease call with one of these targets:\n"
	@$(MAKE) -pRrq -f $(lastword $(MAKEFILE_LIST)) : 2>/dev/null | awk -v RS= -F:\
        '/^# File/,/^# Finished Make data base/ {if ($$1 !~ "^[#.]") {print $$1}}'\
        | sort | egrep -v -e '^[^[:alnum:]]' -e '^$@$$' | xargs | tr ' ' '\n' | awk\
        '{print "    - "$$0}'
	@echo "\n"
