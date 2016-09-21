function rdfstr(s) {
    gsub(/\\/, "\\\\", s)
    gsub(/\t/, "\\t", s)
    gsub(/\b/, "\\b", s)
    gsub(/\n/, "\\n", s)
    gsub(/\r/, "\\r", s)
    gsub(/\f/, "\\f", s)
    gsub(/"/, "\\\"", s)
    return "\"" s "\""
}

function rdfuri(s) {
    gsub(/\\/, "\\u005C", s)
    gsub("\x00", "\\u0000", s)
    gsub("\x01", "\\u0001", s)
    gsub("\x02", "\\u0002", s)
    gsub("\x03", "\\u0003", s)
    gsub("\x04", "\\u0004", s)
    gsub("\x05", "\\u0005", s)
    gsub("\x06", "\\u0006", s)
    gsub("\x07", "\\u0007", s)
    gsub("\x08", "\\u0008", s)
    gsub("\x09", "\\u0009", s)
    gsub("\x0a", "\\u000A", s)
    gsub("\x0b", "\\u000B", s)
    gsub("\x0c", "\\u000C", s)
    gsub("\x0d", "\\u000D", s)
    gsub("\x0e", "\\u000E", s)
    gsub("\x0f", "\\u000F", s)
    gsub("\x10", "\\u0010", s)
    gsub("\x11", "\\u0011", s)
    gsub("\x12", "\\u0012", s)
    gsub("\x13", "\\u0013", s)
    gsub("\x14", "\\u0014", s)
    gsub("\x15", "\\u0015", s)
    gsub("\x16", "\\u0016", s)
    gsub("\x17", "\\u0017", s)
    gsub("\x18", "\\u0018", s)
    gsub("\x19", "\\u0019", s)
    gsub("\x1a", "\\u001A", s)
    gsub("\x1b", "\\u001B", s)
    gsub("\x1c", "\\u001C", s)
    gsub("\x1d", "\\u001D", s)
    gsub("\x1e", "\\u001E", s)
    gsub("\x1f", "\\u001F", s)
    gsub("\x20", "+", s)
    gsub(/"/, "\\u0022", s)
    gsub(/</, "\\u003C", s)
    gsub(/>/, "\\u003E", s)
    gsub(/\^/, "\\u005E", s)
    gsub(/`/, "\\u0060", s)
    gsub(/{/, "\\u007B", s)
    gsub(/\|/, "\\u007C", s)
    gsub(/}/, "\\u007D", s)
    return "<" s ">"
}

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
        print "  dc:source <.> ."
    }
}
