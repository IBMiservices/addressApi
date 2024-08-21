**FREE
//=====================================================================*
//  Empty Unit Test Case (RPGLE).                                      *
//  Prints a protocol of the execution flow.                           *
//=====================================================================*
//  Command to create the service program:                             *
//  RUCRTRPG TSTPGM(RPGUNIT/TEMPLATE) SRCFILE(RPGUNIT/QSRC)            *
//=====================================================================*
//  Tools/400 STRPREPRC instructions:                                  *
//   >>PRE-COMPILER<<                                                  *
//     >>CRTCMD<<  RUCRTRPG    TSTPGM(&LI/&OB) +                       *
//                             SRCFILE(&SL/&SF) SRCMBR(&SM);           *
//     >>COMPILE<<                                                     *
//       >>PARM<< COPTION(*EVENTF);                                    *
//       >>PARM<< DBGVIEW(*LIST);                                      *
//       >>PARM<< BNDDIR(*N);                                          *
//     >>END-COMPILE<<                                                 *
//     >>EXECUTE<<                                                     *
//   >>END-PRE-COMPILER<<                                              *
//=====================================================================*
//  Compile options:                                                   *
//    *SrcStmt       - Assign SEU line numbers when compiling the      *
//                     source member. This option is required to       *
//                     position the LPEX editor to the line in error   *
//                     when the source member is opened from the       *
//                     RPGUnit view.                                   *
//    *NoDebugIO     - Do not generate breakpoints for input and       *
//                     output specifications. Optional but useful.     *
//=====================================================================*
Ctl-Opt NoMain Option(*SrcStmt : *NoDebugIO);
ctl-opt bnddir('ADRESSEWBS');
     
Dcl-F QSYSPRT PRINTER(80) usropn oflind(*in70);

/include qinclude,TESTCASE                  iRPGUnit Test Suite

Dcl-DS sds  PSDS QUALIFIED;
  pgmName        Char(10)   Pos(1);
  pgmLib         Char(10)   Pos(81);
End-DS;

Dcl-PR openPrinter  EXTPROC('OPENPRINTER');
End-PR;

Dcl-PR print  EXTPROC('PRINT');
  text           Varchar(128) VALUE   OPTIONS(*NOPASS);
End-PR;

Dcl-PR closePrinter  EXTPROC('CLOSEPRINTER');
End-PR;

Dcl-PR setUpSuite  EXTPROC('SETUPSUITE');
End-PR;

Dcl-PR tearDownSuite  EXTPROC('TEARDOWNSUITE');
End-PR;

Dcl-PR setUp  EXTPROC('SETUP');
End-PR;

Dcl-PR tearDown  EXTPROC('TEARDOWN');
End-PR;

Dcl-PR testWhatever_1  EXTPROC(' TESTWHATEVER_1 ');
End-PR;

Dcl-PR testWhatever_2  EXTPROC(' TESTWHATEVER_2 ');
End-PR;

       // ============================================================
       //  Opens the printer.
       // ============================================================
Dcl-Proc openPrinter export;
End-PI;
Dcl-PI *N;

  open QSYSPRT;

End-Proc;

       // ============================================================
       //  Prints a message.
       // ============================================================
Dcl-Proc print export;
  Dcl-PI *N;
    text           Varchar(128) VALUE   OPTIONS(*NOPASS);
  End-PI;

End-DS;
Dcl-DS lineOutput Len(80) INZ;

  if (%parms() >= 1);
    lineOutput = text;
  else;
    lineOutput = '';
  endif;
  write QSYSPRT lineOutput;

End-Proc;

       // ============================================================
       //  Closes the printer.
       // ============================================================
Dcl-Proc closePrinter export;
End-PI;
Dcl-PI *N;

  if (%open(QSYSPRT));
    close QSYSPRT;
  endif;

End-Proc;

       // ============================================================
       //  Set up test suite. Executed once per RUCALLTST.
       // ============================================================
Dcl-Proc setUpSuite export;
  Dcl-PI *N;
  End-PI;

  Dcl-S rc           Char(1);

  runCmd('OVRPRTF FILE(QSYSPRT) TOFILE(*FILE) +
                 SPLFNAME(PROC_FLOW) OVRSCOPE(*JOB)');
  monitor;
    openPrinter();
    print('Executing:   setUpSuite()');
  on-error;
            // ignore errors ...
  endmon;

         // ... but try to remove the override.
  monitor;
    runCmd('DLTOVR FILE(QSYSPRT) LVL(*JOB)');
  on-error;
    dsply '*** Failed to delete QSYSPRT override! ***' rc;
  endmon;

End-Proc;

       // ============================================================
       //  Tear down test suite.
       // ============================================================
Dcl-Proc tearDownSuite export;
End-PI;
Dcl-PI *N;

  print('Executing:   tearDownSuite()');
  closePrinter();

End-Proc;

       // ============================================================
       //  Set up test case.
       // ============================================================
Dcl-Proc setUp export;
End-PI;
Dcl-PI *N;

  print('Executing:   - setUp()');

End-Proc;

       // ============================================================
       //  Tear down test case.
       // ============================================================
Dcl-Proc tearDown export;
End-PI;
Dcl-PI *N;

  print('Executing:   - tearDown()');

End-Proc;

       // ============================================================
       //  RPGUnit test case.
       // ============================================================
Dcl-Proc test1_countlevel_1 export;
End-PI;
Dcl-PI *N;

  print('Executing:       * test1_countlevel_1()');
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
    
    print('type: ' + type);
    print('version: ' + version);
    print('features: ' + features);
    print('attribution: ' + attribution);
    print('query: ' + query);
    print('limit: ' + %char(limit));
  EndFor;
         
  addressClose(data);
  
         // Place your assertions here.

  End-Proc;

       // ============================================================
       //  RPGUnit test case.
       // ============================================================
  Dcl-Proc testWhatever_2 export;
  End-PI;
  Dcl-PI *N;

    print('Executing:       * testWhatever_2()');

         // Place your assertions here.

  End-Proc; 