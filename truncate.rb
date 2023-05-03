# https://stackoverflow.com/a/19048598/15363640
def truncate(string, max)
  string.length > max ? "#{string[0...max]}..." : string
end
