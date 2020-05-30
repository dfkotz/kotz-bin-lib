% 
% Read the data file (points in single column) and compute CDF.
% Usage:
%	r = cdf('datafile');
% 	plot(r(:,1), r(:,2));
%
% author	Guanling Chen
% version	$Id: cdfv.m,v 1.2 2005/01/03 03:48:45 dfk Exp $

function r=cdfv(b)

m=load(b);
x=m(:,1);		% first column
x=sort(x);	
n=length(x);
y=ones(n,1);	% [1 1 1 ... 1]'
y=y/n;			% [1/n 1/n 1/n ... 1/n]'
y=cumsum(y);
r=[x,y];		% first column is x and second is y for plotting
