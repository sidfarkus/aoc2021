require "big"

today =  File.read("input").split(",").map(&.to_i8)
memo = Hash({Int8, Int32}, BigInt).new

# generic memoization macro for fun
macro memoize(name, *args, ret_type, &fn)
    {% argtypes = args.select{|a| a.is_a?(TypeDeclaration)}.map(&.type) %}
    {% argnames = args.select{|a| a.is_a?(TypeDeclaration)}.map(&.var) %}

    class FnMemos
        class_property {{name}}_memo = {} of {{ argtypes }} => {{ ret_type }}
    end

    def {{name}}({{ args.join(", ").id }})
        return FnMemos.{{name}}_memo[{{ argnames }}] if FnMemos.{{name}}_memo.has_key?({{ argnames }})
        retval = begin
        {{ fn.body }}
        end.as({{ ret_type }})
        FnMemos.{{name}}_memo[{{ argnames }}] = retval
        retval
    end
end

memoize(howmany, fish : Int8, day : Int32, ret_type: BigInt) do
    return 1.to_big_i if day == 0
    if fish == 0
        howmany(6, day - 1) + howmany(8, day - 1)
    else
        howmany(fish - 1, day - 1)
    end
end

pp today.map {|fish| howmany(fish, 80) }.sum
pp today.map {|fish| howmany(fish, 256) }.sum