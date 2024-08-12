**FREE
//getAdresseParTexte


Ctl-opt nomain Bnddir('ADRESSEWBS');

/copy 'references/JSONXML.RPGLEINC'

dcl-proc getAdresseParTexte Export;
    dcl-pi getAdresseParTexte pointer;
        pRecherche Pointer Value Options(*string:*nopass);
        pLimit Int(5) Const options(*nopass);
        pAutoComplete Char(1) Const options(*nopass);
        pLat varchar(9) Const options(*nopass);
        pLon varchar(10) Const options(*nopass);
        pType varChar(64) const options(*nopass);
        pPostCode varchar(5) const options(*nopass);
    end-pi;

    dcl-s reponse varchar(16000);
    dcl-s separateur Char(1) inz('?');
    dcl-s recherche varchar(128);
    dcl-s url varchar(128);
    dcl-s get varchar(32) inz('/search/');
    dcl-s json pointer;


    url='http://api-adresse.data.gouv.fr';

    if %parms>=1;
        recherche=%str(pRecherche);
        if recherche <> *blanks;
            url += get + separateur + 'q=' + %scanrpl(recherche:' ':'+');
            separateur='&';
        endif;
    endif;

    if %parms >= 2;
        url += separateur + 'limit=' + %char(pLimit);
        separateur='&';
    endif;

    if %parms >= 3;
        url += separateur + 'autocomplete=0';
        separateur='&';
    endif;

    if %parms >= 4;
        url += separateur + 'lat=' + %trim(pLat) + separateur + 'lon=' + pLon;
        separateur='&';
    endif;

    if %parms >= 6;
        url += separateur + 'type=' + pType;
        separateur='&';
    endif;

    if %parms >= 7;
        url += separateur + 'postcode=' + pPostCode;
        separateur='&';
    endif;


    Exec sql
        set :reponse = systools.httpgetclob(:url,'');

    json = JSON_ParseString(reponse);

    return json;

end-proc;