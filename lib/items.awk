BEGIN {
    stashed = 0
    FS = "="
}

function stash(k) {
    i = index($0, "=")
    if (i != 0) {
        v = substr($0, i+1)
        if (v != "") {
            if (k in item)
                item[k] = item[k] "\n" v
            else
                item[k] = v
            stashed = 1
        }
    }
}

END {
    if (stashed) {
        if ("id" in item)
            subject = rdfuri(item["id"])
        else
            subject = "[]"
        print subject " rdf:type amfd:item ;"
        if ("title" in item)
            print "  dc:title " rdfstr(item["title"]) " ;"
        if ("date" in item)
            print "  dc:date " rdfstr(item["date"]) "^^xsd:dateTime ;"
        if ("link" in item)
            print "  amfd:link " rdfuri(item["link"]) " ;"
        if ("reddit-item-name" in item)
            print "  amfdr:item-name " rdfstr(item["reddit-item-name"]) " ;"
        if ("subreddit" in item)
            print "  amfdr:subreddit " rdfuri(item["subreddit"]) " ;"
        if ("reddit-self" in item)
            print "  amfdr:self " item["reddit-self"] " ;"
        print "  dc:source <.> ."
    }
}
