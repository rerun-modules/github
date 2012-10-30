github
======

Rerun module to manage working with Github

<pre>
[anthony@centos62-dukesbank-rerun github]$ rerun github
Available commands in module, "/home/anthony/src/dtolabs/dukesbank/examples/example5/rerun/modules/github":
create-download: "Create a new download"
   [ --content-type|-c <application/zip>]: "File content (mime) type"
   [ --description|-d <>]: "Download file description"
    --file|-f <>: "File to use to create the new download"
    --owner|-o <>: "Repository owner (user or organization)"
    --repository|-r <>: "Repository name"
   [ --url|-u <https://api.github.com>]: "Github API URL"
delete-download: "Delete a download"
    --file|-f <>: "Download file to delete"
    --owner|-o <>: "Repository owner (user or organization)"
    --repository|-r <>: "Repository name"
   [ --url|-u <https://api.github.com>]: "Github API URL"
get-authorization-token: "Get an authorization token to access the API"
   [ --url|-u <https://api.github.com>]: "Github API URL"
list-downloads: "List downloads for a repository"
    --owner|-o <>: "Repository owner (user or organization)"
    --repository|-r <>: "Repository name"
   [ --url|-u <https://api.github.com>]: "Github API URL"
</pre>

Run github:get-authorization-token first and provide your Github username and password to get an API authorization token (stored in "~/.rerun/github.authorization") for use with subsequent command invocations.

Note that this module relies on [jq](http://stedolan.github.com/jq/) for dealing with JSON passed to and from the Github API
