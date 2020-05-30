% 
% Read the data file (points in single row) and compute CDF.
% Usage:
%	r = cdf('datafile');
% 	plot(r(:,1), r(:,2));
%
% author	Guanling Chen
% version	$Id: cdf.m,v 1.2 2005/01/03 03:47:47 dfk Exp $

function r=cdf(b)

m=load(b);
x=m(1,:);		% first row
x=sort(x);	
n=length(x);
y=ones(1,n);	% [1 1 1 ... 1]
y=y/n;			% [1/n 1/n 1/n ... 1/n]
y=cumsum(y);
r=[x',y'];		% first column is x and second is y for plotting
