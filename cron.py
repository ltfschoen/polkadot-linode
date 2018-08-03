#!/usr/bin/python

# install dependencies with `pip install docker`

import docker
dockDaemon = docker.from_env()

imgid = [I.id for I in dockDaemon.images.list() if I.attrs["RepoTags"]==[u'<none>:<none>']]

for id in imgid:
   try:
        print "Trying to remove image",id
        dockDaemon.images.remove(id)
        print "Removed image",id
    except docker.errors.APIError,e:
        print "skipping image ",id,"as this is still in use"