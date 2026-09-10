<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!--
  Modèle "Prêt" UNIQUE (plus de 6 .base-type-block dupliqués) :
  champs tagués bases/types comme dossier.jsp. Cloné intégralement
  par SybrisPayload.addPret() (_storePretTemplates() lit ce seul
  <div id="pret-template-unifie">, _getPretTemplate() renvoie tout
  le HTML) ; la visibilité bases/types de la copie clonée est
  appliquée UNE FOIS juste après clonage via
  SybrisUI.refreshFieldVisibilityWithin(wrapper) — inutile de la
  garder "live" ensuite puisque changer de base/type vide tous les
  prêts (clearPrets()). _readPretInstanceFields() ignore les champs
  dont bases/types ne correspondent pas à la sélection courante.
-->
<div id="pret-template-unifie" style="display:none">
    <div class="sybris-subform">
        <div class="form-subsection">
            <div class="form-subsection-header" onclick="toggleSubsection(this)">
                <span class="form-subsection-icon">▾</span>
                <h6>Identification du prêt</h6>
            </div>
            <div class="form-subsection-body">
                <div class="form-container">
                    <jsp:include page="/WEB-INF/pages/sybris/formulaires/Commun aux bases/commun/field-hidden-readonly.jsp">
                        <jsp:param name="fieldId" value="typeEnregistrement"/>
                        <jsp:param name="fieldName" value="typeEnregistrement"/>
                        <jsp:param name="label" value="Type d'enregistrement (Prêt)"/>
                        <jsp:param name="value" value="3"/>
                        <jsp:param name="maxLength" value="1"/>
                    </jsp:include>
                    <jsp:include page="/WEB-INF/pages/sybris/formulaires/Commun aux bases/commun/field-text.jsp">
                        <jsp:param name="fieldId" value="referencePret"/>
                        <jsp:param name="label" value="Référence prêt"/>
                        <jsp:param name="placeholder" value="Référence prêt"/>
                        <jsp:param name="maxLength" value="20"/>
                        <jsp:param name="requiredType" value="fixed"/>
                    </jsp:include>
                    <jsp:include page="/WEB-INF/pages/sybris/formulaires/Commun aux bases/commun/field-text.jsp">
                        <jsp:param name="fieldId" value="dureePret"/>
                        <jsp:param name="label" value="Durée prêt (mois)"/>
                        <jsp:param name="placeholder" value="Durée prêt (mois)"/>
                        <jsp:param name="maxLength" value="3"/>
                        <jsp:param name="requiredType" value="conditional"/>
                        <jsp:param name="conditionalExpr" value="[1,2,5].includes(risque)"/>
                        <jsp:param name="bases" value="A"/>
                        <jsp:param name="types" value="DECLARATION"/>
                    </jsp:include>
                    <jsp:include page="/WEB-INF/pages/sybris/formulaires/Commun aux bases/commun/field-text.jsp">
                        <jsp:param name="fieldId" value="dureePret"/>
                        <jsp:param name="label" value="Durée prêt"/>
                        <jsp:param name="placeholder" value="Durée prêt"/>
                        <jsp:param name="maxLength" value="3"/>
                        <jsp:param name="requiredType" value=""/>
                        <jsp:param name="bases" value="C"/>
                        <jsp:param name="types" value="DECLARATION"/>
                    </jsp:include>
                    <jsp:include page="/WEB-INF/pages/sybris/formulaires/Commun aux bases/commun/field-text.jsp">
                        <jsp:param name="fieldId" value="numeroContratCNP"/>
                        <jsp:param name="label" value="Contrat"/>
                        <jsp:param name="placeholder" value="Contrat"/>
                        <jsp:param name="maxLength" value="5"/>
                        <jsp:param name="requiredType" value="fixed"/>
                        <jsp:param name="bases" value="A"/>
                        <jsp:param name="types" value="DECLARATION"/>
                    </jsp:include>
                    <jsp:include page="/WEB-INF/pages/sybris/formulaires/Commun aux bases/commun/field-text.jsp">
                        <jsp:param name="fieldId" value="numeroContratCNP"/>
                        <jsp:param name="label" value="Numéro contrat CNP"/>
                        <jsp:param name="placeholder" value="Numéro contrat CNP"/>
                        <jsp:param name="maxLength" value="5"/>
                        <jsp:param name="requiredType" value="fixed"/>
                        <jsp:param name="bases" value="B C"/>
                        <jsp:param name="types" value="DECLARATION"/>
                    </jsp:include>
                    <jsp:include page="/WEB-INF/pages/sybris/formulaires/Commun aux bases/commun/field-select.jsp">
                        <jsp:param name="fieldId" value="modaliteEntree"/>
                        <jsp:param name="label" value="Modalité d'entrée"/>
                        <jsp:param name="itemsAttribute" value="modalitesEntreeBaseA"/>
                        <jsp:param name="showCode" value="true"/>
                        <jsp:param name="requiredType" value="fixed"/>
                        <jsp:param name="bases" value="A"/>
                        <jsp:param name="types" value="DECLARATION"/>
                    </jsp:include>
                    <jsp:include page="/WEB-INF/pages/sybris/formulaires/Commun aux bases/commun/field-select.jsp">
                        <jsp:param name="fieldId" value="modaliteEntree"/>
                        <jsp:param name="label" value="Modalité d'entrée"/>
                        <jsp:param name="itemsAttribute" value="modalitesEntreeBaseB"/>
                        <jsp:param name="showCode" value="true"/>
                        <jsp:param name="requiredType" value="fixed"/>
                        <jsp:param name="bases" value="B"/>
                        <jsp:param name="types" value="DECLARATION"/>
                    </jsp:include>
                    <jsp:include page="/WEB-INF/pages/sybris/formulaires/Commun aux bases/commun/field-select.jsp">
                        <jsp:param name="fieldId" value="modaliteEntree"/>
                        <jsp:param name="label" value="Modalité d'entrée"/>
                        <jsp:param name="itemsAttribute" value="modalitesEntreeBaseC"/>
                        <jsp:param name="showCode" value="true"/>
                        <jsp:param name="requiredType" value="fixed"/>
                        <jsp:param name="bases" value="C"/>
                        <jsp:param name="types" value="DECLARATION"/>
                    </jsp:include>
                    <jsp:include page="/WEB-INF/pages/sybris/formulaires/Commun aux bases/commun/field-select.jsp">
                        <jsp:param name="fieldId" value="qualiteEmprunteur"/>
                        <jsp:param name="label" value="Qualité d'emprunteur"/>
                        <jsp:param name="itemsAttribute" value="qualitesEmprunteurBaseB"/>
                        <jsp:param name="showCode" value="true"/>
                        <jsp:param name="requiredType" value="fixed"/>
                        <jsp:param name="bases" value="B"/>
                        <jsp:param name="types" value="DECLARATION"/>
                    </jsp:include>
                    <jsp:include page="/WEB-INF/pages/sybris/formulaires/Commun aux bases/commun/field-select.jsp">
                        <jsp:param name="fieldId" value="qualiteEmprunteur"/>
                        <jsp:param name="label" value="Qualité d'emprunteur"/>
                        <jsp:param name="itemsAttribute" value="qualitesEmprunteurBaseC"/>
                        <jsp:param name="showCode" value="true"/>
                        <jsp:param name="requiredType" value="fixed"/>
                        <jsp:param name="bases" value="C"/>
                        <jsp:param name="types" value="DECLARATION"/>
                    </jsp:include>
                    <jsp:include page="/WEB-INF/pages/sybris/formulaires/Commun aux bases/commun/field-text.jsp">
                        <jsp:param name="fieldId" value="departementGage"/>
                        <jsp:param name="label" value="Département de gage"/>
                        <jsp:param name="placeholder" value="Département de gage"/>
                        <jsp:param name="maxLength" value="2"/>
                        <jsp:param name="requiredType" value=""/>
                        <jsp:param name="bases" value="C"/>
                        <jsp:param name="types" value="DECLARATION"/>
                    </jsp:include>
                    <jsp:include page="/WEB-INF/pages/sybris/formulaires/Commun aux bases/commun/field-text.jsp">
                        <jsp:param name="fieldId" value="numeroTete"/>
                        <jsp:param name="label" value="Numéro de tête"/>
                        <jsp:param name="placeholder" value="Numéro de tête"/>
                        <jsp:param name="maxLength" value="1"/>
                        <jsp:param name="requiredType" value=""/>
                        <jsp:param name="bases" value="C"/>
                        <jsp:param name="types" value="DECLARATION"/>
                    </jsp:include>
                </div>
            </div>
        </div>
        <div class="form-subsection">
            <div class="form-subsection-header" onclick="toggleSubsection(this)">
                <span class="form-subsection-icon">▾</span>
                <h6>Dates et signature</h6>
            </div>
            <div class="form-subsection-body">
                <div class="form-container">
                    <div class="input-container" data-bases="A" data-types="DECLARATION">
                        <label for="dateEntreeAssurance">Date de prise d'effet <span class="sybris-required-mark">*</span></label>
                        <input type="date" id="dateEntreeAssurance" name="dateEntreeAssurance" required>
                    </div>
                    <div class="input-container" data-bases="B C" data-types="DECLARATION">
                        <label for="dateEntreeAssurance">Date d'entrée dans l'assurance <span class="sybris-required-mark">*</span></label>
                        <input type="date" id="dateEntreeAssurance" name="dateEntreeAssurance" required>
                    </div>
                    <div class="input-container" data-required-when="modaliteEntree=='QSC'" data-bases="A B" data-types="DECLARATION">
                        <label for="dateSignature">Date de signature <span class="sybris-conditional-mark hidden">*</span></label>
                        <input type="date" id="dateSignature" name="dateSignature">
                    </div>
                    <div class="input-container" data-bases="C" data-types="DECLARATION">
                        <label for="dateSignature">Date de signature</label>
                        <input type="date" id="dateSignature" name="dateSignature">
                    </div>
                    <jsp:include page="/WEB-INF/pages/sybris/formulaires/Commun aux bases/commun/field-text.jsp">
                        <jsp:param name="fieldId" value="referenceLiasse"/>
                        <jsp:param name="label" value="Référence de liasse"/>
                        <jsp:param name="placeholder" value="Référence de liasse"/>
                        <jsp:param name="maxLength" value="20"/>
                        <jsp:param name="requiredType" value="conditional"/>
                        <jsp:param name="conditionalExpr" value="modaliteEntree=='QSC'"/>
                        <jsp:param name="bases" value="A B"/>
                        <jsp:param name="types" value="DECLARATION"/>
                    </jsp:include>
                    <jsp:include page="/WEB-INF/pages/sybris/formulaires/Commun aux bases/commun/field-text.jsp">
                        <jsp:param name="fieldId" value="referenceLiasse"/>
                        <jsp:param name="label" value="Référence de liasse"/>
                        <jsp:param name="placeholder" value="Référence de liasse"/>
                        <jsp:param name="maxLength" value="20"/>
                        <jsp:param name="requiredType" value="conditional"/>
                        <jsp:param name="conditionalExpr" value="modaliteEntree in [QSC,QSD,QM,QS]"/>
                        <jsp:param name="bases" value="C"/>
                        <jsp:param name="types" value="DECLARATION"/>
                    </jsp:include>
                    <div class="input-container" data-required-when="modaliteEntree=='QSC'" data-bases="A" data-types="DECLARATION">
                        <label for="dateAcceptation">Date de réponse CNP <span class="sybris-conditional-mark hidden">*</span></label>
                        <input type="date" id="dateAcceptation" name="dateAcceptation">
                    </div>
                    <div class="input-container" data-required-when="modaliteEntree=='QSC'" data-bases="B C" data-types="DECLARATION">
                        <label for="dateAcceptation">Date d'acceptation <span class="sybris-conditional-mark hidden">*</span></label>
                        <input type="date" id="dateAcceptation" name="dateAcceptation">
                    </div>
                    <div class="input-container" data-types="DECLARATION">
                        <label for="dateDerniereEcheance">Date dernière échéance <span class="sybris-required-mark">*</span></label>
                        <input type="date" id="dateDerniereEcheance" name="dateDerniereEcheance" required>
                    </div>
                    <div class="input-container" data-required-when="risque==4" data-bases="B C" data-types="DECLARATION">
                        <label for="dateOrigine">Date d'origine <span class="sybris-conditional-mark hidden">*</span></label>
                        <input type="date" id="dateOrigine" name="dateOrigine">
                    </div>
                    <div class="input-container" data-bases="C" data-types="DECLARATION">
                        <label for="dateAdhesionITDC">Date d'adhésion IT/DC</label>
                        <input type="date" id="dateAdhesionITDC" name="dateAdhesionITDC">
                    </div>
                    <jsp:include page="/WEB-INF/pages/sybris/formulaires/Commun aux bases/commun/field-text.jsp">
                        <jsp:param name="fieldId" value="dateFinPret"/>
                        <jsp:param name="label" value="Date de fin de prêt"/>
                        <jsp:param name="placeholder" value="Date de fin de prêt"/>
                        <jsp:param name="maxLength" value="5"/>
                        <jsp:param name="requiredType" value=""/>
                        <jsp:param name="bases" value="C"/>
                        <jsp:param name="types" value="DECLARATION"/>
                    </jsp:include>
                </div>
            </div>
        </div>
        <div class="form-subsection">
            <div class="form-subsection-header" onclick="toggleSubsection(this)">
                <span class="form-subsection-icon">▾</span>
                <h6>Montants et périodicité</h6>
            </div>
            <div class="form-subsection-body">
                <div class="form-container">
                    <jsp:include page="/WEB-INF/pages/sybris/formulaires/Commun aux bases/commun/field-text.jsp">
                        <jsp:param name="fieldId" value="quotite"/>
                        <jsp:param name="label" value="Quotité (dont 2 décimales)"/>
                        <jsp:param name="placeholder" value="Quotité (dont 2 décimales)"/>
                        <jsp:param name="maxLength" value="5"/>
                        <jsp:param name="requiredType" value="fixed"/>
                        <jsp:param name="bases" value="A"/>
                        <jsp:param name="types" value="DECLARATION"/>
                    </jsp:include>
                    <jsp:include page="/WEB-INF/pages/sybris/formulaires/Commun aux bases/commun/field-text.jsp">
                        <jsp:param name="fieldId" value="quotite"/>
                        <jsp:param name="label" value="Quotité (< 10000, dont 2 décimales)"/>
                        <jsp:param name="placeholder" value="Quotité (< 10000, dont 2 décimales)"/>
                        <jsp:param name="maxLength" value="5"/>
                        <jsp:param name="requiredType" value="fixed"/>
                        <jsp:param name="bases" value="B"/>
                        <jsp:param name="types" value="DECLARATION"/>
                    </jsp:include>
                    <jsp:include page="/WEB-INF/pages/sybris/formulaires/Commun aux bases/commun/field-text.jsp">
                        <jsp:param name="fieldId" value="quotite"/>
                        <jsp:param name="label" value="Quotité (<= 10000, dont 2 décimales)"/>
                        <jsp:param name="placeholder" value="Quotité (<= 10000, dont 2 décimales)"/>
                        <jsp:param name="maxLength" value="5"/>
                        <jsp:param name="requiredType" value="fixed"/>
                        <jsp:param name="bases" value="C"/>
                        <jsp:param name="types" value="DECLARATION"/>
                    </jsp:include>
                    <jsp:include page="/WEB-INF/pages/sybris/formulaires/Commun aux bases/commun/field-text.jsp">
                        <jsp:param name="fieldId" value="montantInitial"/>
                        <jsp:param name="label" value="Montant initial (dont 2 décimales)"/>
                        <jsp:param name="placeholder" value="Montant initial (dont 2 décimales)"/>
                        <jsp:param name="maxLength" value="12"/>
                        <jsp:param name="requiredType" value=""/>
                        <jsp:param name="bases" value="A"/>
                        <jsp:param name="types" value="DECLARATION"/>
                    </jsp:include>
                    <jsp:include page="/WEB-INF/pages/sybris/formulaires/Commun aux bases/commun/field-text.jsp">
                        <jsp:param name="fieldId" value="montantInitial"/>
                        <jsp:param name="label" value="Montant initial (dont 2 décimales)"/>
                        <jsp:param name="placeholder" value="Montant initial (dont 2 décimales)"/>
                        <jsp:param name="maxLength" value="12"/>
                        <jsp:param name="requiredType" value="fixed"/>
                        <jsp:param name="bases" value="B C"/>
                        <jsp:param name="types" value="DECLARATION"/>
                    </jsp:include>
                    <jsp:include page="/WEB-INF/pages/sybris/formulaires/Commun aux bases/commun/field-select.jsp">
                        <jsp:param name="fieldId" value="periodicite"/>
                        <jsp:param name="label" value="Périodicité"/>
                        <jsp:param name="itemsAttribute" value="periodicites"/>
                        <jsp:param name="showCode" value="true"/>
                        <jsp:param name="requiredType" value="fixed"/>
                        <jsp:param name="types" value="DECLARATION"/>
                    </jsp:include>
                    <jsp:include page="/WEB-INF/pages/sybris/formulaires/Commun aux bases/commun/field-select.jsp">
                        <jsp:param name="fieldId" value="natureEcheance"/>
                        <jsp:param name="label" value="Nature d'échéance"/>
                        <jsp:param name="itemsAttribute" value="naturesEcheance"/>
                        <jsp:param name="showCode" value="true"/>
                        <jsp:param name="requiredType" value="fixed"/>
                        <jsp:param name="types" value="DECLARATION"/>
                    </jsp:include>
                    <jsp:include page="/WEB-INF/pages/sybris/formulaires/Commun aux bases/commun/field-select.jsp">
                        <jsp:param name="fieldId" value="modalitePaiement"/>
                        <jsp:param name="label" value="Modalité paiement"/>
                        <jsp:param name="itemsAttribute" value="modalitesPaiement"/>
                        <jsp:param name="showCode" value="true"/>
                        <jsp:param name="requiredType" value="fixed"/>
                        <jsp:param name="bases" value="B C"/>
                        <jsp:param name="types" value="DECLARATION"/>
                    </jsp:include>
                    <jsp:include page="/WEB-INF/pages/sybris/formulaires/Commun aux bases/commun/field-select.jsp">
                        <jsp:param name="fieldId" value="optionPersonneAgee"/>
                        <jsp:param name="label" value="Option personne âgée"/>
                        <jsp:param name="itemsAttribute" value="ouiNonList"/>
                        <jsp:param name="showCode" value="false"/>
                        <jsp:param name="requiredType" value="conditional"/>
                        <jsp:param name="conditionalExpr" value="risque!=4"/>
                        <jsp:param name="bases" value="B"/>
                        <jsp:param name="types" value="DECLARATION"/>
                    </jsp:include>
                    <jsp:include page="/WEB-INF/pages/sybris/formulaires/Commun aux bases/commun/field-select.jsp">
                        <jsp:param name="fieldId" value="optionPersonneAgee"/>
                        <jsp:param name="label" value="Option personne âgée"/>
                        <jsp:param name="itemsAttribute" value="ouiNonList"/>
                        <jsp:param name="showCode" value="false"/>
                        <jsp:param name="requiredType" value="fixed"/>
                        <jsp:param name="bases" value="C"/>
                        <jsp:param name="types" value="DECLARATION"/>
                    </jsp:include>
                    <jsp:include page="/WEB-INF/pages/sybris/formulaires/Commun aux bases/commun/field-text.jsp">
                        <jsp:param name="fieldId" value="delaiCarence"/>
                        <jsp:param name="label" value="Délai de carence (jours)"/>
                        <jsp:param name="placeholder" value="Délai de carence (jours)"/>
                        <jsp:param name="maxLength" value="3"/>
                        <jsp:param name="requiredType" value="fixed"/>
                        <jsp:param name="bases" value="B C"/>
                        <jsp:param name="types" value="DECLARATION"/>
                    </jsp:include>
                </div>
            </div>
        </div>
        <div class="form-subsection">
            <div class="form-subsection-header" onclick="toggleSubsection(this)">
                <span class="form-subsection-icon">▾</span>
                <h6>Compléments et suivi</h6>
            </div>
            <div class="form-subsection-body">
                <div class="form-container">
                    <jsp:include page="/WEB-INF/pages/sybris/formulaires/Commun aux bases/commun/field-text.jsp">
                        <jsp:param name="fieldId" value="categoriePret"/>
                        <jsp:param name="label" value="Catégorie prêt"/>
                        <jsp:param name="placeholder" value="Catégorie prêt"/>
                        <jsp:param name="maxLength" value="4"/>
                        <jsp:param name="requiredType" value=""/>
                        <jsp:param name="bases" value="A"/>
                        <jsp:param name="types" value="DECLARATION"/>
                    </jsp:include>
                    <jsp:include page="/WEB-INF/pages/sybris/formulaires/Commun aux bases/commun/field-select.jsp">
                        <jsp:param name="fieldId" value="categoriePret"/>
                        <jsp:param name="label" value="Catégorie prêt"/>
                        <jsp:param name="itemsAttribute" value="categoriesPretBaseB"/>
                        <jsp:param name="showCode" value="true"/>
                        <jsp:param name="requiredType" value="fixed"/>
                        <jsp:param name="bases" value="B"/>
                        <jsp:param name="types" value="DECLARATION"/>
                    </jsp:include>
                    <jsp:include page="/WEB-INF/pages/sybris/formulaires/Commun aux bases/commun/field-select.jsp">
                        <jsp:param name="fieldId" value="categoriePret"/>
                        <jsp:param name="label" value="Catégorie prêt"/>
                        <jsp:param name="itemsAttribute" value="categoriesPretBaseC"/>
                        <jsp:param name="showCode" value="true"/>
                        <jsp:param name="requiredType" value="fixed"/>
                        <jsp:param name="bases" value="C"/>
                        <jsp:param name="types" value="DECLARATION"/>
                    </jsp:include>
                    <jsp:include page="/WEB-INF/pages/sybris/formulaires/Commun aux bases/commun/field-select.jsp">
                        <jsp:param name="fieldId" value="criteresSuiviContrat"/>
                        <jsp:param name="label" value="Critère de suivi de contrat"/>
                        <jsp:param name="itemsAttribute" value="criteresSuiviContratBaseA"/>
                        <jsp:param name="showCode" value="true"/>
                        <jsp:param name="requiredType" value=""/>
                        <jsp:param name="bases" value="A"/>
                        <jsp:param name="types" value="DECLARATION"/>
                    </jsp:include>
                    <jsp:include page="/WEB-INF/pages/sybris/formulaires/Commun aux bases/commun/field-text.jsp">
                        <jsp:param name="fieldId" value="dureMaxIndemnisation"/>
                        <jsp:param name="label" value="Durée maximale d'indemnisation (jours)"/>
                        <jsp:param name="placeholder" value="Durée maximale d'indemnisation (jours)"/>
                        <jsp:param name="maxLength" value="4"/>
                        <jsp:param name="requiredType" value="fixed"/>
                        <jsp:param name="bases" value="A"/>
                        <jsp:param name="types" value="DECLARATION"/>
                    </jsp:include>
                    <jsp:include page="/WEB-INF/pages/sybris/formulaires/Commun aux bases/commun/field-text.jsp">
                        <jsp:param name="fieldId" value="dureMaxIndemnisation"/>
                        <jsp:param name="label" value="Durée maximale d'indemnisation"/>
                        <jsp:param name="placeholder" value="Durée maximale d'indemnisation"/>
                        <jsp:param name="maxLength" value="4"/>
                        <jsp:param name="requiredType" value=""/>
                        <jsp:param name="bases" value="C"/>
                        <jsp:param name="types" value="DECLARATION"/>
                    </jsp:include>
                    <jsp:include page="/WEB-INF/pages/sybris/formulaires/Commun aux bases/commun/field-text.jsp">
                        <jsp:param name="fieldId" value="caisseOrigine"/>
                        <jsp:param name="label" value="Caisse d'origine"/>
                        <jsp:param name="placeholder" value="Caisse d'origine"/>
                        <jsp:param name="maxLength" value="3"/>
                        <jsp:param name="requiredType" value="conditional"/>
                        <jsp:param name="conditionalExpr" value="fusion CR"/>
                        <jsp:param name="bases" value="A"/>
                        <jsp:param name="types" value="DECLARATION"/>
                    </jsp:include>
                    <jsp:include page="/WEB-INF/pages/sybris/formulaires/Commun aux bases/commun/field-text.jsp">
                        <jsp:param name="fieldId" value="caisseOrigine"/>
                        <jsp:param name="label" value="Caisse d'origine"/>
                        <jsp:param name="placeholder" value="Caisse d'origine"/>
                        <jsp:param name="maxLength" value="3"/>
                        <jsp:param name="requiredType" value=""/>
                        <jsp:param name="bases" value="C"/>
                        <jsp:param name="types" value="DECLARATION"/>
                    </jsp:include>
                    <jsp:include page="/WEB-INF/pages/sybris/formulaires/Commun aux bases/commun/field-text.jsp">
                        <jsp:param name="fieldId" value="categorieIT"/>
                        <jsp:param name="label" value="Catégorie IT (1 = IT partielle)"/>
                        <jsp:param name="placeholder" value="Catégorie IT (1 = IT partielle)"/>
                        <jsp:param name="maxLength" value="1"/>
                        <jsp:param name="requiredType" value=""/>
                        <jsp:param name="bases" value="B"/>
                        <jsp:param name="types" value="DECLARATION"/>
                    </jsp:include>
                    <jsp:include page="/WEB-INF/pages/sybris/formulaires/Commun aux bases/commun/field-select.jsp">
                        <jsp:param name="fieldId" value="categorieIT"/>
                        <jsp:param name="label" value="Catégorie IT (1 = IT partielle)"/>
                        <jsp:param name="itemsAttribute" value="categoriesITBaseC"/>
                        <jsp:param name="showCode" value="false"/>
                        <jsp:param name="requiredType" value=""/>
                        <jsp:param name="bases" value="C"/>
                        <jsp:param name="types" value="DECLARATION"/>
                    </jsp:include>
                    <jsp:include page="/WEB-INF/pages/sybris/formulaires/Commun aux bases/commun/field-select.jsp">
                        <jsp:param name="fieldId" value="codeMonetaire"/>
                        <jsp:param name="label" value="Code monétaire"/>
                        <jsp:param name="itemsAttribute" value="codeMonetaireEnum"/>
                        <jsp:param name="showCode" value="true"/>
                        <jsp:param name="requiredType" value="fixed"/>
                        <jsp:param name="bases" value="B C"/>
                    </jsp:include>
                    <jsp:include page="/WEB-INF/pages/sybris/formulaires/Commun aux bases/commun/field-text.jsp">
                        <jsp:param name="fieldId" value="option"/>
                        <jsp:param name="label" value="Option"/>
                        <jsp:param name="placeholder" value="Option"/>
                        <jsp:param name="maxLength" value="1"/>
                        <jsp:param name="requiredType" value=""/>
                        <jsp:param name="bases" value="C"/>
                        <jsp:param name="types" value="DECLARATION"/>
                    </jsp:include>
                    <jsp:include page="/WEB-INF/pages/sybris/formulaires/Commun aux bases/commun/field-text.jsp">
                        <jsp:param name="fieldId" value="criteresSuiviMEG"/>
                        <jsp:param name="label" value="Critère de suivi de MEG"/>
                        <jsp:param name="placeholder" value="Critère de suivi de MEG"/>
                        <jsp:param name="maxLength" value="4"/>
                        <jsp:param name="requiredType" value=""/>
                        <jsp:param name="bases" value="C"/>
                        <jsp:param name="types" value="DECLARATION"/>
                    </jsp:include>
                    <jsp:include page="/WEB-INF/pages/sybris/formulaires/Commun aux bases/commun/field-text.jsp">
                        <jsp:param name="fieldId" value="motifSuspension"/>
                        <jsp:param name="label" value="Motif suspension"/>
                        <jsp:param name="placeholder" value="Motif suspension"/>
                        <jsp:param name="maxLength" value="3"/>
                        <jsp:param name="requiredType" value=""/>
                        <jsp:param name="bases" value="C"/>
                        <jsp:param name="types" value="DECLARATION"/>
                    </jsp:include>
                    <jsp:include page="/WEB-INF/pages/sybris/formulaires/Commun aux bases/commun/field-text.jsp">
                        <jsp:param name="fieldId" value="topPret"/>
                        <jsp:param name="label" value="Top prêt"/>
                        <jsp:param name="placeholder" value="Top prêt"/>
                        <jsp:param name="maxLength" value="3"/>
                        <jsp:param name="requiredType" value=""/>
                        <jsp:param name="bases" value="C"/>
                        <jsp:param name="types" value="DECLARATION"/>
                    </jsp:include>
                    <jsp:include page="/WEB-INF/pages/sybris/formulaires/Commun aux bases/commun/field-text.jsp">
                        <jsp:param name="fieldId" value="megCatalogue"/>
                        <jsp:param name="label" value="MEG catalogue"/>
                        <jsp:param name="placeholder" value="MEG catalogue"/>
                        <jsp:param name="maxLength" value="2"/>
                        <jsp:param name="requiredType" value=""/>
                        <jsp:param name="bases" value="C"/>
                        <jsp:param name="types" value="DECLARATION"/>
                    </jsp:include>
                    <jsp:include page="/WEB-INF/pages/sybris/formulaires/Commun aux bases/commun/field-text.jsp">
                        <jsp:param name="fieldId" value="codeRisqueAggrave"/>
                        <jsp:param name="label" value="Code risque aggravé"/>
                        <jsp:param name="placeholder" value="Code risque aggravé"/>
                        <jsp:param name="maxLength" value="4"/>
                        <jsp:param name="requiredType" value=""/>
                        <jsp:param name="bases" value="C"/>
                        <jsp:param name="types" value="DECLARATION"/>
                    </jsp:include>
                </div>
            </div>
        </div>
        <div class="form-subsection" data-bases="A" data-types="DECLARATION">
            <div class="form-subsection-header collapsed" onclick="toggleSubsection(this)">
                <span class="form-subsection-icon">▸</span>
                <h6>Fillers / champs non utilisés — Base A, Declaration</h6>
            </div>
            <div class="form-subsection-body">
                <div class="form-container">
                    <jsp:include page="/WEB-INF/pages/sybris/formulaires/Commun aux bases/commun/field-filler.jsp">
                        <jsp:param name="fieldID" value="Filler (73)"/>
                        <jsp:param name="name" value="filler73_pret_DECLARATION_A"/>
                        <jsp:param name="fillerPosition" value="73"/>
                        <jsp:param name="fillerLength" value="2"/>
                        <jsp:param name="bases" value="A"/>
                        <jsp:param name="types" value="DECLARATION"/>
                    </jsp:include>
                    <jsp:include page="/WEB-INF/pages/sybris/formulaires/Commun aux bases/commun/field-filler.jsp">
                        <jsp:param name="fieldID" value="Filler (93)"/>
                        <jsp:param name="name" value="filler93_pret_DECLARATION_A"/>
                        <jsp:param name="fillerPosition" value="93"/>
                        <jsp:param name="fillerLength" value="4"/>
                        <jsp:param name="bases" value="A"/>
                        <jsp:param name="types" value="DECLARATION"/>
                    </jsp:include>
                    <jsp:include page="/WEB-INF/pages/sybris/formulaires/Commun aux bases/commun/field-filler.jsp">
                        <jsp:param name="fieldID" value="Filler (162)"/>
                        <jsp:param name="name" value="filler162_pret_DECLARATION_A"/>
                        <jsp:param name="fillerPosition" value="162"/>
                        <jsp:param name="fillerLength" value="23"/>
                        <jsp:param name="bases" value="A"/>
                        <jsp:param name="types" value="DECLARATION"/>
                    </jsp:include>
                    <jsp:include page="/WEB-INF/pages/sybris/formulaires/Commun aux bases/commun/field-filler.jsp">
                        <jsp:param name="fieldID" value="Filler (189)"/>
                        <jsp:param name="name" value="filler189_pret_DECLARATION_A"/>
                        <jsp:param name="fillerPosition" value="189"/>
                        <jsp:param name="fillerLength" value="1"/>
                        <jsp:param name="bases" value="A"/>
                        <jsp:param name="types" value="DECLARATION"/>
                    </jsp:include>
                    <jsp:include page="/WEB-INF/pages/sybris/formulaires/Commun aux bases/commun/field-filler.jsp">
                        <jsp:param name="fieldID" value="Filler (197)"/>
                        <jsp:param name="name" value="filler197_pret_DECLARATION_A"/>
                        <jsp:param name="fillerPosition" value="197"/>
                        <jsp:param name="fillerLength" value="38"/>
                        <jsp:param name="bases" value="A"/>
                        <jsp:param name="types" value="DECLARATION"/>
                    </jsp:include>
                </div>
            </div>
        </div>
        <div class="form-subsection" data-bases="B" data-types="DECLARATION">
            <div class="form-subsection-header collapsed" onclick="toggleSubsection(this)">
                <span class="form-subsection-icon">▸</span>
                <h6>Fillers / champs non utilisés — Base B, Declaration</h6>
            </div>
            <div class="form-subsection-body">
                <div class="form-container">
                    <jsp:include page="/WEB-INF/pages/sybris/formulaires/Commun aux bases/commun/field-filler.jsp">
                        <jsp:param name="fieldID" value="Filler (70)"/>
                        <jsp:param name="name" value="filler70_pret_DECLARATION_B"/>
                        <jsp:param name="fillerPosition" value="70"/>
                        <jsp:param name="fillerLength" value="5"/>
                        <jsp:param name="bases" value="B"/>
                        <jsp:param name="types" value="DECLARATION"/>
                    </jsp:include>
                    <jsp:include page="/WEB-INF/pages/sybris/formulaires/Commun aux bases/commun/field-filler.jsp">
                        <jsp:param name="fieldID" value="Filler (93)"/>
                        <jsp:param name="name" value="filler93_pret_DECLARATION_B"/>
                        <jsp:param name="fillerPosition" value="93"/>
                        <jsp:param name="fillerLength" value="1"/>
                        <jsp:param name="bases" value="B"/>
                        <jsp:param name="types" value="DECLARATION"/>
                    </jsp:include>
                    <jsp:include page="/WEB-INF/pages/sybris/formulaires/Commun aux bases/commun/field-filler.jsp">
                        <jsp:param name="fieldID" value="Filler (173)"/>
                        <jsp:param name="name" value="filler173_pret_DECLARATION_B"/>
                        <jsp:param name="fillerPosition" value="173"/>
                        <jsp:param name="fillerLength" value="8"/>
                        <jsp:param name="bases" value="B"/>
                        <jsp:param name="types" value="DECLARATION"/>
                    </jsp:include>
                    <jsp:include page="/WEB-INF/pages/sybris/formulaires/Commun aux bases/commun/field-filler.jsp">
                        <jsp:param name="fieldID" value="Filler (184)"/>
                        <jsp:param name="name" value="filler184_pret_DECLARATION_B"/>
                        <jsp:param name="fillerPosition" value="184"/>
                        <jsp:param name="fillerLength" value="5"/>
                        <jsp:param name="bases" value="B"/>
                        <jsp:param name="types" value="DECLARATION"/>
                    </jsp:include>
                    <jsp:include page="/WEB-INF/pages/sybris/formulaires/Commun aux bases/commun/field-filler.jsp">
                        <jsp:param name="fieldID" value="Filler (190)"/>
                        <jsp:param name="name" value="filler190_pret_DECLARATION_B"/>
                        <jsp:param name="fillerPosition" value="190"/>
                        <jsp:param name="fillerLength" value="7"/>
                        <jsp:param name="bases" value="B"/>
                        <jsp:param name="types" value="DECLARATION"/>
                    </jsp:include>
                    <jsp:include page="/WEB-INF/pages/sybris/formulaires/Commun aux bases/commun/field-filler.jsp">
                        <jsp:param name="fieldID" value="Filler (200)"/>
                        <jsp:param name="name" value="filler200_pret_DECLARATION_B"/>
                        <jsp:param name="fillerPosition" value="200"/>
                        <jsp:param name="fillerLength" value="40"/>
                        <jsp:param name="bases" value="B"/>
                        <jsp:param name="types" value="DECLARATION"/>
                    </jsp:include>
                </div>
            </div>
        </div>
        <div class="form-subsection" data-bases="C" data-types="DECLARATION">
            <div class="form-subsection-header collapsed" onclick="toggleSubsection(this)">
                <span class="form-subsection-icon">▸</span>
                <h6>Fillers / champs non utilisés — Base C, Declaration</h6>
            </div>
            <div class="form-subsection-body">
                <div class="form-container">
                    <jsp:include page="/WEB-INF/pages/sybris/formulaires/Commun aux bases/commun/field-filler.jsp">
                        <jsp:param name="fieldID" value="Filler (215)"/>
                        <jsp:param name="name" value="filler215_pret_DECLARATION_C"/>
                        <jsp:param name="fillerPosition" value="215"/>
                        <jsp:param name="fillerLength" value="26"/>
                        <jsp:param name="bases" value="C"/>
                        <jsp:param name="types" value="DECLARATION"/>
                    </jsp:include>
                </div>
            </div>
        </div>
        <div class="form-subsection" data-bases="A" data-types="PROLONGATION">
            <div class="form-subsection-header collapsed" onclick="toggleSubsection(this)">
                <span class="form-subsection-icon">▸</span>
                <h6>Fillers / champs non utilisés — Base A, Prolongation</h6>
            </div>
            <div class="form-subsection-body">
                <div class="form-container">
                    <jsp:include page="/WEB-INF/pages/sybris/formulaires/Commun aux bases/commun/field-filler.jsp">
                        <jsp:param name="fieldID" value="Filler (70)"/>
                        <jsp:param name="name" value="filler70_pret_PROLONGATION_A"/>
                        <jsp:param name="fillerPosition" value="70"/>
                        <jsp:param name="fillerLength" value="165"/>
                        <jsp:param name="bases" value="A"/>
                        <jsp:param name="types" value="PROLONGATION"/>
                    </jsp:include>
                </div>
            </div>
        </div>
        <div class="form-subsection" data-bases="B" data-types="PROLONGATION">
            <div class="form-subsection-header collapsed" onclick="toggleSubsection(this)">
                <span class="form-subsection-icon">▸</span>
                <h6>Fillers / champs non utilisés — Base B, Prolongation</h6>
            </div>
            <div class="form-subsection-body">
                <div class="form-container">
                    <jsp:include page="/WEB-INF/pages/sybris/formulaires/Commun aux bases/commun/field-filler.jsp">
                        <jsp:param name="fieldID" value="Filler (73)"/>
                        <jsp:param name="name" value="filler73_pret_PROLONGATION_B"/>
                        <jsp:param name="fillerPosition" value="73"/>
                        <jsp:param name="fillerLength" value="168"/>
                        <jsp:param name="bases" value="B"/>
                        <jsp:param name="types" value="PROLONGATION"/>
                    </jsp:include>
                </div>
            </div>
        </div>
        <div class="form-subsection" data-bases="C" data-types="PROLONGATION">
            <div class="form-subsection-header collapsed" onclick="toggleSubsection(this)">
                <span class="form-subsection-icon">▸</span>
                <h6>Fillers / champs non utilisés — Base C, Prolongation</h6>
            </div>
            <div class="form-subsection-body">
                <div class="form-container">
                    <jsp:include page="/WEB-INF/pages/sybris/formulaires/Commun aux bases/commun/field-filler.jsp">
                        <jsp:param name="fieldID" value="Filler (71)"/>
                        <jsp:param name="name" value="filler71_pret_PROLONGATION_C"/>
                        <jsp:param name="fillerPosition" value="71"/>
                        <jsp:param name="fillerLength" value="170"/>
                        <jsp:param name="bases" value="C"/>
                        <jsp:param name="types" value="PROLONGATION"/>
                    </jsp:include>
                </div>
            </div>
        </div>
    </div>
</div>
