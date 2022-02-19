import asyncdispatch, threadpool

const goAsyncTimeInterval {.intdefine.}: int = 100

template goAsync*(body: typed, timeout = goAsyncTimeInterval): untyped =
  const returnsSomething = typeof(body) isnot void

  when returnsSomething:
    var f = spawn body

    while not isReady f:
      await sleepAsync timeout

    ^f

  else:
    var t: Thread[void]
    let p = proc() = body
    createThread(t, p)

    while not running t:
      await sleepAsync timeout


template `|>`*(body: untyped): untyped =
  goAsync body