import getpass
username = getpass.getuser()
def configure_config():
    templateFile = "corectrl.rules"
    newFile = "90-corectrl.rules"

    # Read in the file
    with open(templateFile, 'r') as file:
        filedata = file.read()

    # Replace 'user' text with username
    filedata = filedata.replace('INSERT_USERNAME', username)

    # Write the new file
    with open(newFile, 'w') as file:
      file.write(filedata)


configure_config()
