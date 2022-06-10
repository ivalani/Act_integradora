# The sum of the primes below 5 000 000 is 838,596,693,108.
# Find the sum of all the primes below five million.

defmodule Hw.Primes do
  def timer(function) do
    function
    |> :timer.tc()
    |> elem(0)
    |> Kernel./(1_000_000)
  end

  def sum_primes do
    Stream.unfold({}, fn accu ->
      prime = next_prime(accu)
      {prime, accu |> :erlang.append_element(prime)}
    end)
  end

  defp next_prime({}), do: 2

  defp next_prime(prev_primes) do
    l = tuple_size(prev_primes) - 1
    prev = prev_primes |> elem(l)
    next_prime(prev + 1, prev_primes)
  end

  defp next_prime(num, prev_primes) do
    if prime?(num, prev_primes, 0) do
      num
    else
      next_prime(num + 1, prev_primes)
    end
  end

  defp prime?(num, prev_primes, i) do
    check = prev_primes |> elem(i)

    cond do
      num < check * check -> true
      rem(num, check) == 0 -> false
      true -> prime?(num, prev_primes, i + 1)
    end
  end







  def sum_primes_config(range, init) do
IO.puts("range: #{range}")
IO.puts("init: #{init}")
    Hw.Primes.sum_primes
    |> Enum.take_while(fn x -> x < range end)
    |> Enum.sum()
    |> IO.inspect()
  end



  def sum_primes_parallel(limit, threads \\ System.schedulers()) do
    range = div(limit, threads)

    1..threads
    |> Enum.map(&Task.async(fn -> sum_primes_config(&1 * range, 1 + (&1 - 1) * range) end))
    |> Enum.map(&Task.await(&1))
    |> Enum.sum()


  end







  def comparative(limit, threads) do

    secuencial = Hw.Primes.sum_primes()|> Enum.take_while(fn n -> n < limit end)|> Enum.sum()
    parallel = Hw.Primes.sum_primes_parallel(limit, threads)


    timerSec = timer(fn ->  Hw.Primes.sum_primes()|> Enum.take_while(fn n -> n < limit end)|> Enum.sum() end)
     timerPar =  timer(fn ->Hw.Primes.sum_primes_parallel(limit, threads)end)

    secText = "Secuencial: #{secuencial} time: #{timerSec}"
    parText = "Parallel: #{parallel} time: #{timerPar}"

     speedUp = "SpeedUp comparing Secuencial over parallel: #{timerSec/timerPar }"


     IO.puts(secText)
     IO.puts(parText)
    IO.puts(speedUp)

  end
end

Hw.Primes.comparative(5000,4)
