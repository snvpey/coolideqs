<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!--
  Modèle "Prêt", dans #pret-templates : garde le système par-combo
  (6 .base-type-block, un par base x type), PAS le système
  data-bases/data-types de dossier.jsp/adresse.jsp — ce bloc est
  CLONÉ tel quel par SybrisPayload.addPret() à chaque clic sur
  "Ajouter un prêt" (voir _storePretTemplates()/_getPretTemplate()),
  donc chaque template doit rester autonome et ne contenir QUE les
  champs de SA combinaison. _readPretInstanceFields() lit ensuite
  l'instance clonée sans filtrage supplémentaire — aucun changement
  nécessaire côté payload.js pour cette partie. Champs regroupés en
  sous-sections (.form-subsection) dans un .sybris-subform, comme
  dossier.jsp/adresse.jsp.
-->
<div class="base-type-block" data-base="A" data-type="DECLARATION" style="display:none">
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
                    </jsp:include>
                    <jsp:include page="/WEB-INF/pages/sybris/formulaires/Commun aux bases/commun/field-text.jsp">
                        <jsp:param name="fieldId" value="numeroContratCNP"/>
                        <jsp:param name="label" value="Contrat"/>
                        <jsp:param name="placeholder" value="Contrat"/>
                        <jsp:param name="maxLength" value="5"/>
                        <jsp:param name="requiredType" value="fixed"/>
                    </jsp:include>
                    <jsp:include page="/WEB-INF/pages/sybris/formulaires/Commun aux bases/commun/field-select.jsp">
                        <jsp:param name="fieldId" value="modaliteEntree"/>
                        <jsp:param name="label" value="Modalité d'entrée"/>
                        <jsp:param name="itemsAttribute" value="modalitesEntreeBaseA"/>
                        <jsp:param name="showCode" value="true"/>
                        <jsp:param name="requiredType" value="fixed"/>
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
                    <div class="input-container">
                        <label for="dateEntreeAssurance_A_DECLARATION">Date de prise d'effet <span class="sybris-required-mark">*</span></label>
                        <input type="date" id="dateEntreeAssurance_A_DECLARATION" name="dateEntreeAssurance" required>
                    </div>
                    <div class="input-container" data-required-when="modaliteEntree=='QSC'">
                        <label for="dateSignature_A_DECLARATION">Date de signature <span class="sybris-conditional-mark hidden">*</span></label>
                        <input type="date" id="dateSignature_A_DECLARATION" name="dateSignature">
                    </div>
                    <jsp:include page="/WEB-INF/pages/sybris/formulaires/Commun aux bases/commun/field-text.jsp">
                        <jsp:param name="fieldId" value="referenceLiasse"/>
                        <jsp:param name="label" value="Référence de liasse"/>
                        <jsp:param name="placeholder" value="Référence de liasse"/>
                        <jsp:param name="maxLength" value="20"/>
                        <jsp:param name="requiredType" value="conditional"/>
                        <jsp:param name="conditionalExpr" value="modaliteEntree=='QSC'"/>
                    </jsp:include>
                    <div class="input-container" data-required-when="modaliteEntree=='QSC'">
                        <label for="dateAcceptation_A_DECLARATION">Date de réponse CNP <span class="sybris-conditional-mark hidden">*</span></label>
                        <input type="date" id="dateAcceptation_A_DECLARATION" name="dateAcceptation">
                    </div>
                    <div class="input-container">
                        <label for="dateDerniereEcheance_A_DECLARATION">Date dernière échéance <span class="sybris-required-mark">*</span></label>
                        <input type="date" id="dateDerniereEcheance_A_DECLARATION" name="dateDerniereEcheance" required>
                    </div>
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
                    </jsp:include>
                    <jsp:include page="/WEB-INF/pages/sybris/formulaires/Commun aux bases/commun/field-text.jsp">
                        <jsp:param name="fieldId" value="montantInitial"/>
                        <jsp:param name="label" value="Montant initial (dont 2 décimales)"/>
                        <jsp:param name="placeholder" value="Montant initial (dont 2 décimales)"/>
                        <jsp:param name="maxLength" value="12"/>
                        <jsp:param name="requiredType" value=""/>
                    </jsp:include>
                    <jsp:include page="/WEB-INF/pages/sybris/formulaires/Commun aux bases/commun/field-select.jsp">
                        <jsp:param name="fieldId" value="periodicite"/>
                        <jsp:param name="label" value="Périodicité"/>
                        <jsp:param name="itemsAttribute" value="periodicites"/>
                        <jsp:param name="showCode" value="true"/>
                        <jsp:param name="requiredType" value="fixed"/>
                    </jsp:include>
                    <jsp:include page="/WEB-INF/pages/sybris/formulaires/Commun aux bases/commun/field-select.jsp">
                        <jsp:param name="fieldId" value="natureEcheance"/>
                        <jsp:param name="label" value="Nature d'échéance"/>
                        <jsp:param name="itemsAttribute" value="naturesEcheance"/>
                        <jsp:param name="showCode" value="true"/>
                        <jsp:param name="requiredType" value="fixed"/>
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
                    </jsp:include>
                    <jsp:include page="/WEB-INF/pages/sybris/formulaires/Commun aux bases/commun/field-select.jsp">
                        <jsp:param name="fieldId" value="criteresSuiviContrat"/>
                        <jsp:param name="label" value="Critère de suivi de contrat"/>
                        <jsp:param name="itemsAttribute" value="criteresSuiviContratBaseA"/>
                        <jsp:param name="showCode" value="true"/>
                        <jsp:param name="requiredType" value=""/>
                    </jsp:include>
                    <jsp:include page="/WEB-INF/pages/sybris/formulaires/Commun aux bases/commun/field-text.jsp">
                        <jsp:param name="fieldId" value="dureMaxIndemnisation"/>
                        <jsp:param name="label" value="Durée maximale d'indemnisation (jours)"/>
                        <jsp:param name="placeholder" value="Durée maximale d'indemnisation (jours)"/>
                        <jsp:param name="maxLength" value="4"/>
                        <jsp:param name="requiredType" value="fixed"/>
                    </jsp:include>
                    <jsp:include page="/WEB-INF/pages/sybris/formulaires/Commun aux bases/commun/field-text.jsp">
                        <jsp:param name="fieldId" value="caisseOrigine"/>
                        <jsp:param name="label" value="Caisse d'origine"/>
                        <jsp:param name="placeholder" value="Caisse d'origine"/>
                        <jsp:param name="maxLength" value="3"/>
                        <jsp:param name="requiredType" value="conditional"/>
                        <jsp:param name="conditionalExpr" value="fusion CR"/>
                    </jsp:include>
                </div>
            </div>
        </div>
        <div class="form-subsection">
            <div class="form-subsection-header collapsed" onclick="toggleSubsection(this)">
                <span class="form-subsection-icon">▸</span>
                <h6>Fillers / champs non utilisés (optionnel)</h6>
            </div>
            <div class="form-subsection-body">
                <div class="form-container">
                    <jsp:include page="/WEB-INF/pages/sybris/formulaires/Commun aux bases/commun/field-filler.jsp">
                        <jsp:param name="fieldID" value="Filler (73)"/>
                        <jsp:param name="name" value="filler73_pret_A_DECLARATION"/>
                        <jsp:param name="fillerPosition" value="73"/>
                        <jsp:param name="fillerLength" value="2"/>
                    </jsp:include>
                    <jsp:include page="/WEB-INF/pages/sybris/formulaires/Commun aux bases/commun/field-filler.jsp">
                        <jsp:param name="fieldID" value="Filler (93)"/>
                        <jsp:param name="name" value="filler93_pret_A_DECLARATION"/>
                        <jsp:param name="fillerPosition" value="93"/>
                        <jsp:param name="fillerLength" value="4"/>
                    </jsp:include>
                    <jsp:include page="/WEB-INF/pages/sybris/formulaires/Commun aux bases/commun/field-filler.jsp">
                        <jsp:param name="fieldID" value="Filler (162)"/>
                        <jsp:param name="name" value="filler162_pret_A_DECLARATION"/>
                        <jsp:param name="fillerPosition" value="162"/>
                        <jsp:param name="fillerLength" value="23"/>
                    </jsp:include>
                    <jsp:include page="/WEB-INF/pages/sybris/formulaires/Commun aux bases/commun/field-filler.jsp">
                        <jsp:param name="fieldID" value="Filler (189)"/>
                        <jsp:param name="name" value="filler189_pret_A_DECLARATION"/>
                        <jsp:param name="fillerPosition" value="189"/>
                        <jsp:param name="fillerLength" value="1"/>
                    </jsp:include>
                    <jsp:include page="/WEB-INF/pages/sybris/formulaires/Commun aux bases/commun/field-filler.jsp">
                        <jsp:param name="fieldID" value="Filler (197)"/>
                        <jsp:param name="name" value="filler197_pret_A_DECLARATION"/>
                        <jsp:param name="fillerPosition" value="197"/>
                        <jsp:param name="fillerLength" value="38"/>
                    </jsp:include>
                </div>
            </div>
        </div>
    </div>
</div>
<div class="base-type-block" data-base="B" data-type="DECLARATION" style="display:none">
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
                        <jsp:param name="fieldId" value="numeroContratCNP"/>
                        <jsp:param name="label" value="Numéro contrat CNP"/>
                        <jsp:param name="placeholder" value="Numéro contrat CNP"/>
                        <jsp:param name="maxLength" value="5"/>
                        <jsp:param name="requiredType" value="fixed"/>
                    </jsp:include>
                    <jsp:include page="/WEB-INF/pages/sybris/formulaires/Commun aux bases/commun/field-select.jsp">
                        <jsp:param name="fieldId" value="qualiteEmprunteur"/>
                        <jsp:param name="label" value="Qualité d'emprunteur"/>
                        <jsp:param name="itemsAttribute" value="qualitesEmprunteurBaseB"/>
                        <jsp:param name="showCode" value="true"/>
                        <jsp:param name="requiredType" value="fixed"/>
                    </jsp:include>
                    <jsp:include page="/WEB-INF/pages/sybris/formulaires/Commun aux bases/commun/field-select.jsp">
                        <jsp:param name="fieldId" value="modaliteEntree"/>
                        <jsp:param name="label" value="Modalité d'entrée"/>
                        <jsp:param name="itemsAttribute" value="modalitesEntreeBaseB"/>
                        <jsp:param name="showCode" value="true"/>
                        <jsp:param name="requiredType" value="fixed"/>
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
                    <div class="input-container">
                        <label for="dateEntreeAssurance_B_DECLARATION">Date d'entrée dans l'assurance <span class="sybris-required-mark">*</span></label>
                        <input type="date" id="dateEntreeAssurance_B_DECLARATION" name="dateEntreeAssurance" required>
                    </div>
                    <div class="input-container" data-required-when="modaliteEntree=='QSC'">
                        <label for="dateSignature_B_DECLARATION">Date de signature <span class="sybris-conditional-mark hidden">*</span></label>
                        <input type="date" id="dateSignature_B_DECLARATION" name="dateSignature">
                    </div>
                    <jsp:include page="/WEB-INF/pages/sybris/formulaires/Commun aux bases/commun/field-text.jsp">
                        <jsp:param name="fieldId" value="referenceLiasse"/>
                        <jsp:param name="label" value="Référence de liasse"/>
                        <jsp:param name="placeholder" value="Référence de liasse"/>
                        <jsp:param name="maxLength" value="20"/>
                        <jsp:param name="requiredType" value="conditional"/>
                        <jsp:param name="conditionalExpr" value="modaliteEntree=='QSC'"/>
                    </jsp:include>
                    <div class="input-container" data-required-when="modaliteEntree=='QSC'">
                        <label for="dateAcceptation_B_DECLARATION">Date d'acceptation <span class="sybris-conditional-mark hidden">*</span></label>
                        <input type="date" id="dateAcceptation_B_DECLARATION" name="dateAcceptation">
                    </div>
                    <div class="input-container">
                        <label for="dateDerniereEcheance_B_DECLARATION">Date dernière échéance <span class="sybris-required-mark">*</span></label>
                        <input type="date" id="dateDerniereEcheance_B_DECLARATION" name="dateDerniereEcheance" required>
                    </div>
                    <div class="input-container" data-required-when="risque==4">
                        <label for="dateOrigine_B_DECLARATION">Date d'origine <span class="sybris-conditional-mark hidden">*</span></label>
                        <input type="date" id="dateOrigine_B_DECLARATION" name="dateOrigine">
                    </div>
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
                        <jsp:param name="label" value="Quotité (< 10000, dont 2 décimales)"/>
                        <jsp:param name="placeholder" value="Quotité (< 10000, dont 2 décimales)"/>
                        <jsp:param name="maxLength" value="5"/>
                        <jsp:param name="requiredType" value="fixed"/>
                    </jsp:include>
                    <jsp:include page="/WEB-INF/pages/sybris/formulaires/Commun aux bases/commun/field-text.jsp">
                        <jsp:param name="fieldId" value="montantInitial"/>
                        <jsp:param name="label" value="Montant initial (dont 2 décimales)"/>
                        <jsp:param name="placeholder" value="Montant initial (dont 2 décimales)"/>
                        <jsp:param name="maxLength" value="12"/>
                        <jsp:param name="requiredType" value="fixed"/>
                    </jsp:include>
                    <jsp:include page="/WEB-INF/pages/sybris/formulaires/Commun aux bases/commun/field-select.jsp">
                        <jsp:param name="fieldId" value="periodicite"/>
                        <jsp:param name="label" value="Périodicité"/>
                        <jsp:param name="itemsAttribute" value="periodicites"/>
                        <jsp:param name="showCode" value="true"/>
                        <jsp:param name="requiredType" value="fixed"/>
                    </jsp:include>
                    <jsp:include page="/WEB-INF/pages/sybris/formulaires/Commun aux bases/commun/field-select.jsp">
                        <jsp:param name="fieldId" value="natureEcheance"/>
                        <jsp:param name="label" value="Nature d'échéance"/>
                        <jsp:param name="itemsAttribute" value="naturesEcheance"/>
                        <jsp:param name="showCode" value="true"/>
                        <jsp:param name="requiredType" value="fixed"/>
                    </jsp:include>
                    <jsp:include page="/WEB-INF/pages/sybris/formulaires/Commun aux bases/commun/field-select.jsp">
                        <jsp:param name="fieldId" value="modalitePaiement"/>
                        <jsp:param name="label" value="Modalité paiement"/>
                        <jsp:param name="itemsAttribute" value="modalitesPaiement"/>
                        <jsp:param name="showCode" value="true"/>
                        <jsp:param name="requiredType" value="fixed"/>
                    </jsp:include>
                    <jsp:include page="/WEB-INF/pages/sybris/formulaires/Commun aux bases/commun/field-select.jsp">
                        <jsp:param name="fieldId" value="optionPersonneAgee"/>
                        <jsp:param name="label" value="Option personne âgée"/>
                        <jsp:param name="itemsAttribute" value="ouiNonList"/>
                        <jsp:param name="showCode" value="false"/>
                        <jsp:param name="requiredType" value="conditional"/>
                        <jsp:param name="conditionalExpr" value="risque!=4"/>
                    </jsp:include>
                    <jsp:include page="/WEB-INF/pages/sybris/formulaires/Commun aux bases/commun/field-text.jsp">
                        <jsp:param name="fieldId" value="delaiCarence"/>
                        <jsp:param name="label" value="Délai de carence (jours)"/>
                        <jsp:param name="placeholder" value="Délai de carence (jours)"/>
                        <jsp:param name="maxLength" value="3"/>
                        <jsp:param name="requiredType" value="fixed"/>
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
                    <jsp:include page="/WEB-INF/pages/sybris/formulaires/Commun aux bases/commun/field-select.jsp">
                        <jsp:param name="fieldId" value="categoriePret"/>
                        <jsp:param name="label" value="Catégorie prêt"/>
                        <jsp:param name="itemsAttribute" value="categoriesPretBaseB"/>
                        <jsp:param name="showCode" value="true"/>
                        <jsp:param name="requiredType" value="fixed"/>
                    </jsp:include>
                    <jsp:include page="/WEB-INF/pages/sybris/formulaires/Commun aux bases/commun/field-text.jsp">
                        <jsp:param name="fieldId" value="categorieIT"/>
                        <jsp:param name="label" value="Catégorie IT (1 = IT partielle)"/>
                        <jsp:param name="placeholder" value="Catégorie IT (1 = IT partielle)"/>
                        <jsp:param name="maxLength" value="1"/>
                        <jsp:param name="requiredType" value=""/>
                    </jsp:include>
                    <jsp:include page="/WEB-INF/pages/sybris/formulaires/Commun aux bases/commun/field-select.jsp">
                        <jsp:param name="fieldId" value="codeMonetaire"/>
                        <jsp:param name="label" value="Code monétaire"/>
                        <jsp:param name="itemsAttribute" value="codeMonetaireEnum"/>
                        <jsp:param name="showCode" value="true"/>
                        <jsp:param name="requiredType" value="fixed"/>
                    </jsp:include>
                </div>
            </div>
        </div>
        <div class="form-subsection">
            <div class="form-subsection-header collapsed" onclick="toggleSubsection(this)">
                <span class="form-subsection-icon">▸</span>
                <h6>Fillers / champs non utilisés (optionnel)</h6>
            </div>
            <div class="form-subsection-body">
                <div class="form-container">
                    <jsp:include page="/WEB-INF/pages/sybris/formulaires/Commun aux bases/commun/field-filler.jsp">
                        <jsp:param name="fieldID" value="Filler (70)"/>
                        <jsp:param name="name" value="filler70_pret_B_DECLARATION"/>
                        <jsp:param name="fillerPosition" value="70"/>
                        <jsp:param name="fillerLength" value="5"/>
                    </jsp:include>
                    <jsp:include page="/WEB-INF/pages/sybris/formulaires/Commun aux bases/commun/field-filler.jsp">
                        <jsp:param name="fieldID" value="Filler (93)"/>
                        <jsp:param name="name" value="filler93_pret_B_DECLARATION"/>
                        <jsp:param name="fillerPosition" value="93"/>
                        <jsp:param name="fillerLength" value="1"/>
                    </jsp:include>
                    <jsp:include page="/WEB-INF/pages/sybris/formulaires/Commun aux bases/commun/field-filler.jsp">
                        <jsp:param name="fieldID" value="Filler (173)"/>
                        <jsp:param name="name" value="filler173_pret_B_DECLARATION"/>
                        <jsp:param name="fillerPosition" value="173"/>
                        <jsp:param name="fillerLength" value="8"/>
                    </jsp:include>
                    <jsp:include page="/WEB-INF/pages/sybris/formulaires/Commun aux bases/commun/field-filler.jsp">
                        <jsp:param name="fieldID" value="Filler (184)"/>
                        <jsp:param name="name" value="filler184_pret_B_DECLARATION"/>
                        <jsp:param name="fillerPosition" value="184"/>
                        <jsp:param name="fillerLength" value="5"/>
                    </jsp:include>
                    <jsp:include page="/WEB-INF/pages/sybris/formulaires/Commun aux bases/commun/field-filler.jsp">
                        <jsp:param name="fieldID" value="Filler (190)"/>
                        <jsp:param name="name" value="filler190_pret_B_DECLARATION"/>
                        <jsp:param name="fillerPosition" value="190"/>
                        <jsp:param name="fillerLength" value="7"/>
                    </jsp:include>
                    <jsp:include page="/WEB-INF/pages/sybris/formulaires/Commun aux bases/commun/field-filler.jsp">
                        <jsp:param name="fieldID" value="Filler (200)"/>
                        <jsp:param name="name" value="filler200_pret_B_DECLARATION"/>
                        <jsp:param name="fillerPosition" value="200"/>
                        <jsp:param name="fillerLength" value="40"/>
                    </jsp:include>
                </div>
            </div>
        </div>
    </div>
</div>
<div class="base-type-block" data-base="C" data-type="DECLARATION" style="display:none">
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
                        <jsp:param name="label" value="Durée prêt"/>
                        <jsp:param name="placeholder" value="Durée prêt"/>
                        <jsp:param name="maxLength" value="3"/>
                        <jsp:param name="requiredType" value=""/>
                    </jsp:include>
                    <jsp:include page="/WEB-INF/pages/sybris/formulaires/Commun aux bases/commun/field-text.jsp">
                        <jsp:param name="fieldId" value="departementGage"/>
                        <jsp:param name="label" value="Département de gage"/>
                        <jsp:param name="placeholder" value="Département de gage"/>
                        <jsp:param name="maxLength" value="2"/>
                        <jsp:param name="requiredType" value=""/>
                    </jsp:include>
                    <jsp:include page="/WEB-INF/pages/sybris/formulaires/Commun aux bases/commun/field-text.jsp">
                        <jsp:param name="fieldId" value="numeroContratCNP"/>
                        <jsp:param name="label" value="Numéro contrat CNP"/>
                        <jsp:param name="placeholder" value="Numéro contrat CNP"/>
                        <jsp:param name="maxLength" value="5"/>
                        <jsp:param name="requiredType" value="fixed"/>
                    </jsp:include>
                    <jsp:include page="/WEB-INF/pages/sybris/formulaires/Commun aux bases/commun/field-text.jsp">
                        <jsp:param name="fieldId" value="numeroTete"/>
                        <jsp:param name="label" value="Numéro de tête"/>
                        <jsp:param name="placeholder" value="Numéro de tête"/>
                        <jsp:param name="maxLength" value="1"/>
                        <jsp:param name="requiredType" value=""/>
                    </jsp:include>
                    <jsp:include page="/WEB-INF/pages/sybris/formulaires/Commun aux bases/commun/field-select.jsp">
                        <jsp:param name="fieldId" value="qualiteEmprunteur"/>
                        <jsp:param name="label" value="Qualité d'emprunteur"/>
                        <jsp:param name="itemsAttribute" value="qualitesEmprunteurBaseC"/>
                        <jsp:param name="showCode" value="true"/>
                        <jsp:param name="requiredType" value="fixed"/>
                    </jsp:include>
                    <jsp:include page="/WEB-INF/pages/sybris/formulaires/Commun aux bases/commun/field-select.jsp">
                        <jsp:param name="fieldId" value="modaliteEntree"/>
                        <jsp:param name="label" value="Modalité d'entrée"/>
                        <jsp:param name="itemsAttribute" value="modalitesEntreeBaseC"/>
                        <jsp:param name="showCode" value="true"/>
                        <jsp:param name="requiredType" value="fixed"/>
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
                    <div class="input-container">
                        <label for="dateEntreeAssurance_C_DECLARATION">Date d'entrée dans l'assurance <span class="sybris-required-mark">*</span></label>
                        <input type="date" id="dateEntreeAssurance_C_DECLARATION" name="dateEntreeAssurance" required>
                    </div>
                    <div class="input-container">
                        <label for="dateSignature_C_DECLARATION">Date de signature</label>
                        <input type="date" id="dateSignature_C_DECLARATION" name="dateSignature">
                    </div>
                    <jsp:include page="/WEB-INF/pages/sybris/formulaires/Commun aux bases/commun/field-text.jsp">
                        <jsp:param name="fieldId" value="referenceLiasse"/>
                        <jsp:param name="label" value="Référence de liasse"/>
                        <jsp:param name="placeholder" value="Référence de liasse"/>
                        <jsp:param name="maxLength" value="20"/>
                        <jsp:param name="requiredType" value="conditional"/>
                        <jsp:param name="conditionalExpr" value="modaliteEntree in [QSC,QSD,QM,QS]"/>
                    </jsp:include>
                    <div class="input-container" data-required-when="modaliteEntree=='QSC'">
                        <label for="dateAcceptation_C_DECLARATION">Date d'acceptation <span class="sybris-conditional-mark hidden">*</span></label>
                        <input type="date" id="dateAcceptation_C_DECLARATION" name="dateAcceptation">
                    </div>
                    <div class="input-container">
                        <label for="dateDerniereEcheance_C_DECLARATION">Date dernière échéance <span class="sybris-required-mark">*</span></label>
                        <input type="date" id="dateDerniereEcheance_C_DECLARATION" name="dateDerniereEcheance" required>
                    </div>
                    <div class="input-container" data-required-when="risque==4">
                        <label for="dateOrigine_C_DECLARATION">Date d'origine <span class="sybris-conditional-mark hidden">*</span></label>
                        <input type="date" id="dateOrigine_C_DECLARATION" name="dateOrigine">
                    </div>
                    <div class="input-container">
                        <label for="dateAdhesionITDC_C_DECLARATION">Date d'adhésion IT/DC</label>
                        <input type="date" id="dateAdhesionITDC_C_DECLARATION" name="dateAdhesionITDC">
                    </div>
                    <jsp:include page="/WEB-INF/pages/sybris/formulaires/Commun aux bases/commun/field-text.jsp">
                        <jsp:param name="fieldId" value="dateFinPret"/>
                        <jsp:param name="label" value="Date de fin de prêt"/>
                        <jsp:param name="placeholder" value="Date de fin de prêt"/>
                        <jsp:param name="maxLength" value="5"/>
                        <jsp:param name="requiredType" value=""/>
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
                        <jsp:param name="label" value="Quotité (<= 10000, dont 2 décimales)"/>
                        <jsp:param name="placeholder" value="Quotité (<= 10000, dont 2 décimales)"/>
                        <jsp:param name="maxLength" value="5"/>
                        <jsp:param name="requiredType" value="fixed"/>
                    </jsp:include>
                    <jsp:include page="/WEB-INF/pages/sybris/formulaires/Commun aux bases/commun/field-text.jsp">
                        <jsp:param name="fieldId" value="montantInitial"/>
                        <jsp:param name="label" value="Montant initial (dont 2 décimales)"/>
                        <jsp:param name="placeholder" value="Montant initial (dont 2 décimales)"/>
                        <jsp:param name="maxLength" value="12"/>
                        <jsp:param name="requiredType" value="fixed"/>
                    </jsp:include>
                    <jsp:include page="/WEB-INF/pages/sybris/formulaires/Commun aux bases/commun/field-select.jsp">
                        <jsp:param name="fieldId" value="periodicite"/>
                        <jsp:param name="label" value="Périodicité"/>
                        <jsp:param name="itemsAttribute" value="periodicites"/>
                        <jsp:param name="showCode" value="true"/>
                        <jsp:param name="requiredType" value="fixed"/>
                    </jsp:include>
                    <jsp:include page="/WEB-INF/pages/sybris/formulaires/Commun aux bases/commun/field-select.jsp">
                        <jsp:param name="fieldId" value="natureEcheance"/>
                        <jsp:param name="label" value="Nature d'échéance"/>
                        <jsp:param name="itemsAttribute" value="naturesEcheance"/>
                        <jsp:param name="showCode" value="true"/>
                        <jsp:param name="requiredType" value="fixed"/>
                    </jsp:include>
                    <jsp:include page="/WEB-INF/pages/sybris/formulaires/Commun aux bases/commun/field-select.jsp">
                        <jsp:param name="fieldId" value="modalitePaiement"/>
                        <jsp:param name="label" value="Modalité paiement"/>
                        <jsp:param name="itemsAttribute" value="modalitesPaiement"/>
                        <jsp:param name="showCode" value="true"/>
                        <jsp:param name="requiredType" value="fixed"/>
                    </jsp:include>
                    <jsp:include page="/WEB-INF/pages/sybris/formulaires/Commun aux bases/commun/field-select.jsp">
                        <jsp:param name="fieldId" value="optionPersonneAgee"/>
                        <jsp:param name="label" value="Option personne âgée"/>
                        <jsp:param name="itemsAttribute" value="ouiNonList"/>
                        <jsp:param name="showCode" value="false"/>
                        <jsp:param name="requiredType" value="fixed"/>
                    </jsp:include>
                    <jsp:include page="/WEB-INF/pages/sybris/formulaires/Commun aux bases/commun/field-text.jsp">
                        <jsp:param name="fieldId" value="delaiCarence"/>
                        <jsp:param name="label" value="Délai de carence (jours)"/>
                        <jsp:param name="placeholder" value="Délai de carence (jours)"/>
                        <jsp:param name="maxLength" value="3"/>
                        <jsp:param name="requiredType" value="fixed"/>
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
                    <jsp:include page="/WEB-INF/pages/sybris/formulaires/Commun aux bases/commun/field-select.jsp">
                        <jsp:param name="fieldId" value="categoriePret"/>
                        <jsp:param name="label" value="Catégorie prêt"/>
                        <jsp:param name="itemsAttribute" value="categoriesPretBaseC"/>
                        <jsp:param name="showCode" value="true"/>
                        <jsp:param name="requiredType" value="fixed"/>
                    </jsp:include>
                    <jsp:include page="/WEB-INF/pages/sybris/formulaires/Commun aux bases/commun/field-text.jsp">
                        <jsp:param name="fieldId" value="option"/>
                        <jsp:param name="label" value="Option"/>
                        <jsp:param name="placeholder" value="Option"/>
                        <jsp:param name="maxLength" value="1"/>
                        <jsp:param name="requiredType" value=""/>
                    </jsp:include>
                    <jsp:include page="/WEB-INF/pages/sybris/formulaires/Commun aux bases/commun/field-text.jsp">
                        <jsp:param name="fieldId" value="criteresSuiviMEG"/>
                        <jsp:param name="label" value="Critère de suivi de MEG"/>
                        <jsp:param name="placeholder" value="Critère de suivi de MEG"/>
                        <jsp:param name="maxLength" value="4"/>
                        <jsp:param name="requiredType" value=""/>
                    </jsp:include>
                    <jsp:include page="/WEB-INF/pages/sybris/formulaires/Commun aux bases/commun/field-select.jsp">
                        <jsp:param name="fieldId" value="categorieIT"/>
                        <jsp:param name="label" value="Catégorie IT (1 = IT partielle)"/>
                        <jsp:param name="itemsAttribute" value="categoriesITBaseC"/>
                        <jsp:param name="showCode" value="false"/>
                        <jsp:param name="requiredType" value=""/>
                    </jsp:include>
                    <jsp:include page="/WEB-INF/pages/sybris/formulaires/Commun aux bases/commun/field-text.jsp">
                        <jsp:param name="fieldId" value="dureMaxIndemnisation"/>
                        <jsp:param name="label" value="Durée maximale d'indemnisation"/>
                        <jsp:param name="placeholder" value="Durée maximale d'indemnisation"/>
                        <jsp:param name="maxLength" value="4"/>
                        <jsp:param name="requiredType" value=""/>
                    </jsp:include>
                    <jsp:include page="/WEB-INF/pages/sybris/formulaires/Commun aux bases/commun/field-text.jsp">
                        <jsp:param name="fieldId" value="caisseOrigine"/>
                        <jsp:param name="label" value="Caisse d'origine"/>
                        <jsp:param name="placeholder" value="Caisse d'origine"/>
                        <jsp:param name="maxLength" value="3"/>
                        <jsp:param name="requiredType" value=""/>
                    </jsp:include>
                    <jsp:include page="/WEB-INF/pages/sybris/formulaires/Commun aux bases/commun/field-select.jsp">
                        <jsp:param name="fieldId" value="codeMonetaire"/>
                        <jsp:param name="label" value="Code monétaire"/>
                        <jsp:param name="itemsAttribute" value="codeMonetaireEnum"/>
                        <jsp:param name="showCode" value="true"/>
                        <jsp:param name="requiredType" value="fixed"/>
                    </jsp:include>
                    <jsp:include page="/WEB-INF/pages/sybris/formulaires/Commun aux bases/commun/field-text.jsp">
                        <jsp:param name="fieldId" value="motifSuspension"/>
                        <jsp:param name="label" value="Motif suspension"/>
                        <jsp:param name="placeholder" value="Motif suspension"/>
                        <jsp:param name="maxLength" value="3"/>
                        <jsp:param name="requiredType" value=""/>
                    </jsp:include>
                    <jsp:include page="/WEB-INF/pages/sybris/formulaires/Commun aux bases/commun/field-text.jsp">
                        <jsp:param name="fieldId" value="topPret"/>
                        <jsp:param name="label" value="Top prêt"/>
                        <jsp:param name="placeholder" value="Top prêt"/>
                        <jsp:param name="maxLength" value="3"/>
                        <jsp:param name="requiredType" value=""/>
                    </jsp:include>
                    <jsp:include page="/WEB-INF/pages/sybris/formulaires/Commun aux bases/commun/field-text.jsp">
                        <jsp:param name="fieldId" value="megCatalogue"/>
                        <jsp:param name="label" value="MEG catalogue"/>
                        <jsp:param name="placeholder" value="MEG catalogue"/>
                        <jsp:param name="maxLength" value="2"/>
                        <jsp:param name="requiredType" value=""/>
                    </jsp:include>
                    <jsp:include page="/WEB-INF/pages/sybris/formulaires/Commun aux bases/commun/field-text.jsp">
                        <jsp:param name="fieldId" value="codeRisqueAggrave"/>
                        <jsp:param name="label" value="Code risque aggravé"/>
                        <jsp:param name="placeholder" value="Code risque aggravé"/>
                        <jsp:param name="maxLength" value="4"/>
                        <jsp:param name="requiredType" value=""/>
                    </jsp:include>
                </div>
            </div>
        </div>
        <div class="form-subsection">
            <div class="form-subsection-header collapsed" onclick="toggleSubsection(this)">
                <span class="form-subsection-icon">▸</span>
                <h6>Fillers / champs non utilisés (optionnel)</h6>
            </div>
            <div class="form-subsection-body">
                <div class="form-container">
                    <jsp:include page="/WEB-INF/pages/sybris/formulaires/Commun aux bases/commun/field-filler.jsp">
                        <jsp:param name="fieldID" value="Filler (215)"/>
                        <jsp:param name="name" value="filler215_pret_C_DECLARATION"/>
                        <jsp:param name="fillerPosition" value="215"/>
                        <jsp:param name="fillerLength" value="26"/>
                    </jsp:include>
                </div>
            </div>
        </div>
    </div>
</div>
<div class="base-type-block" data-base="A" data-type="PROLONGATION" style="display:none">
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
                </div>
            </div>
        </div>
        <div class="form-subsection">
            <div class="form-subsection-header collapsed" onclick="toggleSubsection(this)">
                <span class="form-subsection-icon">▸</span>
                <h6>Fillers / champs non utilisés (optionnel)</h6>
            </div>
            <div class="form-subsection-body">
                <div class="form-container">
                    <jsp:include page="/WEB-INF/pages/sybris/formulaires/Commun aux bases/commun/field-filler.jsp">
                        <jsp:param name="fieldID" value="Filler (70)"/>
                        <jsp:param name="name" value="filler70_pret_A_PROLONGATION"/>
                        <jsp:param name="fillerPosition" value="70"/>
                        <jsp:param name="fillerLength" value="165"/>
                    </jsp:include>
                </div>
            </div>
        </div>
    </div>
</div>
<div class="base-type-block" data-base="B" data-type="PROLONGATION" style="display:none">
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
                    <jsp:include page="/WEB-INF/pages/sybris/formulaires/Commun aux bases/commun/field-select.jsp">
                        <jsp:param name="fieldId" value="codeMonetaire"/>
                        <jsp:param name="label" value="Code monétaire"/>
                        <jsp:param name="itemsAttribute" value="codeMonetaireEnum"/>
                        <jsp:param name="showCode" value="true"/>
                        <jsp:param name="requiredType" value="fixed"/>
                    </jsp:include>
                </div>
            </div>
        </div>
        <div class="form-subsection">
            <div class="form-subsection-header collapsed" onclick="toggleSubsection(this)">
                <span class="form-subsection-icon">▸</span>
                <h6>Fillers / champs non utilisés (optionnel)</h6>
            </div>
            <div class="form-subsection-body">
                <div class="form-container">
                    <jsp:include page="/WEB-INF/pages/sybris/formulaires/Commun aux bases/commun/field-filler.jsp">
                        <jsp:param name="fieldID" value="Filler (73)"/>
                        <jsp:param name="name" value="filler73_pret_B_PROLONGATION"/>
                        <jsp:param name="fillerPosition" value="73"/>
                        <jsp:param name="fillerLength" value="168"/>
                    </jsp:include>
                </div>
            </div>
        </div>
    </div>
</div>
<div class="base-type-block" data-base="C" data-type="PROLONGATION" style="display:none">
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
                    <jsp:include page="/WEB-INF/pages/sybris/formulaires/Commun aux bases/commun/field-select.jsp">
                        <jsp:param name="fieldId" value="codeMonetaire"/>
                        <jsp:param name="label" value="Code monétaire"/>
                        <jsp:param name="itemsAttribute" value="codeMonetaireEnum"/>
                        <jsp:param name="showCode" value="true"/>
                        <jsp:param name="requiredType" value="fixed"/>
                    </jsp:include>
                </div>
            </div>
        </div>
        <div class="form-subsection">
            <div class="form-subsection-header collapsed" onclick="toggleSubsection(this)">
                <span class="form-subsection-icon">▸</span>
                <h6>Fillers / champs non utilisés (optionnel)</h6>
            </div>
            <div class="form-subsection-body">
                <div class="form-container">
                    <jsp:include page="/WEB-INF/pages/sybris/formulaires/Commun aux bases/commun/field-filler.jsp">
                        <jsp:param name="fieldID" value="Filler (71)"/>
                        <jsp:param name="name" value="filler71_pret_C_PROLONGATION"/>
                        <jsp:param name="fillerPosition" value="71"/>
                        <jsp:param name="fillerLength" value="170"/>
                    </jsp:include>
                </div>
            </div>
        </div>
    </div>
</div>
