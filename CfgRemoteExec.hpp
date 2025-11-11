/*
    CfgRemoteExec - Remote Execution Whitelist
    Defines allowed remote execution functions to prevent security issues
    and BattlEye false-positives. Required when server has remoteExec restrictions.

    Usage: #include "CfgRemoteExec.hpp" in description.ext
*/

class CfgRemoteExec
{
    /*
        Režimas perjungtas į blacklist (mode = 2), nes whitelist režimas
        užblokavo kritines BIS funkcijas (pvz., BIS_fnc_moduleSector),
        todėl sektoriai ir jų užduotys nebuvo aktyvuojamos.

        Kai būsime pasiruošę, galėsime palaipsniui grįžti prie whitelist režimo,
        tačiau tam reikės pilno visų naudojamų komandų/funkcijų sąrašo.
    */

    class Commands
    {
        mode = 2; // Blacklist mode (šiuo metu nieko neblokuojame)
        jip = 0;
        // Pastaba: sąrašas paliktas tuščias – visi default Arma 3 kvietimai leidžiami.
    };

    class Functions
    {
        mode = 2; // Blacklist mode (šiuo metu nieko neblokuojame)
        jip = 0;
        // Pastaba: kai turėsime pilną remoteExec audito ataskaitą,
        // čia pridėsime tik tas funkcijas, kurias norime blokuoti.
    };
};
