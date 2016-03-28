function out = compand(in, param, V, method)
      [lhs,rhs] = argn(0)
      if (rhs<3)
            error("comm:compand:NotEnoughInputs")
      elseif (rhs<4)
            method = 'mu/compressor'
      else
            if ~type(method)==10 then
                  error("comm:compand:InvalidParam")
            end
            method = mtlb_lower(method)
      end

      if ~or(type(in)==[1,5,8])|~or(type(param)==[1,5,8])|~or(type(V)==[1,5,8]) then
            error("comm:compand:InputNotNumeric")
      end

      if ~strcmp(method,"mu/compressor") then
            out = V / log(1 + param) * log(1 + param / V * abs(in)) .* sign(in)
      elseif ~strcmp(method,"mu/expander") then
            out = V / param * (exp(abs(in) * log(1 + param) / V) - 1) .* sign(in)
      elseif ~strcmp(method,"a/compressor") then 
            lnAp1 = log(param) + 1
            VdA   = V / param
            indx = find(abs(in) <= VdA,-1)
            if ~isempty(indx)
                  out(indx) = param / lnAp1 * abs(in(indx)) .* sign(in(indx))
            end
            indx = find(abs(in) >  VdA)
            if ~isempty(indx)
                  out(indx) = V / lnAp1 * (1 + log(abs(in(indx)) / VdA)) .* sign(in(indx))
            end
      elseif ~strcmp(method,"a/expander") then
            lnAp1 = log(param) + 1
            VdA   = V / param
            VdlnAp1 = V / lnAp1
            indx = find(abs(in) <= VdlnAp1,-1)
            if ~isempty(indx)
                  out(indx) = lnAp1 / param * abs(in(indx)) .* sign(in(indx))
            end
            indx = find(abs(in) >  VdlnAp1,-1)
            if ~isempty(indx)
                  out(indx) = VdA * exp(abs(in(indx)) / VdlnAp1 - 1) .* sign(in(indx))
            end
      else
            error("comm:compand:InvalidMethod")

      end
endfunction

