import asyncdispatch, threadpool

const goAsyncTimeInterval {.intdefine.}: int = 100

template goAsync*(call: typed, timeout = goAsyncTimeInterval): untyped =
  const returnsSomething = typeof(call) isnot void

  when returnsSomething:
    var f = spawn call

    while not isReady f:
      await sleepAsync timeout

    ^f

  else:
    var t: Thread[void]
    let p = proc() = call
    createThread(t, p)

    while running t:
      await sleepAsync timeout


template `|>`*(call: untyped): untyped =
  goAsync call