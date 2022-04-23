install:
	pip install --upgrade pip &&\
		pip install -r requirements.txt
post-install:
	python -m textblob.download_corpora
	python -c "import nltk; nltk.download('all')"
	
test:
	#test
	python -m pytest -vv --cov=mylib --cov=main test_*.py
build:
	#build container
	docker build -t deploy-fastapi .
format:
	#black *.py
	black *.py mylib/*.py


lint:
	#pylint --disable=R,C hello.py
	pylint --disable=R,C *.py mylib/*.py

all: install post-install lint test
	#install lint test
	#deploy