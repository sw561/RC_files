set terminal pdf
set output "output.pdf"

plot "data.txt" u 1:2 w points
