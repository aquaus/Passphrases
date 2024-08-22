# Passphrases

To install this module please use:

Install-Module -Name Passphrases

.Synopsis
  Generates a New Passphrase in English or Spanish. The Dictionaries have had all politically correct 
  words removed that could be construed as harrassment. Your Lawyer and HR team will be excited with this product.

 .Description
  Generates a New Passphrase in English or Spanish.

 .Parameter AddLeet
  Switch. Substitutes numbers for letters in a random number of words. Default is false.

 .Parameter AddUpperCase
  Switch. Adds 1 Uppercase word, default is true.

 .Parameter AddNumber
  Switch. Add Number to the end of a word. Default is true.

 .Parameter ReturnSecure
  Switch. Returns a Secure password instead of plain text. Default is false.

 .Parameter Language
  String. Accepts EN, ES, English, and Spanish. Default is English.

 .Parameter Cyrillic
  Switch. Switches on Cyrillic based passwords. Note, US English keyboards do not support this language type. Default is false.

 .Parameter wordcount
  Int. Number of words to generate. Default is 3.

 .Parameter Delimiter
  String. Valid responses are '-','_',' ','#','@','&','('). Default is '-'.

 #Example 1
 Displays an English passphrase that is 3 words long, includes a random number on a random word and delimited with '-'.
 New-Passphrase

 #Example 2
 Displays a Spanish, Non-Cyrillic passphrase that is 3 words long, includes a random number on a random word and delimited with '-'.
   New-Passphrase -Language Spanish

 #Example 3
   Displays a Spanish, with Cyrillic words enabled passphrase that is 3 words long, includes a random number on a random word and delimited with '-'.
   New-Passphrase -Cyrillic -Language Spanish

 #Example 4
   Displays a Spanish, with Cyrillic words enabled passphrase that is 6 words long, includes a random number on a random word and delimited with '-'.
   New-Passphrase -Cyrillic -Language Spanish -WordCount 6
