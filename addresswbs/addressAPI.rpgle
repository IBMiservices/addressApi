**free
ctl-opt nomain;

// Déclaration de la procédure searchAddress
dcl-proc addressAPI export;
    dcl-pi *n;
        // Paramètres d'entrée
        addressNumber char(10) const;
    end-pi;

    // Logique de recherche de l'adresse
    // ...
    Return;
end-proc;