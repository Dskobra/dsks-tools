import sys, getopt
USER_CLIENT_ID=sys.argv[1]
USER_SECRET=sys.argv[2]
print(USER_CLIENT_ID)
print(USER_SECRET)
templateFile = "gdrive.provider"
newFile = "gdrive.provider"
KDE_CLIENT_ID="317066460457-pkpkedrvt2ldq6g2hj1egfka2n7vpuoo.apps.googleusercontent.com"
KDE_SECRET="Y8eFAaWfcanV3amZdDvtbYUq"



# Read in google.provider to replace client id
with open(templateFile, 'r') as file:
    id_replace = file.read()

# Replace client id
id_replace = id_replace.replace(KDE_CLIENT_ID, USER_CLIENT_ID)

# Write the file
with open(newFile, 'w') as file:
    file.write(id_replace)

# Read in google.provider to replace client secret
with open(templateFile, 'r') as file:
    secret_replace = file.read()
secret_replace = secret_replace.replace(KDE_SECRET, USER_SECRET)

# Write the file
with open(newFile, 'w') as file:
    file.write(secret_replace)

