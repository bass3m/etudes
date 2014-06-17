defmodule Stats do
    #def minimum([h | t] = list) do
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

    def sum(list) do
      List.foldl(list,0,fn(n,acc)->n + acc end)
    end

    def stdv(list) do
      n = length(list)
      sum_squares_n = n * (Enum.map(list,fn(n)->n*n end) |> sum)
      sum_list = sum(list)
      :math.sqrt((sum_squares_n - sum_list * sum_list)/(n*(n-1)))
    end
end
