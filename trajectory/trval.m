function varargout = trval(t, r, tau, varargin)

% this method evaluates the r-th order derivatives of the piecewise polynomials given as derivative
% coefficient matrices and tau in varargin at time t. 
cumtau = cumsum(tau); segidx = min(max(sum(bsxfun(@ge, t, cumtau), 2), 1), numel(tau) - 1); 
cfr = @(dercf) permute(dercf(:, r + 1, segidx), [1, 3, 2]);
tp = @(dercf) bsxfun(@power, t - cumtau(segidx)', size(dercf, 1) - 1: -1: 0); 
varargout = cellfun(@(dercf) {reshape(sum(bsxfun(@times, tp(dercf)', cfr(dercf)), 1), [], numel(r))}, varargin); 
