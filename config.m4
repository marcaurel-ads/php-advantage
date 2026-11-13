dnl $Id: config.m4,v 1.2 2007-08-09 11:00:33 LanceSc Exp $
dnl config.m4 for extension advantage

dnl Comments in this file start with the string 'dnl'.
dnl Remove where necessary. This file will not work
dnl without editing.

dnl If your extension references something external, use with:

PHP_ARG_WITH(advantage, for Advantage support,
[  --with-advantage[=DIR]             Include support for Advantage Database
                                      server.  Dir is the Advantage PHP
                                      client base directory.  If unspecified
                                      /usr/local/ads/php will be used.], yes)

if test "$PHP_ADVANTAGE" != "no"; then
   dnl # --with-advantage -> check with-path
   SEARCH_PATH="/usr/local/ads/php /usr/local/ads"
   SEARCH_FOR="/include/sql.h"

   if test -r $PHP_ADVANTAGE/; then
      ADVANTAGE_DIR=$PHP_ADVANTAGE
   else
      AC_MSG_CHECKING(for Advantage files in default path)
      for i in $SEARCH_PATH ; do
         if test -r $i/$SEARCH_FOR; then
            ADVANTAGE_DIR=$i
            AC_MSG_RESULT(found in $i)
         fi
      done
   fi

   if test -z "$ADVANTAGE_DIR"; then
       AC_MSG_RESULT(not found)
       AC_MSG_ERROR(Please reinstall the advantage distribution)
   fi

   dnl # --with-advantage -> add include path
   PHP_ADD_INCLUDE($ADVANTAGE_DIR/include)

   dnl # --with-advantage -> chech for lib and symbol presence
   LIBNAME=adsodbc
   LIBSYMBOL=SQLAllocEnv
   old_LIBS=$LIBS

   case $host_alias in 
      i?86*)
        LIBDIR="$LIBS -L$ADVANTAGE_DIR/lib"
        ;;
      x86_64*)
        LIBDIR="$LIBS -L$ADVANTAGE_DIR/lib64"
        ;;
      *)
        LIBDIR="$LIBS -L$ADVANTAGE_DIR/lib"
        ;;
   esac

   LIBS="$LIBDIR -lm -ldl"
   AC_CHECK_LIB($LIBNAME, $LIBSYMBOL, [AC_DEFINE(HAVE_ADVANTAGELIB,1,[ ])],
				[AC_MSG_ERROR(wrong advantage lib version or lib not found)])
   LIBS=$old_LIBS

   PHP_SUBST(ADVANTAGE_SHARED_LIBADD)
   PHP_ADD_LIBRARY_WITH_PATH($LIBNAME, $LIBDIR, ADVANTAGE_SHARED_LIBADD)

   PHP_NEW_EXTENSION(advantage, php_ads.c, $ext_shared)
fi
