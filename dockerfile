#versione specifica di python
FROM python:3.9-alpine3.13 
#chi mantiene il codice
LABEL maintainer="Fill06Xx"

#raccomandato per eseguire python in un conteiner docker. in questo modo l'output di pyton verrà stampato direttamente alla console
ENV PUTHONBUFFERED 1

#copio i requisiti da locale a docker per installarli
COPY ./requirements.txt /tmp/requirements.txt
#copio la directory dell'app in docker
COPY ./app /app
#directori di defoult che eseguiamo quando facciamo comandi su docker
WORKDIR /app
EXPOSE 8000

#eseguire il comando di esecuzione
RUN python -m venv /py && \
    /py/bin/pip install --upgrade pip && \
    /py/bin/pip install -r /tmp/requirements.txt && \
    rm -rf /tmp && \
    adduser \
        --disabled-password \ 
        --no-create-home \
        django-user

ENV PATH="/py/bin:$PATH"

USER django-us