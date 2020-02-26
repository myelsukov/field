# field

## Description
   `pass field` extends the pass utility allowing to display arbitrary field from the passfile

## Usage

```
       pass field [--name=field-name,-n filed-name] [-c] pass-file

       pass field -n url pass-file
           Display url field from the pass-file

       pass field --name=login -c pass-file
           Copy login field from the pass-file to the clipboard

       pass field pass-file
           same as pass show pass-file but prints password only (pass prints the whole file)
```

# fass

Fuzzy find wrapper for the pass. It uses (if installed)

* bemenu (Linux & Mac OS): https://github.com/Cloudef/bemenu  to display matching pass-files.
* choose (Mac OS): https://github.com/chipsenkbeil/choose  to display matching pass-files.
* fzf (Linux & Mac OS): https://github.com/junegunn/fzf to display matching pass-files.
* cliclick (Mac OS): https://github.com/BlueM/cliclick to send desired data to the keyboard buffer
* xdotool (Linux): https://github.com/jordansissel/xdotool  to send desired data to the keyboard buffer

## Supporting scripts

 * pass-file-chooser
 * type-command

```
Usage:

  fass [-t | --type | -c | --clip] partial-pass-file-name [pass command and options]

  fass -c bank field --name url
      Copy url field from the matching pass-file to the clipboard

  fass -t bank field --name url
      Send url field from the matching pass-file to the keyboard buffer

  fass --clip bank otp
      Copy OTP code for the matching pass-file to the clipboard

  fass bank otp
      Print OTP code for the matching pass-file to the stdout

  fass
      This command will allow to choose any pass-file and print that file to the stdout
```

