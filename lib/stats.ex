defmodule Stats do
    @moduledoc """
    Basic stat functions
    iex(2)> data = [4, 1, 7, -17, 8, 2, 5]
    [4,1,7,-17,8,2,5]
    iex(3)> Stats.minimum(data)
    -17
    iex(4)> Stats.minimum([52, 46])
    46
    iex(5)> Stats.maximum(data)
    8
    iex(6)> Stats.range(data)
    [-17,8]
    """
    def minimum(list) do
      try do
        minimum(tl(list),hd(list))
      rescue
        err -> err
      end
    end
    def minimum([],min_so_far), do: min_so_far
    def minimum([h | t],min_so_far) do
      if h < min_so_far do
        minimum(t,h)
      else
        minimum(t,min_so_far)
      end
    end

    def maximum([h | t]) do
      maximum(t,h)
    end
    def maximum([],max_so_far), do: max_so_far
    def maximum([h | t],max_so_far) do
      if h > max_so_far do
        maximum(t,h)
      else
        maximum(t,max_so_far)
      end
    end

    def range(nums_list) do
      [minimum(nums_list),maximum(nums_list)]
    end

    def mean(list) do
      try do
        sum = sum(list)
        sum/length(list)
      rescue
        err -> err
      end
    end
    
    @doc """
    Compute the sum of a list of numbers. Uses
    List.foldl/3 with a tuple as an accumulator.
    """
    def sum(list) do
      List.foldl(list,0,fn(n,acc)->n + acc end)
    end

    def stdv(list) do
      try do
        n = length(list)
        sum_squares_n = n * (Enum.map(list,fn(n)->n*n end) |> sum)
        sum_list = sum(list)
        :math.sqrt((sum_squares_n - sum_list * sum_list)/(n*(n-1)))
      rescue
        err -> err
      end
    end
end
