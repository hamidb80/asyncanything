import asyncdispatch, os, unittest
import asyncanything

proc getUserName(id: int): string =
  sleep 1000
  "hamid"

proc getReturn: Future[string] {.async.} =
  result = getUserName(12) |> 10

proc longTask {.async.} =
  sleep(150) |> 100

test "with return":
  check (waitFor getReturn()) == "hamid"

test "without return":
  waitFor longTask()
