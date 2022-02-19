import std/[unittest, os, asyncdispatch]
import asyncanything


proc getUserName(id: int): string =
  sleep 100
  "hamid"

proc getReturn: Future[string] {.async.} =
  result = goAsync getUserName(12)

proc longTask {.async.} =
  goAsync sleep 150
  echo "am I echoed?"

# proc closureProcNoReturn {.async.} =
#   var a: int
#   proc job() = a = 128
#   goAsync job()

# proc closureProc: Future[bool] {.async.} =
#   var a: int
#   proc job() = a = 128
#   goAsync job()


suite "with return":
  test "nimcall":
    check (waitFor getReturn()) == "hamid"

  # test "closure":
  #   check (waitFor closureProc()) == false


suite "without return":
  test "nimcall":
    waitFor longTask()

  # test "closure":
  #   waitFor closureProcNoReturn()
