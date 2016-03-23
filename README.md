INSTALLATION
============

make sure that your public key file is installed in ssh.labri.fr, so that you can log without password

copy the print_labri.sh file in your home folder, then create an alias:
```
%> echo "alias pl="~/print_labri.sh" >> ~/.bashrc
```
source the alias file, and start using pl
```
%> source ~/.bashrc
```

USAGE
=====

print labri, will query the available printers, then let you pick a pdf file from the file in the current folder.
```
%> pl

 1) bowser		 11) gnocchi-2-per-sheet  21) okinawa
 2) bowser-2-per-sheet	 12) harriet		  22) okinawa-2-per-sheet
 3) canaletto		 13) harriet-2-per-sheet  23) salomon
 4) canondeptinfo	 14) idaho		  24) selaven
 5) combas		 15) iris		  25) texas
 6) combas-2-per-sheet	 16) iris-mono		  26) verne
 7) eqsys		 17) lexie		  27) verne-2-per-sheet
 8) eqsys-2-per-sheet	 18) merlot		  28) Quit
 9) gainsborough	 19) okidoki
10) gnocchi		 20) okidoki-2-per-sheet
Please select a printer: 15

 1) ./node-capacities114613154.pdf	2) ./transfo114613155.pdf
 3) ./transfo1.pdf			4) Quit
Please select a file: 2
```


CREDITS
=======

Many thanks to @Jobq for its initial inputs on this.


