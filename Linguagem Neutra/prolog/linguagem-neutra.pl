/*-----------------------------------------------------------------------------------*/
/* ---                  CID - Comitê de Diversidade e Inclusão                    ---*/
/*-----------------------------------------------------------------------------------*/
/*---                             REGRAS                                          ---*/
/*-----------------------------------------------------------------------------------*/

/* talvez algumas frases fiquem com semântica estranha, por exemplo, "o gato comprou a menina".
 * mas não parece ser um problema para treinar um modelo para tradução
 */ 

/* sn - sintagma nominal 
 * sv - sintagma verbal 
 * sa - sintagma adjetival
 * sadv_lugar - sintagma adverbial de lugar
 * det - determinante
 * sub - substantivo
 * pron_reto - pronome reto
 * pron_pos - pronome possessivo
 * adj - adjetivo
 * verbo_intr - verbo intransitivo
 * verbo_trd - verbo transitivo direto
 * objd - objeto direto
 * prep_det_estar --> preposição em + artigo determinante (para o verbo estar)
*/

/* ------- ORIGINAL  ------- */
sentenca(sent(SN,SV)) --> sn(Gen,Num,SN), sv(Gen,Num,SV).
sentenca(sent(SN,SV)) --> sn_enclise(Gen,Num,SN), sv_enclise(Gen,Num,SV).
sentenca(sent(SN,SV)) --> sn_proclise(Gen,Num,SN), sv_proclise(Gen,Num,SV).
sentenca(sent(SN,SV)) --> sn_mesoclise(Gen,Num,SN), sv_mesoclise(Gen,Num,SV).

/* coloquei o Gen nos sintagmas para carregar o gênero e não precisarmos lidar com
 * frases do tipo: as meninas viram os meninos --> es menines viram os meninos.
 * Se isso não for um problema, é só tirar o Gen do sn e do sv */

sn(Gen,Num,sn(DET,SUB)) --> det(Gen,Num,DET), sub(Gen,Num,SUB).
sn(Gen,Num,sn(PRON)) --> pron_reto(Gen,Num,PRON).
sn(Gen,Num,sn(DET,SUB,ADJ)) --> det(Gen,Num,DET), sub(Gen,Num,SUB), adj(Gen,Num,ADJ).
sn(Gen,Num,sn(DET,SUB,PRON)) --> det(Gen,Num,DET), pron_pos(Gen,Num,PRON), sub(Gen,Num,SUB).
sn(Gen,Num,sn(DET,PRON, SUB,ADJ)) --> det(Gen,Num,DET), pron_pos(Gen,Num,PRON), sub(Gen,Num,SUB), adj(Gen,Num,ADJ).
sn(Gen,Num,sn(DET,SUB,REL)) --> det(Gen,Num,DET), sub(Gen,Num,SUB), clausula_rel(Gen,Num,REL).

sn_enclise(Gen,Num,sn(PRON)) --> pron_reto(Gen,Num,PRON).
sn_proclise(Gen,Num,sn(PRON)) --> pron_reto(Gen,Num,PRON).
sn_mesoclise(Gen,Num,sn(PRON)) --> pron_reto(Gen,Num,PRON).

clausula_rel(Gen,Num,clausula_rel(PR,SV)) --> pron_rel(Gen,Num,PR), sentenca_rel(Gen,Num,SV).
clausula_rel(Gen,Num,clausula_rel(PR,SV)) --> pron_rel_cujo(Gen,Num,PR), sentenca_rel_cujo(Gen,Num,SV).

sentenca_rel(Gen,Num,sent_rel(PRON,VER))--> pron_reto(Gen,Num,PRON), verbo_terceira_pessoa(Num,VER).
sentenca_rel_cujo(Gen,Num,sent_rel(OBJ,VER))--> obj_cujo(Gen,Num,OBJ), verbo_intr(Num,VER).

sv(_Gen,Num,sv(VER)) --> verbo_intr(Num,VER).
sv(Gen,Num,sv(VER,OBJD))--> verbo_trd(Num,VER), objd(Gen,_,OBJD).
sv(Gen,Num,sv(VER,SA))--> verbo_lig_estar(Num,VER), sa(Gen,Num,SA). 
sv(Gen,Num,sv(VER,SADV))--> verbo_lig_estar(Num,VER), sadv_lugar(Gen,_,SADV).
sv(Gen,Num,sv(VER,SA))--> verbo_lig_ser(Num,VER), sa(Gen,Num,SA).
sv(Gen,Num,sv(VER,SADV,COMP_POSS))--> verbo_lig_estar(Num,VER), sadv_lugar(Gen,_,SADV), comp_poss(Gen, Num, COMP_POSS). 

sv_enclise(Gen,Num,sv(SVs,SVe,ADJ)) --> verbo_suporte(Num,SVs), verbo_enclise(Gen,Num,SVe), adj_enclise(Gen,Num,ADJ).
sv_proclise(Gen,Num,sv(SVs,SVp,SUB)) --> verbo_suporte(Num,SVs), verbo_proclise(Gen,Num,SVp), prep_sub(Gen,Num,SUB). 
sv_mesoclise(Gen,Num,sv(SVm,VER)) --> verbo_mesoclise(Gen,Num,SVm), prep_verbo(_,_,VER).

sa(Gen,Num,sa(ADJ)) --> adj(Gen,Num,ADJ).
sadv_lugar(Gen,_,sa(PREP_DET,SUB)) --> prep_det_estar(Gen, Num, PREP_DET), sub_lugar(Gen, Num, SUB). 

objd(Gen,Num,objd(DET,SUB)) --> det(Gen,Num,DET), sub(Gen,Num,SUB).
objd(Gen,Num,objd(DET,PRON,SUB)) --> det(Gen,Num,DET), pron_pos(Gen,Num,PRON), sub(Gen,Num,SUB).
objd(Gen,Num,np(DET,SUB,ADJ)) --> det(Gen,Num,DET), sub(Gen,Num,SUB), adj(Gen,Num,ADJ).
objd(Gen,Num,np(DET,PRON,SUB,ADJ)) --> det(Gen,Num,DET), pron_pos(Gen,Num,PRON), sub(Gen,Num,SUB), adj(Gen,Num,ADJ).

comp_poss(Gen,Num_comp,comp_poss(PREP_DET,SUB)) --> prep_det_poss(Gen,Num_comp,PREP_DET), sub(Gen,Num_comp,SUB).
comp_poss(Gen,Num_comp,comp_poss(PREP_DET,PRON, SUB)) --> prep_det_poss(Gen,Num_comp,PREP_DET), pron_pos(Gen,Num_comp,PRON) ,sub(Gen,Num_comp,SUB). 

/*-----------------------------------------------------------------------------------*/
/*---                             LEXICO                                          ---*/
/*-----------------------------------------------------------------------------------*/

/* Verbos */
verbo_intr(singular,verbo_intr('corre'))-->[corre]. %geral
verbo_intr(plural,verbo_intr('correm'))-->[correm]. %geral                                                                   
verbo_intr(singular,verbo_intr('correu'))-->[correu]. %geral
verbo_intr(plural,verbo_intr('correram'))-->[correram]. %geral
verbo_intr(singular,verbo_intr('correrá'))-->[correrá]. %geral
verbo_intr(plural,verbo_intr('correrão'))-->[correrão]. %geral

%verbo_intr(singular,verbo_intr('cai'))-->[cai]. %geral
%verbo_intr(plural,verbo_intr('caem'))-->[caem]. %geral  
%verbo_intr(singular,verbo_intr('caiu'))-->[caiu]. %geral
%verbo_intr(plural,verbo_intr('cairam'))-->[cairam]. %geral
%verbo_intr(singular,verbo_intr('cairá'))-->[cairá]. %geral
%verbo_intr(plural,verbo_intr('cairão'))-->[cairão]. %geral

%verbo_intr(singular,verbo_intr('nasce'))-->[nasce]. %geral
%verbo_intr(plural,verbo_intr('nascem'))-->[nascem]. %geral
%verbo_intr(singular,verbo_intr('nasceu'))-->[nasceu]. %geral
%verbo_intr(plural,verbo_intr('nasceram'))-->[nasceram]. %geral
%verbo_intr(singular,verbo_intr('nascerá'))-->[nascerá]. %geral
%verbo_intr(plural,verbo_intr('nascerão'))-->[nascerão]. %geral

%verbo_intr(singular,verbo_intr('volta'))-->[volta]. %geral
%verbo_intr(plural,verbo_intr('voltam'))-->[voltam]. %geral
%verbo_intr(singular,verbo_intr('voltou'))-->[voltou]. %geral
%verbo_intr(plural,verbo_intr('voltaram'))-->[voltaram]. %geral
%verbo_intr(singular,verbo_intr('voltará'))-->[voltará]. %geral
%verbo_intr(plural,verbo_intr('voltarão'))-->[voltarão]. %geral

%verbo_intr(singular,verbo_intr('vive'))-->[vive]. %geral
%verbo_intr(plural,verbo_intr('vivem'))-->[vivem]. %geral
%verbo_intr(singular,verbo_intr('viveu'))-->[viveu]. %geral
%verbo_intr(plural,verbo_intr('viveram'))-->[viveram]. %geral
%verbo_intr(singular,verbo_intr('viverá'))-->[viverá]. %geral
%verbo_intr(plural,verbo_intr('viverão'))-->[viverão]. %geral

%verbo_intr(singular,verbo_intr('chega'))-->[chega]. %geral
%verbo_intr(plural,verbo_intr('chegam'))-->[chegam]. %geral
%verbo_intr(singular,verbo_intr('chegou'))-->[chegou]. %geral
%verbo_intr(plural,verbo_intr('chegaram'))-->[chegaram]. %geral
%verbo_intr(singular,verbo_intr('chegará'))-->[chegará]. %geral
%verbo_intr(plural,verbo_intr('chegarão'))-->[chegarão]. %geral

%verbo_intr(singular,verbo_intr('anda'))-->[anda]. %geral
%verbo_intr(plural,verbo_intr('andaram'))-->[andaram]. %geral
%verbo_intr(singular,verbo_intr('andou'))-->[andou]. %geral
%verbo_intr(plural,verbo_intr('andaram'))-->[andaram]. %geral
%verbo_intr(singular,verbo_intr('andará'))-->[andará]. %geral
%verbo_intr(plural,verbo_intr('andarão'))-->[andarão]. %geral

%verbo_intr(singular,verbo_intr('chorou'))-->[chora]. %geral
%verbo_intr(plural,verbo_intr('choraram'))-->[choram]. %geral
%verbo_intr(singular,verbo_intr('chorou'))-->[chorou]. %geral
%verbo_intr(plural,verbo_intr('choraram'))-->[choraram]. %geral
%verbo_intr(singular,verbo_intr('chorará'))-->[chorará]. %geral
%verbo_intr(plural,verbo_intr('chorarão'))-->[chorarão]. %geral

verbo_trd(singular,verbo_trd('vê'))-->[vê]. %geral
verbo_trd(plural,verbo_trd('veem'))-->[veem]. %geral
verbo_trd(singular,verbo_trd('viu'))-->[viu]. %geral
verbo_trd(plural,verbo_trd('viram'))-->[viram]. %geral
verbo_trd(singular,verbo_trd('verá'))-->[verá]. %geral
verbo_trd(plural,verbo_trd('verão'))-->[verão]. %geral

%verbo_trd(singular,verbo_trd('adota'))-->[adota]. %geral
%verbo_trd(plural,verbo_trd('adotam'))-->[adotam]. %geral
%verbo_trd(singular,verbo_trd('adotou'))-->[adotou]. %geral
%verbo_trd(plural,verbo_trd('adotaram'))-->[adotaram]. %geral
%verbo_trd(singular,verbo_trd('adotará'))-->[adotará]. %geral
%verbo_trd(plural,verbo_trd('adotarão'))-->[adotarão]. %geral

%verbo_trd(singular,verbo_trd('compra'))-->[compra]. %geral
%verbo_trd(plural,verbo_trd('compram'))-->[compram]. %geral
%verbo_trd(singular,verbo_trd('comprou'))-->[comprou]. %geral
%verbo_trd(plural,verbo_trd('compraram'))-->[compraram]. %geral
%verbo_trd(singular,verbo_trd('comprará'))-->[comprará]. %geral
%verbo_trd(plural,verbo_trd('comprarão'))-->[comprarão]. %geral

%verbo_trd(singular,verbo_trd('vende'))-->[vendem]. %geral
%verbo_trd(plural,verbo_trd('vendem'))-->[vendem]. %geral
%verbo_trd(singular,verbo_trd('vendeu'))-->[vendeu]. %geral
%verbo_trd(plural,verbo_trd('venderam'))-->[venderam]. %geral
%verbo_trd(singular,verbo_trd('venderá'))-->[venderá]. %geral
%verbo_trd(plural,verbo_trd('venderão'))-->[venderão]. %geral

%verbo_trd(singular,verbo_trd('doa'))-->[doa]. %geral
%verbo_trd(plural,verbo_trd('doam'))-->[doam]. %geral
%verbo_trd(singular,verbo_trd('doou'))-->[doou]. %geral
%verbo_trd(plural,verbo_trd('doaram'))-->[doaram]. %geral
%verbo_trd(singular,verbo_trd('doará'))-->[doará]. %geral
%verbo_trd(plural,verbo_trd('doarão'))-->[doarão]. %geral

verbo_lig_ser(singular,verbo_lig('é'))-->[é]. %geral
verbo_lig_ser(plural,verbo_lig('são'))-->[são]. %geral
verbo_lig_ser(singular,verbo_lig('era'))-->[era]. %geral
verbo_lig_ser(plural,verbo_lig('eram'))-->[eram]. %geral 
verbo_lig_ser(singular,verbo_lig('será'))-->[será]. %geral
verbo_lig_ser(plural,verbo_lig('serão'))-->[serão]. %geral

verbo_lig_estar(singular,verbo_lig('está'))-->[está]. %geral   
verbo_lig_estar(plural,verbo_lig('estão'))-->[estão]. %geral   
verbo_lig_estar(singular,verbo_lig('estará'))-->[estará]. %geral   
verbo_lig_estar(plural,verbo_lig('estarão'))-->[estarão]. %geral
verbo_lig_estar(singular,verbo_lig('estará'))-->[estava]. %geral   
verbo_lig_estar(plural,verbo_lig('estarão'))-->[estavam]. %geral

verbo_terceira_pessoa(singular,verbo_terceira_pessoa('conhece')) --> [conhece]. %geral
verbo_terceira_pessoa(plural,verbo_terceira_pessoa('conhecem')) --> [conhecem]. %geral
verbo_terceira_pessoa(singular,verbo_terceira_pessoa('admira')) --> [admira]. %geral
verbo_terceira_pessoa(plural,verbo_terceira_pessoa('admiram')) --> [admiram]. %geral

%verbo_suporte(singular,verbo_suporte('espera')) --> [espera].  %geral
%verbo_suporte(plural,verbo_suporte('esperam')) --> [esperam]. %geral
verbo_suporte(singular,verbo_suporte('quer')) --> [quer]. %geral 
verbo_suporte(plural,verbo_suporte('querem')) --> [querem]. %geral

%verbo_enclise(feminino,singular,verbo_enclise('encontrá-la')) --> [encontrá-la].
%verbo_enclise(feminino,plural,verbo_enclise('encontrá-las')) --> [encontrá-las].
%verbo_enclise(masculino,singular,verbo_enclise('encontrá-lo')) --> [encontrá-lo].
%verbo_enclise(masculino,plural,verbo_enclise('encontrá-los')) --> [encontrá-los].
verbo_enclise(neutro,singular,verbo_enclise('encontrá-le')) --> [encontrá-le].
verbo_enclise(neutro,plural,verbo_enclise('encontrá-les')) --> [encontrá-les]. 

%verbo_proclise(feminino,singular,verbo_proclise('que a leve')) --> [que_a_leve].
%verbo_proclise(feminino,plural,verbo_proclise('que as leve')) --> [que_as_leve].
%verbo_proclise(masculino,singular,verbo_proclise('que o leve')) --> [que_o_leve].
%verbo_proclise(masculino,plural,verbo_proclise('que os leve')) --> [que_os_leve].
verbo_proclise(neutro,singular,verbo_proclise('que e leve')) --> [que_e_leve].
verbo_proclise(neutro,plural,verbo_proclise('que es leve')) --> [que_es_leve].

%verbo_proclise(feminino,singular,verbo_proclise('que a conduza')) --> [que_a_conduza].
%verbo_proclise(feminino,plural,verbo_proclise('que as conduza')) --> [que_as_conduza].
%verbo_proclise(masculino,singular,verbo_proclise('que o conduza')) --> [que_o_conduza].
%verbo_proclise(masculino,plural,verbo_proclise('que os conduza')) --> [que_os_conduza].
verbo_proclise(neutro,singular,verbo_proclise('que e conduza')) --> [que_e_conduza].
verbo_proclise(neutro,plural,verbo_proclise('que es conduza')) --> [que_es_conduza].

%verbo_mesoclise(feminino,singular,verbo_mesoclise('ensina-la-a')) --> [ensina-la-a].
%verbo_mesoclise(feminino,plural,verbo_mesoclise('ensina-las-a')) --> [ensina-las-a].
%verbo_mesoclise(masculino,singular,verbo_mesoclise('ensina-lo-a')) --> [ensina-lo-a].
%verbo_mesoclise(masculino,plural,verbo_mesoclise('ensina-los-a')) --> [ensina-los-a].
verbo_mesoclise(neutro,singular,verbo_mesoclise('ensina-le-a')) --> [ensina-le-a].
verbo_mesoclise(neutro,plural,verbo_mesoclise('ensina-les-a')) --> [ensina-les-a].

%verbo_mesoclise(feminino,singular,verbo_mesoclise('explica-la-a')) --> [explica-la-a].
%verbo_mesoclise(feminino,plural,verbo_mesoclise('explica-las-a')) --> [explica-las-a].
%verbo_mesoclise(masculino,singular,verbo_mesoclise('explica-lo-a')) --> [explica-lo-a].
%verbo_mesoclise(masculino,plural,verbo_mesoclise('explica-los-a')) --> [explica-los-a].
verbo_mesoclise(neutro,singular,verbo_mesoclise('explica-le-a')) --> [explica-le-a].
verbo_mesoclise(neutro,plural,verbo_mesoclise('explica-les-a')) --> [explica-les-a].

prep_verbo(_,_,prep_verbo('como escrever')) --> [como_escrever]. %geral
prep_verbo(_,_,prep_verbo('como nadar')) --> [como_nadar]. %geral
prep_verbo(_,_,prep_verbo('onde ir')) --> [onde_ir]. %geral
    
%prep_sub(feminino,singular,prep_sub('à médica')) --> [à_médica]. 
%prep_sub(feminino,plural,prep_sub('às médicas')) --> [às_médicas]. 
%prep_sub(masculino,singular,prep_sub('ao médico')) --> [ao_médico]. 
%prep_sub(masculino,plural,prep_sub('aos médicos')) --> [aos_médicos]. 
prep_sub(neutro,singular,prep_sub('e médique')) --> [é_médique]. 
prep_sub(neutro,plural,prep_sub('es médiques')) --> [es_médiques]. 

prep_sub(_,_,prep_sub('ao enterro')) --> [ao_enterro]. %geral
prep_sub(_,_,prep_sub('à_festa')) --> [à_festa]. %geral

/* Artigos                                                                           */

det(feminino,singular,det('a'))-->[a]. %geral
det(feminino,plural,det('as'))-->[as]. %geral
det(masculino,singular,det('o'))-->[o]. %geral
det(masculino,plural,det('os'))-->[os]. %geral
det(neutro,singular,det('e'))-->[ê]. %geral
det(neutro,plural,det('es'))-->[es]. %geral

/* Preposição + artigos                                                           */
prep_det_estar(feminino,singular, prep_det('na')) --> [na]. %geral 
prep_det_estar(feminino,plural, prep_det('nas')) --> [nas]. %geral
prep_det_estar(masculino,singular, prep_det('no')) --> [no]. %geral 
prep_det_estar(masculino,plural, prep_det('nos')) --> [nos]. %geral
prep_det_estar(neutro,singular, prep_det('ne')) --> [ne].  %geral
prep_det_estar(neutro,plural, prep_det('nes')) --> [nes]. %geral

prep_det_poss(feminino,singular, prep_det('da')) --> [da]. %geral 
prep_det_poss(feminino,plural, prep_det('das')) --> [das].  %geral
prep_det_poss(masculino,singular, prep_det('do')) --> [do].  %geral
prep_det_poss(masculino,plural, prep_det('dos')) --> [dos].  %geral
prep_det_poss(neutro,singular, prep_det('de')) --> [de].  %geral
prep_det_poss(neutro,plural, prep_det('des')) --> [des].  %geral

/* Adjetivos                                                                         */

adj_enclise(_,_,adj('feliz'))-->[feliz]. %geral
adj_enclise(_,plural,adj('felizes'))-->[felizes]. %geral
adj_enclise(_,singular,adj('saudável'))-->[saudável]. %geral
adj_enclise(_,plural,adj('saudáveis'))-->[saudáveis]. %geral

%adj_enclise(feminino,singular,adj('segura'))-->[segura].
%adj_enclise(feminino,plural,adj('seguras'))-->[seguras].
%adj_enclise(masculino,singular,adj('seguro'))-->[seguro].
%adj_enclise(masculino,plural,adj('seguros'))-->[seguros].
adj_enclise(neutro,singular,adj('segure'))-->[segure].
adj_enclise(neutro,plural,adj('segures'))-->[segures].

%adj_enclise(feminino,singular,adj('linda'))-->[linda].
%adj_enclise(feminino,plural,adj('lindas'))-->[lindas].
%adj_enclise(masculino,singular,adj('lindo'))-->[lindo].
%adj_enclise(masculino,plural,adj('lindos'))-->[lindos].
adj_enclise(neutro,singular,adj('linde'))-->[linde].
adj_enclise(neutro,plural,adj('lindes'))-->[lindes].

%adj(feminino,singular,adj('linda'))-->[linda].
%adj(feminino,plural,adj('lindas'))-->[lindas].
%adj(masculino,singular,adj('lindo'))-->[lindo].
%adj(masculino,plural,adj('lindos'))-->[lindos].
adj(neutro,singular,adj('linde'))-->[linde].
adj(neutro,plural,adj('lindes'))-->[lindes].

%adj(feminino,singular,adj('única'))-->[única].
%adj(feminino,plural,adj('únicas'))-->[únicas].
%adj(masculino,singular,adj('único'))-->[único].
%adj(masculino,plural,adj('únicos'))-->[únicos].
%adj(neutro,singular,adj('únique'))-->[únique].
%adj(neutro,plural,adj('úniques'))-->[úniques].

%adj(feminino,singular,adj('feia'))-->[feia].
%adj(feminino,plural,adj('feias'))-->[feias].
%adj(masculino,singular,adj('feio'))-->[feio].
%adj(masculino,plural,adj('feios'))-->[feios].
%adj(neutro,singular,adj('feie'))-->[feie].
%adj(neutro,plural,adj('feies'))-->[feies].

adj(_,singular,adj('inteligente'))-->[inteligente]. %geral
adj(_,plural,adj('inteligentes'))-->[inteligentes]. %geral

%adj(feminino,singular,adj('esperta'))-->[esperta].
%adj(feminino,plural,adj('espertas'))-->[espertas].
%adj(masculino,singular,adj('esperto'))-->[esperto].
%adj(masculino,plural,adj('espertos'))-->[espertos].
%adj(neutro,singular,adj('esperte'))-->[esperte].
%adj(neutro,plural,adj('espertes'))-->[espertes].

%adj(feminino,singular,adj('calma'))-->[calma].
%adj(feminino,plural,adj('calmas'))-->[calmas].
%adj(masculino,singular,adj('calmo'))-->[calmo].
%adj(masculino,plural,adj('calmos'))-->[calmos].
%adj(neutro,singular,adj('calme'))-->[calme].
%adj(neutro,plural,adj('calmes'))-->[calmes].

/* Substantivos                                                                      */


%sub(feminino,singular,sub('menina'))-->[menina].
%sub(feminino,plural,sub('meninas'))-->[meninas].
%sub(masculino,singular,sub('menino'))-->[menino].
%sub(masculino,plural,sub('meninos'))-->[meninos].
sub(neutro,singular,sub('menine'))-->[menine].
sub(neutro,plural,sub('menines'))-->[menines].

%sub(feminino,singular,sub('moça'))-->[moça].
%sub(feminino,plural,sub('moças'))-->[moças].
%sub(masculino,singular,sub('moço'))-->[moço].
%sub(masculino,plural,sub('moços'))-->[moços].
%sub(neutro,singular,sub('moce'))-->[moce].
%sub(neutro,plural,sub('moces'))-->[moces].

%sub(feminino,singular,sub('gata'))-->[gata].
%sub(feminino,plural,sub('gatas'))-->[gatas].
sub(neutro,singular,sub('gata'))-->[gata]. %vai precisar arrumar os artigos
sub(neutro,plural,sub('gatas'))-->[gatas]. %vai precisar arrumar os artigos

%sub(masculino,singular,sub('gato'))-->[gato].
%sub(masculino,plural,sub('gatos'))-->[gatos].
%sub(neutro,singular,sub('gato'))-->[gato]. %vai precisar arrumar os artigos
%sub(neutro,plural,sub('gatos'))-->[gatos]. %vai precisar arrumar os artigos

%sub(feminino,singular,sub('cachorra'))-->[cachorra].
%sub(feminino,plural,sub('cachorras'))-->[cachorras].
%sub(neutro,singular,sub('cachorra'))-->[cachorra].
%sub(neutro,plural,sub('cachorras'))-->[cachorras].
%sub(masculino,singular,sub('cachorro'))-->[cachorro].
%sub(masculino,plural,sub('cachorros'))-->[cachorros].
%sub(neutro,singular,sub('cachorro'))-->[cachorro].
%sub(neutro,plural,sub('cachorros'))-->[cachorros].

%sub(feminino,singular,sub('garota'))-->[garota].
%sub(feminino,plural,sub('garotas'))-->[garotas].
%sub(masculino,singular,sub('garoto'))-->[garoto].
%sub(masculino,plural,sub('garotos'))-->[garotos].
%sub(neutro,singular,sub('garote'))-->[garote].
%sub(neutro,plural,sub('garotes'))-->[garotes].

%sub_lugar(feminino,singular,sub('casa'))-->[casa]. 
%sub_lugar(feminino,plural,sub('casas'))-->[casas].
sub_lugar(neutro,singular,sub('casa'))-->[casa].  %vai precisar arrumar os artigos  
sub_lugar(neutro,plural,sub('casas'))-->[casas].  %vai precisar arrumar os artigos  
%sub_lugar(masculino,singular,sub('apartamento'))-->[apartamento]. 
%sub_lugar(masculino,plural,sub('apartamentos'))-->[apartamentos]. 
%sub_lugar(neutro,singular,sub('apartamento'))-->[apartamento]. %vai precisar arrumar os artigos  
%sub_lugar(neutro,plural,sub('apartamentos'))-->[apartamentos]. %vai precisar arrumar os artigos

/* Pronome relativo                                                                  */
pron_rel(_,_,pron('que'))-->[que]. %geral
pron_rel(feminino,singular,pron('a qual'))-->[a_qual]. %geral
pron_rel(feminino,plural,pron('as quais'))-->[as_quais]. %geral
pron_rel(masculino,singular,pron('o qual'))-->[o_qual]. %geral
pron_rel(masculino,plural,pron('os quais'))-->[os_quais]. %geral
pron_rel(neutro,singular,pron('e qual'))-->[e_qual]. %geral
pron_rel(neutro,plural,pron('es quais'))-->[es_quais]. %geral

% esse pronome relativo precisa ser ajustado!
%pron_rel_cujo(feminino, singular, pron('cuja')) --> [cuja]. %geral
%pron_rel_cujo(feminino, plural, pron('cujas')) --> [cujas]. %geral
%pron_rel_cujo(masculino, singular, pron('cujo')) --> [cujo]. %geral
%pron_rel_cujo(masculino, plural, pron('cujos')) --> [cujos]. %geral
%pron_rel_cujo(neutro, singular, pron('cuje')) --> [cuje]. %geral
%pron_rel_cujo(neutro, plural, pron('cujes')) --> [cujes]. %geral

% *************** cuidado aqui *******************

%obj_cujo(feminino,singular,obj('mãe')) --> [mãe].
%obj_cujo(feminino,plural,obj('mães')) --> [mães].
obj_cujo(neutro,singular,obj('nãe')) --> [nãe].
obj_cujo(neutro,plural,obj('nães')) --> [nães].

%obj_cujo(masculino,singular,obj('pai')) --> [pai].
%obj_cujo(masculino,plural,obj('pais')) --> [pais].
%obj_cujo(neutro,singular,obj('nãe')) --> [nãe].
%obj_cujo(neutro,plural,obj('nães')) --> [nães].

% *************** cuidado aqui *******************

/* Pronome pessoal do caso reto */
%pron_reto(feminino, singular, pron('ela')) -->[ela].
%pron_reto(feminino, plural, pron('elas')) -->[elas].
%pron_reto(masculino, singular, pron('ele')) -->[ele].
%pron_reto(masculino, plural, pron('eles')) -->[eles].
pron_reto(neutro, singular, pron('elu')) -->[elu].
pron_reto(neutro, plural, pron('elus')) -->[elus].

/* Pronome possessivo */
pron_pos(feminino, singular, pron('minha')) -->[minha]. %geral
pron_pos(feminino, plural, pron('minhas')) -->[minhas]. %geral
pron_pos(masculino, singular, pron('meu')) -->[meu]. %geral
pron_pos(masculino, plural, pron('meus')) -->[meus]. %geral
pron_pos(neutro, singular, pron('mie')) -->[mie]. %geral
pron_pos(neutro, plural, pron('minheis')) -->[minheis]. %geral

pron_pos(feminino, singular, pron('tua')) -->[tua].
pron_pos(feminino, plural, pron('tuas')) -->[tuas].
pron_pos(masculino, singular, pron('teu')) -->[teu].
pron_pos(masculino, plural, pron('teus')) -->[teus].
pron_pos(neutro, singular, pron('tue')) -->[tue].
pron_pos(neutro, plural, pron('tues')) -->[tues].

%pron_pos(feminino, singular, pron('sua')) -->[sua].
%pron_pos(feminino, plural, pron('suas')) -->[suas].
%pron_pos(masculino, singular, pron('seu')) -->[seu].
%pron_pos(masculino, plural, pron('seus')) -->[seus].
%pron_pos(neutro, singular, pron('sue')) -->[sues].
%pron_pos(neutro, plural, pron('sues')) -->[sues].

%pron_pos(feminino, singular, pron('nossa')) -->[nossa].
%pron_pos(feminino, plural, pron('nossas')) -->[nossas].
%pron_pos(masculino, singular, pron('nosso')) -->[nosso].
%pron_pos(masculino, plural, pron('nossos')) -->[nossos].
%pron_pos(neutro, singular, pron('nosse')) -->[nosse].
%pron_pos(neutro, plural, pron('nosses')) -->[nosses].

%pron_pos(feminino, singular, pron('vossa')) -->[vossa].
%pron_pos(feminino, plural, pron('vossas')) -->[vossas].
%pron_pos(masculino, singular, pron('vosso')) -->[vosso].
%pron_pos(masculino, plural, pron('vossos')) -->[vossos].
%pron_pos(neutro, singular, pron('vosse')) -->[vosse].
%pron_pos(neutro, plural, pron('vosses')) -->[vosses].

/*-----------------------------------------------------------------------------------*/
/*---                             TESTES                                          ---*/
/*-----------------------------------------------------------------------------------*/

goal1(A) :- sentenca(A,[as,meninas,adotaram,os,gatos],[]).
goal2(A) :- sentenca(_,A,[]).

%sentenca(_,X,[])







