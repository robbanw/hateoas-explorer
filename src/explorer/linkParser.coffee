class LinkParser extends Factory
  constructor: () ->
    return class LinkParserInstance
      constructor: () ->
        @extractLinkedObjs = (data, linkedObjs) ->
          if 'links' of data
            @extractAtomLink(data, linkedObjs)
          else if '_links' of data
            @extractHalLink(data, linkedObjs)
          for element of data
            if element isnt 'links' and typeof(data[element]) is 'object' and data[element]
              @extractLinkedObjs(data[element], linkedObjs)

        @extractAtomLink = (data, linkedObjs) ->
          linkedObj = {}
          linkedObj.raw = JSON.stringify(data, null, 2)
          for link in data.links
            if link.rel is 'self'
              linkedObj.url = link.href
              linkedObjs.push(linkedObj)
              break

        @extractHalLink = (data, linkedObjs) ->
          linkedObj = {}
          linkedObj.raw = JSON.stringify(data, null, 2)
          for link of data._links
            if link is 'self'
              linkedObj.url = data._links[link].href
              linkedObjs.push(linkedObj)
              break

        @parseHALLinks = (links) ->
          HALLinks = []
          for link of links
            linkElement = {}
            linkElement.rel = link
            linkElement.href = links[link].href
            HALLinks.push(linkElement)
          HALLinks
