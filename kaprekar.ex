defmodule Kaprekar do
  @moduledoc """
  Decompose a four-digit number whose digits are not all the same until it
  finds the Kaprekar constant.

  For information about this constant, visit:

  https://en.wikipedia.org/wiki/Kaprekar%27s_routine

  ## Usage

      iex> Kaprekar.decompose(1234)
      [1234, 3087, 8352, 6174]

  """

  @kaprekar_constant 6_174

  @doc """
  Looks for the Kaprekar number until it is found or until it can no longer decompose.

  ## Example

      iex> Kaprekar.decompose(2341)
      [2341, 3087, 8352, 6174]

      iex> Kaprekar.decompose(4578)
      [4578, 4176, 6174]

      iex> Kaprekar.decompose(6174)
      [6174]

      iex> Kaprekar.decompose(1000)
      [1000, 999]

      iex> Kaprekar.decompose(9999)
      [9999, 0]

      iex> Kaprekar.decompose(123)
      [123]

  """
  @spec decompose(number :: integer()) :: [integer(), ...]
  def decompose(number) when is_integer(number) do
    number
    |> Stream.unfold(&find/1)
    |> Enum.to_list()
  end

  defp find(nil), do: nil
  defp find(number) when number == @kaprekar_constant or number < 1_000, do: {number, nil}
  defp find(number), do: {number, sort(number, :desc) - sort(number, :asc)}

  defp sort(number, order) do
    number
    |> Integer.digits()
    |> Enum.sort(order)
    |> Integer.undigits()
  end
end
