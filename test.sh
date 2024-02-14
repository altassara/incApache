#!/bin/bash

# Numero di connessioni da aprire
numero_connessioni=5

# Numero di richieste da eseguire per ciascuna connessione
numero_richieste_per_connessione=10

# URL di destinazione
url="http://localhost:8000"

# Funzione per eseguire richieste in pipeline
esegui_richieste() {
    connessione=$1
    for ((i=1; i<=numero_richieste_per_connessione; i++)); do
        # Esegui la richiesta GET e stampa il numero della connessione e il codice di stato
        curl -s -o /dev/null -w "Connessione $connessione - Richiesta $i: Status Code - %{http_code}\n" "$url"
    done
}

# Esegui connessioni multiple in background
for ((j=1; j<=numero_connessioni; j++)); do
    esegui_richieste $j &
done

# Attendi che tutte le connessioni siano completate
wait

echo "Richieste completate."