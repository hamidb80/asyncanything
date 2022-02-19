# make anything async with `AsyncAnything`!

imagine you have a heavy function in the main Event-Loop

```nim
proc AssumeItsHugeAmountOfWork(a: int): int=
  sleep 1000 * 10
  return a + 1
```

with this small library you can pass it to another thread and fake it as a async function! Wow you're a genius!


```nim
let b = goAsync AssumeItsHugeAmountOfWork()
# or
let b = |>AssumeItsHugeAmountOfWork()
```

the idea is that you pass it to another thread and you check it every `timeout` milliseconds.
you can pass the `timeout` like this:

```nim
let b = goAsync(AssumeItsHugeAmountOfWork(), 100)
```

but by default it's value is `fakeAsyncTimeout` which is `100`.
you can also change it's value at the compile time with `-d:fakeAsyncTimeout=<N>` to your ideal timeout [ here `<N>` is an integer ]
