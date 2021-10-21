import asyncdispatch, os
import asyncanything

proc getUserName(id: int): string =
  sleep 1000
  "hamid"

proc main {.async.} =
  let res = getUserName(12) |> 100
  echo res

when isMainModule:
  waitFor main()
