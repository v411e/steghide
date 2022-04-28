Hide a file
````bash
docker compose run app embed -ef test.txt -cf zwiebeln.wav -p "password" -sf zwiebelversteck.wav
````

Extract the file
````bash
docker compose run app extract -p "password" -sf zwiebelversteck.wav -xf versteckteszeug.txt
````

