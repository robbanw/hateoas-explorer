describe 'link parsing', ->
  beforeEach module 'app'

  beforeEach inject (LinkParser) ->
    @linkParser = new LinkParser
    return

  it 'extracts Atom links', ->
    spyOn(@linkParser, 'extractAtomLink').and.callThrough()
    AtomResponse =
      links: [href: "http://example.com", rel: "self"]

    extractedLinks = []
    @linkParser.extractLinkedObjs(AtomResponse, extractedLinks)

    expect(@linkParser.extractAtomLink).toHaveBeenCalled()
    expect(extractedLinks.length).toEqual(1)

  it 'extracts HAL links', ->
    spyOn(@linkParser, 'extractHalLink').and.callThrough()
    HALResponse =
      _links:
        self:
          href: "http://example.com"

    extractedLinks = []
    @linkParser.extractLinkedObjs(HALResponse, extractedLinks)

    expect(@linkParser.extractHalLink).toHaveBeenCalled()
    expect(extractedLinks.length).toEqual(1)

  it 'parses HAL links', ->
    HALLinks =
      _links:
        self:
          href: "http://example.com"

    parsedLinks = @linkParser.parseHALLinks(HALLinks._links)

    expect(parsedLinks.length).toEqual(1)
    expect(parsedLinks[0].href).toEqual('http://example.com')
    expect(parsedLinks[0].rel).toEqual('self')
