
#  BUILDER
#  Problem: when constuction is getting too complicated, constructor has 10+ args
#  Solution: Build an API to build the object in pieces, extract the object construction code out of its own class and move it to separate class called builder.

class NetworkService:
    def __init__(self):
        self.components = {}

    def add(self, key, value):
        self.components[key] = value


class NetworkServiceBuilder:
    def __init__(self):
        self._service = NetworkService()
    def add_url(self, url):
        self._service.add("url", url)
    def add_cache(self, cache):
        self._service.add("cache", cache)
    def add_auth(self, auth):
        self._service.add("auth", auth)

    def build(self):
        service = self._service
        self._service = NetworkService() # reset the builder for the next build
        return service

builder = NetworkServiceBuilder()
builder.add_url("poop.com")
builder.add_auth(123409873847)
service1 = builder.build()      # builder gets reset here for the next one

builder.add_cache("cache_things")
service2 = builder.build()

