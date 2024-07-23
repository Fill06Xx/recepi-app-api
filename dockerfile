#file docker

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

#eseguire il comando sull'immagine 
#-m venv /py && \ crea un ambiente virtuale to store the dependencis
RUN python -m venv /py && \
    # comando in cui specifichiamo l'intero percorso dell' ambiente virtuale per upgadare pip
    /py/bin/pip install --upgrade pip && \
    #comando che installa i file richiesti nell'immagine di docker
    /py/bin/pip install -r /tmp/requirements.txt && \
    #rimozione directori temporanea (si rimuove per non avere dipendenze extra sull'immagine)
                    #è buona pratica tenere il più leggero possibiule l'mmagine di docker
    rm -rf /tmp && \
    # add user command aggiunge un nuovo user all'immagine (si crea un alto user per non usare il root user <ha autorizzazioni e permetti a tutto il server>)
    adduser \
        #disabbilita password perchè non vogliamo che gli utenti possano reggistrarsi 
        --disabled-password \ 
        #non si crea la home directory per mantenere leggera l'immagine di docker
        --no-create-home \
        # si specifica il nomedell'utente
        django-user

# ENV aggiorna le variabili nell'immagine e ggiorna il percorso delle variabili 
#qundo vogliamo eseguire un comando nel progetto non c'è bisogno di specificare l'intero percorso ma basta solo /py
ENV PATH="/py/bin:$PATH"

#specifica utente su cui stiamo cambiando
USER django-us