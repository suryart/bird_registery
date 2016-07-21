## Configuration

    $ bundle install

run server:

    $ rackup


Try it out?:
    
    Get all birds registered:
    
    $ curl -X GET 'http://localhost:9292/api/v1/birds' -H Content-Type:application/json -v
 
    Register a bird:

    $ curl -X POST 'http://localhost:9292/api/v1/birds' -d '{"bird": {"name":"King Penguin", "family": "Penguin", "continents":["Antarctica"]}}' -H Content-Type:application/json -v

    Get a registered bird:

    $ curl -X GET 'http://localhost:9292/api/v1/bird/{id}' -H Content-Type:application/json -v

    Delete a bird from registery:

    $ curl -X DELETE 'http://localhost:9292/api/v1/bird/{id}' -H Content-Type:application/json -v