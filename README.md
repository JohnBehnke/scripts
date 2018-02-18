# scripts
Some useful scripts that I may or may not occasionally use

## fcrypt
Easily encrypt/decrypt files. Essentially just a wrapper on top of `openssl`, but with a few additions, mostly the ability to have an encrypted file name too.
#### Usage
	fcrypt [-ed] [-i infile] [-o outfile]
		-e, --encrypt: encrypt the target file
		-d, --decrypt: decrypt the target file
		-i, --infile:  name of the file to encrypt
		-o, --outfile: file name of the encrypted file. If not supplied, name of the outfile will be the encrypted name of the input string
