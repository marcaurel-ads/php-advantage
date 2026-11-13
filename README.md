# php-advantage

The Advantage PHP Extension (`php_ads.c`): a PHP extension for Advantage Database
Server that reaches the server through the Advantage ODBC driver (`adsodbc`). It
is a fork of PHP's old `ext/odbc`, maintained by Extended Systems, iAnywhere
and SAP.

The source is under the PHP License 2.02 (see the header of `php_ads.c`). Its
text, which the header says is bundled in `LICENSE`, was not in SAP's package
and is added here from <https://www.php.net/license/2_02.txt>.

## Source

ADS 12.0, Windows installer `php_win`, taken unchanged.

Not included: the prebuilt DLLs, the ODBC headers (`sql.h`, `sqlext.h`,
`sqltypes.h`), the ODBC driver and ACE libraries, the help, and SAP's
installer script and license agreement.

Building needs the Advantage ODBC driver, which is not open source.
