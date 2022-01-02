import asyncdispatch, threadpool

const fakeAsyncTimeout {.intdefine.} : int = 100

template goAsync*(body: untyped, timeout = fakeAsyncTimeout): untyped =
  block:
    var f = spawn body

    while not isReady f:
      await sleepAsync timeout

    ^f

template `|>`*(body: untyped, timeout = fakeAsyncTimeout): untyped =
  block:
    var f = spawn body

    while not isReady f:
      await sleepAsync timeout

    ^f