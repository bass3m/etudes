defmodule Stats do
    def minimum([h | t]) do
      minimum(t,h)
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
      sum = List.foldl(list,0,fn(n,acc)->n + acc end)
      sum/length(list)
    end
end
