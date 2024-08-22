<#
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

 .Example
   # Displays an English passphrase that is 3 characters long, includes a random number on a random word and delimited with '-'.
   New-Passphrase

 .Example
   # Displays a Spanish, Non-Cyrillic passphrase that is 3 characters long, includes a random number on a random word and delimited with '-'.
   New-Passphrase -Language Spanish

 .Example
   # Displays a Spanish, with Cyrillic words enabled passphrase that is 3 words long, includes a random number on a random word and delimited with '-'.
   New-Passphrase -Cyrillic -Language Spanish

 .Example
   # Displays a Spanish, with Cyrillic words enabled passphrase that is 6 words long, includes a random number on a random word and delimited with '-'.
   New-Passphrase -Cyrillic -Language Spanish -WordCount 6
#>
Function New-Passphrase {
	Param (
		[Switch]$AddLeet = $false,
		[Switch]$AddUpperCase = $true,
		[Switch]$AddNumber = $true,
		[Switch]$ReturnSecure = $false,
		[Parameter()]
        [ValidateNotNullOrEmpty()]
        [ValidateSet('EN','English','ES','Spanish')]
		[String]$Language = "EN",
		[Parameter()]
		[Switch]$Cyrillic = $false,
		[int]$WordCount = 3,
		[Parameter()]
        [ValidateSet('-','_',' ','#','@','&','(')]
		[string]$Delimiter = '-'
	)
	$filename = "\\{0}" -f $($PSCommandPath -split '\\' | Select -Last 1)
	$path = $PSCommandPath -replace $filename, ''

	Switch ($Language) {
		"EN" {$words = Get-Content $path\Libraries\SafeENDictionary.txt}
		"English" {$words = Get-Content $path\Libraries\SafeENDictionary.txt}
		"ES" {
			If($Cyrillic) {
				$words = Get-Content $path\Libraries\SafeCyrillicESDictionary.txt
			} Else {
				$words = Get-Content $path\Libraries\SafeESDictionary.txt
			}
		}
		"Spanish" {
			If($Cyrillic) {
				$words = Get-Content $path\Libraries\SafeCyrillicESDictionary.txt
			} Else {
				$words = Get-Content $path\Libraries\SafeESDictionary.txt
			}
		}
		Default {$words = Get-Content $path\Libraries\SafeENDictionary.txt}
	}

    $passphrase = ""
    
    $case = $(Get-Random -Minimum 0 -Maximum $wordcount)

    $leet = $(Get-Random -Minimum 0 -Maximum $wordcount)

    $number = $(Get-Random -Minimum 0 -Maximum $wordcount)
    $rnumber = $(Get-Random -Minimum 2 -Maximum 9)

    for (($i = 0); $i -lt $wordcount; $i++)
    {
	    $word = $words[$(Get-Random -Minimum 0 -Maximum $words.count)]

	    If($AddLeet){
	        If($i -eq $leet) {
		        $word = $word.replace('o', '0')
		        $word = $word.replace('l', '1')
		        $word = $word.replace('e', '3')
		        $word = $word.replace('a', '4')
		        $word = $word.replace('t', '7')
    	    }
        }

	    If($AddNumber) {
	        If($i -eq $number) {
		        $word = "{0}{1}" -f $word, $rnumber
	        }
        }

	    If($AddUpperCase) {
	        If($i -eq $case) {
		        $word = $word.ToUpper()
	        }
        }

	    $passphrase += $word
	    If ($i -lt $wordcount - 1) {
		    $passphrase += $delimiter
	    }
    }

    If ($ReturnSecure) {
	    ConvertTo-SecureString $passphrase -AsPlainText -Force
    } Else {
	    $passphrase
    }
}

Export-ModuleMember -Function New-Passphrase
