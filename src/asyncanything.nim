import asyncdispatch, threadpool

const
  goAsyncTimeInterval {.intdefine.}: int = 100
  # TODO goAsyncTimeout {.intdefine.}: int = 5000

template goAsync*(body: typed, timeout = goAsyncTimeInterval): untyped =
  const returnsSomething = typeof(body) isnot void

  when returnsSomething:
    var f = spawn body

    while not isReady f:
      await sleepAsync timeout

    ^f

  else:
    let p = proc(): bool = body
    discard goAsync p()

template `|>`*(body: untyped, timeout = goAsyncTimeInterval): untyped =
  goAsync body, timeout
