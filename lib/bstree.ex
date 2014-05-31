defmodule BSTree do
  defstruct item: nil, left: nil, right: nil

  def new(item) do
    %BSTree{item: item}
  end

  def add_entry(new_item,
                %BSTree{item: item,
                        right: right} = tree) when new_item > item do
    %BSTree{tree | right: add_entry(new_item,right)}
  end

  def add_entry(new_item,
                %BSTree{item: item,
                        left: left} = tree) when new_item < item do
    %BSTree{tree | left: add_entry(new_item,left)}
  end

  def add_entry(new_item, %BSTree{} = tree) do
    %BSTree{tree | item: new_item}
  end

  def add_entry(new_item,tree) when tree == nil do
    new(new_item)
  end

  # delete item
  # get all items
end
