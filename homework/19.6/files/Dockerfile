FROM centos/python-38-centos7

COPY requirements.txt requirements.txt
RUN pip3 install -r requirements.txt

RUN mkdir python-api
COPY python-api.py python-api/python-api.py
CMD ["python3", "python-api/python-api.py"]