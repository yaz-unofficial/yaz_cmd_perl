# yaz_cmd_perl
## Requires 
* [http://zoom.z3950.org/bind/perl/](http://zoom.z3950.org/bind/perl/)
  * [https://metacpan.org/release/Net-Z3950-ZOOM](https://metacpan.org/release/Net-Z3950-ZOOM)
    * `perl -MCPAN -e shell`
    * `install ZOOM`

* needs libyaz from yaz toolkit
  * [https://www.indexdata.com/resources/software/yaz/](https://www.indexdata.com/resources/software/yaz/)
  * [http://ftp.indexdata.dk/pub/yaz/yaz-5.27.1.tar.gz](http://ftp.indexdata.dk/pub/yaz/yaz-5.27.1.tar.gz)
    * `./buildconf.sh`
    * `./configure`
    * `make`
    * `sudo make install`
  * or
    * `./buildconf.sh`
    * `./configure --prefix=$HOME/myapps`
    * `make`
    * `make install`
    * ...
    * Add `export PATH="$HOME/myapps/bin:$PATH"` to `.bashrc`
    * (Reload file with `source ~/.bashrc`

## Usage
`perl yaz_cmd_perl.pl <host> <port> <databaseName> <user> <password> <syntax> <query>`  
`perl yaz_cmd_perl.pl --test <number_from_1-5>`  
Syntax is either `MAB`or `USMARC`  
Query in pqf format  
