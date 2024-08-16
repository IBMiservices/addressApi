**FREE
ctl-opt main('addresstest_1') options(*srcstmt:*nodebugio) dftactgrp(*no) actgrp(*new) bnddir('ADRESSEWBS');

/copy 'ADDRESSAPI.RPGLEINC'
Dcl-proc addresstest_1;
Dcl-pi addresstest_1 extpgm('ADDRESSTST');
End-pi;

End-proc;

dcl-proc testComptageNombreAdresse_1 export;
  dcl-pi *n end-pi;

  dcl-s data pointer;
  dcl-s adresseCourante pointer;
  dcl-s label varchar(256);

  dcl-s index int(5);

  dcl-s count int(5);

  Dcl-s type Varchar(64);
  Dcl-s version Varchar(32);
  dcl-s features varchar(1024);
  dcl-s attribution varchar(16));
  dcl-s query varchar(128);
  dcl-s limit int(5);
  
  data = getAdresseParTexte('rue d''Alsace':15);

  count = addresscount(data);

  dsply('Le nombre d''adresse est ' + %char(count));

  For index = 1 to count;
    data = addressElementAt(data:index-1);
    type = addressStringAt(data:'type');
    version = addressStringAt(data:'version');
    features = addressStringAt(data:'features');
    attribution = addressStringAt(data:'attribution');
    query = addressStringAt(data:'query');
    limit = addressNumAt(data:'limit');
  ENDFOR;
  // Place your assertions here.
  addressClose(data);
end-proc;