FROM python:3.7.3-alpine3.9

ADD . /
RUN pip install -r /requirements.txt

ENTRYPOINT [ "python", "/hugo_algolia.py", "/workspace/public/algolia.json"]
