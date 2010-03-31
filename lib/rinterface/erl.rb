module Rinterface

  module Erl

    class << self

      def method_missing(fun, *rest)
        Erlang::Node.fun("spec", @@module, fun.to_s, *rest)
      end

      def const_missing(m)
        @@module = snake(m)
        self
      end

      def snake(txt)
        txt.to_s.split(/(?=[A-Z])/).join('_').downcase
      end

    end

  end

end
