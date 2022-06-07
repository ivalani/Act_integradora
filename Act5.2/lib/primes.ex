#!/usr/bin/env elixir

# The sum of the primes below 5 000 000 is 838,596,693,108.

# Find the sum of all the primes below five million.
Primes.prime_stream
|> Enum.take_while(fn(n) -> n < 5_000_000 end)
|> Enum.sum
|> IO.inspect

defmodule Primes do
  def prime_stream do
    Stream.unfold {}, fn(accu) ->
      prime = next_prime(accu)
      { prime, accu |> :erlang.append_element(prime) }
    end
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
      num < check*check     -> true
      rem(num, check) == 0  -> false
      true                  -> prime?(num, prev_primes, i + 1)
    end
  end


end
