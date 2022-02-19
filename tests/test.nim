import std/[unittest, os, asyncdispatch]
import asyncanything


proc getUserName(id: int): string =
  sleep 100
  "hamid"

proc getReturn: Future[string] {.async.} =
  result = goAsync getUserName(12)

proc longTask {.async.} =
  goAsync sleep(150)


test "with return":
  check (waitFor getReturn()) == "hamid"

test "without return":
  waitFor longTask()
