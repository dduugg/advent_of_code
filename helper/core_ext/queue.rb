# typed: strict
# frozen_string_literal: true

# @see https://docs.ruby-lang.org/en/master/Thread/Queue.html
class Queue
  extend T::Sig

  # @note not thread-safe
  sig { returns(String) }
  def inspect
    objs = []
    size.times do
      obj = pop
      objs << obj
      push(obj)
    end
    "[#{objs.map(&:inspect).join(', ')}]"
  end
end
