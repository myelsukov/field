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
           same as pass show pass-file
```

# fass

Fuzzy find wrapper for the pass --clip. It uses (if installed) fzf: https://github.com/junegunn/fzf to display matching pass-files.

```
Usage:

  fass partial-pass-file-name [pass command and options]

  fass bank field --name url
      Copy url for the matching pass-file to the clipboard
      
  fass bank otp
      Copy OTP code for the matching pass-file to the clipboard
   ``` 
   
