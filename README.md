This container contains a script for performing batch steganography on files with **steghide**.

This would embed the file `embed_file.txt` into every `.wav` file of the `/data` directory contents in the container. The new `_out.wav` files will be created in an extra `out` folder which will be automatically created in the directory where the individual file is.
```bash
docker compose run app -e "embed_file.txt" -p "secret!password" -d "/optional/path/to/data/dir"
```

You can test if the steganography was successful with an extra `-t` argument:
```bash
docker compose run app -e "embed_file.txt" -p "secret!password" -d "/optional/path/to/data/dir" -t
```
This extracts the hidden content of all `_out.wav` files in the `/data` directory, compares the extraction with the original `embed_file.txt` and prints a result of the check. The extracted contents are deleted automatically afterwards, but some disk space is required for this operation.
