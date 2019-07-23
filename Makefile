package=cloud
UNAME=$(shell uname)
VERSION=`head -1 VERSION`

GIT=https://github.com/cloudmesh
COMMUNITY=$(GIT)-community

HERCULES=docker run --rm srcd/hercules hercules
LABOURS=docker run --rm -i -v $(pwd):/io srcd/hercules labours

define banner
	@echo
	@echo "###################################"
	@echo $(1)
	@echo "###################################"
endef

all:
	$(call banner, "use: make doc")

dest/gitinspector/gitinspector.py:
	mkdir -p dest
	cd dest; git clone https://github.com/ejwa/gitinspector.git

inspect-book:
	python dest/gitinspector/gitinspector.py \
	   $(COMMUNITY)/book \
	   --grading=True \
	   --metrics=False \
	   --hard=True \
	   --format=htmlembedded > docs-source/source/inspector/book.html
	cp -r docs-source/source/inspector docs/inspector

inspect: dest/gitinspector/gitinspector.py
	python dest/gitinspector/gitinspector.py \
	   $(GIT)/cloudmesh-cloud \
	   --grading=True \
	   --metrics=False \
	   --hard=True \
	   --format=htmlembedded > docs-source/source/inspector/cloudmesh-cloud.html
	python dest/gitinspector/gitinspector.py \
	   $(GIT)/cloudmesh-cmd5 \
	   --grading=True \
	   --metrics=False \
	   --hard=True \
	   --format=htmlembedded > docs-source/source/inspector/cloudmesh-cmd5.html
	python dest/gitinspector/gitinspector.py \
	   $(GIT)/cloudmesh-common \
	   --grading=True \
	   --metrics=False \
	   --hard=True \
	   --format=htmlembedded > docs-source/source/inspector/cloudmesh-common.html
	python dest/gitinspector/gitinspector.py \
	   $(GIT)/cloudmesh-sys \
	   --grading=True \
	   --metrics=False \
	   --hard=True \
	   --format=htmlembedded > docs-source/source/inspector/cloudmesh-sys.html
	python dest/gitinspector/gitinspector.py \
	   $(GIT)/cloudmesh-manual \
	   --grading=True \
	   --metrics=False \
	   --hard=True \
	   --format=htmlembedded > docs-source/source/inspector/cloudmesh-manual.html
	python dest/gitinspector/gitinspector.py \
	   $(GIT)/cloudmesh-storage \
	   --grading=True \
	   --metrics=False \
	   --hard=True \
	   --format=htmlembedded > docs-source/source/inspector/cloudmesh-storage.html
	python dest/gitinspector/gitinspector.py \
	   $(GIT)/cloudmesh-installer \
	   --grading=True \
	   --metrics=False \
	   --hard=True \
	   --format=htmlembedded > docs-source/source/inspector/cloudmesh-installer.html
	cp -r docs-source/source/inspector docs/inspector

contrib:
	git config --global mailmap.file .mailmap
	bin/authors.py

names:
	git config --global mailmap.file .mailmap
	make -f Makefile names-dir > .names.txt
	sort -u .names.txt > names.txt
	cat names.txt

names-dir:
	@cd ../cloudmesh-cmd5; git log | fgrep Author
	@cd ../cloudmesh-common; git log | fgrep Author
	@cd ../cloudmesh-sys; git log | fgrep Author
	@cd ../cloudmesh-openapi; git log | fgrep Author
	@cd ../cloudmesh-emr; git log | fgrep Author
	@cd ../cloudmesh-cloud; git log | fgrep Author
	@cd ../cloudmesh-storage; git log | fgrep Author
	@cd ../cloudmesh-manual; git log | fgrep Author

source:
	cd ../cloudmesh.common; make source
	$(call banner, "Install cloudmesh-cmd5")
	pip install -e . -U
	cms help

install:
	cd ..; cloudmesh-installer git pull storage
	cd ..; cloudmesh-installer install storage -e
	cd ../cloudmesh-batch ; git pull; pip install -e .
	cd ../cloudmesh-emr ; git pull; pip install -e .


manual-new:
	mkdir -p docs-source/source/manual/flow
	cms man --kind=rst flow > docs-source/source/manual/flow/flow.rst
	mkdir -p docs-source/source/manual/openapi
	cms man --kind=rst openapi > docs-source/source/manual/openapi/openapi.rst


CMD5_COMMAND= admin banner clear echo default info pause plugin \
              q quit shell sleep stopwatch sys var version

COMPUTE_COMMAND= open vbox vcluster batch vm ip key secgroup image \
                 flavor ssh workflow yaml service config container group

STORAGE_COMMAND= storage vdir

manual:
	mkdir -p docs-source/source/manual
	cms help > /tmp/commands.rst
	echo "Commands" > docs-source/source/manual/commands.rst
	echo "========" >> docs-source/source/manual/commands.rst
	echo  >> docs-source/source/manual/commands.rst
	tail -n +4 /tmp/commands.rst >> docs-source/source/manual/commands.rst
	#
	# CMD5
	#
	mkdir -p docs-source/source/manual/cmd5
	for c in $(CMD5_COMMAND) ; do \
	  echo Generate man page for $$c ; \
	  cms man --kind=rst $$c > docs-source/source/manual/cmd5/$$c.rst; \
	done
	#
	# GROUP
	#
	mkdir -p docs-source/source/manual/group
	cms man --kind=rst group > docs-source/source/manual/group/group.rst
	#
	# COMPUTE
	#
	mkdir -p docs-source/source/manual/compute
	for c in $(COMPUTE_COMMAND) ; do \
	  echo Generate man page for $$c ; \
	  cms man --kind=rst $$c > docs-source/source/manual/compute/$$c.rst; \
	done

	#
	# STORAGE
	#
	mkdir -p docs-source/source/manual/storage
	for c in $(STORAGE_COMMAND) ; do \
	  echo Generate man page for $$c ; \
	  cms man --kind=rst $$c > docs-source/source/manual/storage/$$c.rst; \
	done

authors:
	bin/authors.py > docs-source/source/preface/authors.md

doc: authors
	mv ~/.cloudmesh/cloudmesh4.yaml ~/.cloudmesh/cloudmesh4.yaml-tmp 
	mv ~/.cloudmesh/cloudmesh.yaml ~/.cloudmesh/cloudmesh.yaml-tmp 
	wget -P ~/.cloudmesh https://raw.githubusercontent.com/cloudmesh/cloudmesh-cloud/master/cloudmesh/etc/cloudmesh4.yaml
	wget -P ~/.cloudmesh https://raw.githubusercontent.com/cloudmesh/cloudmesh-common/master/cloudmesh/etc/cloudmesh.yaml
	rm -rf docs
	mkdir -p dest
	cd docs-source; make html
	cp -r docs-source/source/_ext docs-source/build/html
	cp -r docs-source/source/_templates docs-source/build/html
	cp -r docs-source/build/html/ docs
	mv ~/.cloudmesh/cloudmesh4.yaml-tmp ~/.cloudmesh/cloudmesh4.yaml
	mv ~/.cloudmesh/cloudmesh.yaml-tmp ~/.cloudmesh/cloudmesh.yaml


pdf: authors
	mv ~/.cloudmesh/cloudmesh4.yaml ~/.cloudmesh/cloudmesh4.yaml-tmp 
	mv ~/.cloudmesh/cloudmesh.yaml ~/.cloudmesh/cloudmesh.yaml-tmp 
	wget -P ~/.cloudmesh https://raw.githubusercontent.com/cloudmesh/cloudmesh-cloud/master/cloudmesh/etc/cloudmesh4.yaml
	wget -P ~/.cloudmesh https://raw.githubusercontent.com/cloudmesh/cloudmesh-common/master/cloudmesh/etc/cloudmesh.yaml
	rm -rf docs
	mkdir -p dest
	cd docs-source; make latex
	cd docs-source/build/latex; make
	mv ~/.cloudmesh/cloudmesh4.yaml-tmp ~/.cloudmesh/cloudmesh4.yaml
	mv ~/.cloudmesh/cloudmesh.yaml-tmp ~/.cloudmesh/cloudmesh.yaml


view:
	open docs/index.html

nist-install: nist-download nist-copy

nist-download:
	rm -rf ../nist
	git clone https://github.com/davidmdem/nist ../nist


nist-copy:
	cd cm4/api; rm -rf specs; mkdir specs;
	rsync -a --prune-empty-dirs --include '*/' --include '*.yaml' --exclude '*' ../nist/services/ ./cm4/api/specs/


#
# TODO: BUG: This is broken
#
#pylint:
#	mkdir -p docs/qc/pylint/cm
#	pylint --output-format=html cloudmesh > docs/qc/pylint/cm/cloudmesh.html
#	pylint --output-format=html cloud > docs/qc/pylint/cm/cloud.html

clean:
	$(call banner, "CLEAN")
	rm -rf dist
	rm -rf *.zip
	rm -rf *.egg-info
	rm -rf *.eggs
	rm -rf docs-source/build
	rm -rf build
	find . -type d -name __pycache__ -delete
	find . -name '*.pyc' -delete
	rm -rf .tox
	rm -f *.whl
	rm -f ./docs/_sources/todo.md.txt ./docs/_sources/todo.rst.txt
	rm -f ./docs/todo.html

######################################################################
# .cloudmesh
######################################################################

user:
	echo "look at the makefile"
#  - mkdir -p ~/.cloudmesh
#  - wget -P ~/.cloudmesh https://raw.githubusercontent.com/cloudmesh/cloudmesh-common/master/cloudmesh/etc/cloudmesh.yaml
#  - wget -P ~/.cloudmesh https://raw.githubusercontent.com/cloudmesh/cloudmesh-cloud/master/cloudmesh/etc/cloudmesh4.yaml
#  - wget -P ~/.cloudmesh https://raw.githubusercontent.com/cloudmesh/cloudmesh-inventory/master/cloudmesh/inventory/etc/inventory.yaml

######################################################################
# PYPI
######################################################################


twine:
	pip install -U twine

dist:
	python setup.py sdist bdist_wheel
	twine check dist/*

patch: clean
	$(call banner, "bbuild")
	bump2version --no-tag --allow-dirty patch
	python setup.py sdist bdist_wheel
	git push
	# git push origin master --tags
	twine check dist/*
	twine upload --repository testpypi  dist/*
	# $(call banner, "install")
	# sleep 10
	# pip install --index-url https://test.pypi.org/simple/ cloudmesh-$(package) -U
	make
	git commit -m "update ocumentation" docs
	git push

minor: clean
	$(call banner, "minor")
	bump2version minor --allow-dirty
	@cat VERSION
	@echo

release: clean
	$(call banner, "release")
	git tag "v$(VERSION)"
	git push origin master --tags
	python setup.py sdist bdist_wheel
	twine check dist/*
	twine upload --repository pypi dist/*
	$(call banner, "install")
	@cat VERSION
	@echo
	#sleep 10
	#pip install -U cloudmesh-common


dev:
	bump2version --new-version "$(VERSION)-dev0" part --allow-dirty
	bump2version patch --allow-dirty
	@cat VERSION
	@echo

reset:
	bump2version --new-version "4.0.0-dev0" part --allow-dirty

upload:
	twine check dist/*
	twine upload dist/*

pip:
	pip install --index-url https://test.pypi.org/simple/ cloudmesh-$(package) -U

#	    --extra-index-url https://test.pypi.org/simple

log:
	$(call banner, log)
	gitchangelog | fgrep -v ":dev:" | fgrep -v ":new:" > ChangeLog
	git commit -m "chg: dev: Update ChangeLog" ChangeLog
	git push
