<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!--
  "Enregistrement Dossier" — un seul jeu de champs, chacun tagué
  bases="A B C" (sous-ensemble) et/ou types="DECLARATION PROLONGATION"
  (sous-ensemble) selon où il s'applique réellement. Un champ SANS
  attribut bases/types s'applique partout (identique dans les 6
  combinaisons). SybrisUI.refreshFieldVisibility() (ui.js) bascule
  chaque champ individuellement selon la base/le type courants —
  plus aucun bloc entier dupliqué 6 fois.
-->
<div class="form-container">
    <jsp:include page="/WEB-INF/pages/sybris/formulaires/Commun aux bases/commun/field-hidden-readonly.jsp">
        <jsp:param name="fieldId" value="typeEnregistrement"/>
        <jsp:param name="fieldName" value="typeEnregistrement"/>
        <jsp:param name="label" value="Type d'enregistrement (Dossier)"/>
        <jsp:param name="value" value="1"/>
        <jsp:param name="maxLength" value="1"/>
    </jsp:include>
    <jsp:include page="/WEB-INF/pages/sybris/formulaires/Commun aux bases/commun/field-select.jsp">
        <jsp:param name="fieldId" value="natureDemande"/>
        <jsp:param name="label" value="Nature demande"/>
        <jsp:param name="itemsAttribute" value="accordEnum"/>
        <jsp:param name="showCode" value="false"/>
        <jsp:param name="requiredType" value="fixed"/>
    </jsp:include>
    <jsp:include page="/WEB-INF/pages/sybris/formulaires/Commun aux bases/commun/field-select.jsp">
        <jsp:param name="fieldId" value="risque"/>
        <jsp:param name="label" value="Risque"/>
        <jsp:param name="itemsAttribute" value="risquesBaseA"/>
        <jsp:param name="showCode" value="true"/>
        <jsp:param name="requiredType" value="fixed"/>
        <jsp:param name="bases" value="A"/>
    </jsp:include>
    <jsp:include page="/WEB-INF/pages/sybris/formulaires/Commun aux bases/commun/field-select.jsp">
        <jsp:param name="fieldId" value="risque"/>
        <jsp:param name="label" value="Risque"/>
        <jsp:param name="itemsAttribute" value="risquesBaseB"/>
        <jsp:param name="showCode" value="true"/>
        <jsp:param name="requiredType" value="fixed"/>
        <jsp:param name="bases" value="B"/>
    </jsp:include>
    <jsp:include page="/WEB-INF/pages/sybris/formulaires/Commun aux bases/commun/field-select.jsp">
        <jsp:param name="fieldId" value="risque"/>
        <jsp:param name="label" value="Risque"/>
        <jsp:param name="itemsAttribute" value="risquesBaseC"/>
        <jsp:param name="showCode" value="true"/>
        <jsp:param name="requiredType" value="fixed"/>
        <jsp:param name="bases" value="C"/>
    </jsp:include>
    <jsp:include page="/WEB-INF/pages/sybris/formulaires/Commun aux bases/commun/field-select.jsp">
        <jsp:param name="fieldId" value="causeAccidentelle"/>
        <jsp:param name="label" value="Cause accidentelle"/>
        <jsp:param name="itemsAttribute" value="ouiNonList"/>
        <jsp:param name="showCode" value="false"/>
        <jsp:param name="requiredType" value="fixed"/>
        <jsp:param name="types" value="DECLARATION"/>
    </jsp:include>
    <jsp:include page="/WEB-INF/pages/sybris/formulaires/Commun aux bases/commun/field-text.jsp">
        <jsp:param name="fieldId" value="numeroDossier"/>
        <jsp:param name="label" value="Numéro dossier"/>
        <jsp:param name="placeholder" value="Numéro dossier"/>
        <jsp:param name="maxLength" value="8"/>
        <jsp:param name="requiredType" value=""/>
        <jsp:param name="bases" value="A"/>
        <jsp:param name="types" value="DECLARATION"/>
    </jsp:include>
    <jsp:include page="/WEB-INF/pages/sybris/formulaires/Commun aux bases/commun/field-text.jsp">
        <jsp:param name="fieldId" value="numeroDossier"/>
        <jsp:param name="label" value="Numéro dossier CNP"/>
        <jsp:param name="placeholder" value="Numéro dossier CNP"/>
        <jsp:param name="maxLength" value="8"/>
        <jsp:param name="requiredType" value=""/>
        <jsp:param name="bases" value="B"/>
        <jsp:param name="types" value="DECLARATION"/>
    </jsp:include>
    <jsp:include page="/WEB-INF/pages/sybris/formulaires/Commun aux bases/commun/field-text.jsp">
        <jsp:param name="fieldId" value="numeroDossier"/>
        <jsp:param name="label" value="Numéro dossier CNP"/>
        <jsp:param name="placeholder" value="Numéro dossier CNP"/>
        <jsp:param name="maxLength" value="8"/>
        <jsp:param name="requiredType" value="fixed"/>
        <jsp:param name="bases" value="C"/>
        <jsp:param name="types" value="DECLARATION"/>
    </jsp:include>
    <jsp:include page="/WEB-INF/pages/sybris/formulaires/Commun aux bases/commun/field-text.jsp">
        <jsp:param name="fieldId" value="refAssure"/>
        <jsp:param name="label" value="Référence assuré"/>
        <jsp:param name="placeholder" value="Référence assuré"/>
        <jsp:param name="maxLength" value="20"/>
        <jsp:param name="requiredType" value=""/>
        <jsp:param name="types" value="DECLARATION"/>
    </jsp:include>
    <jsp:include page="/WEB-INF/pages/sybris/formulaires/Commun aux bases/commun/field-select.jsp">
        <jsp:param name="fieldId" value="categorieSocioProf"/>
        <jsp:param name="label" value="Catégorie socio-professionnelle"/>
        <jsp:param name="itemsAttribute" value="categoriesSocioProf"/>
        <jsp:param name="showCode" value="true"/>
        <jsp:param name="requiredType" value="fixed"/>
        <jsp:param name="types" value="DECLARATION"/>
    </jsp:include>
    <jsp:include page="/WEB-INF/pages/sybris/formulaires/Commun aux bases/commun/field-select.jsp">
        <jsp:param name="fieldId" value="etatCivil"/>
        <jsp:param name="label" value="État civil"/>
        <jsp:param name="itemsAttribute" value="etatsCivils"/>
        <jsp:param name="showCode" value="true"/>
        <jsp:param name="requiredType" value="fixed"/>
        <jsp:param name="types" value="DECLARATION"/>
    </jsp:include>
    <jsp:include page="/WEB-INF/pages/sybris/formulaires/Commun aux bases/commun/field-text.jsp">
        <jsp:param name="fieldId" value="nomUsuel"/>
        <jsp:param name="label" value="Nom usuel"/>
        <jsp:param name="placeholder" value="Nom usuel"/>
        <jsp:param name="maxLength" value="20"/>
        <jsp:param name="requiredType" value="fixed"/>
        <jsp:param name="types" value="DECLARATION"/>
    </jsp:include>
    <jsp:include page="/WEB-INF/pages/sybris/formulaires/Commun aux bases/commun/field-text.jsp">
        <jsp:param name="fieldId" value="prenom"/>
        <jsp:param name="label" value="Prénom"/>
        <jsp:param name="placeholder" value="Prénom"/>
        <jsp:param name="maxLength" value="20"/>
        <jsp:param name="requiredType" value="fixed"/>
        <jsp:param name="types" value="DECLARATION"/>
    </jsp:include>
    <div class="input-container" data-types="DECLARATION">
        <label for="dateNaissance">Date de naissance <span class="sybris-required-mark">*</span></label>
        <input type="date" id="dateNaissance" name="dateNaissance" required>
    </div>
    <jsp:include page="/WEB-INF/pages/sybris/formulaires/Commun aux bases/commun/field-text.jsp">
        <jsp:param name="fieldId" value="nomJeuneFille"/>
        <jsp:param name="label" value="Nom de jeune fille"/>
        <jsp:param name="placeholder" value="Nom de jeune fille"/>
        <jsp:param name="maxLength" value="20"/>
        <jsp:param name="requiredType" value="conditional"/>
        <jsp:param name="conditionalExpr" value="etatCivil==2"/>
        <jsp:param name="types" value="DECLARATION"/>
    </jsp:include>
    <div class="input-container">
        <label for="dateSinistre">Date sinistre <span class="sybris-required-mark">*</span></label>
        <input type="date" id="dateSinistre" name="dateSinistre" required>
    </div>
    <div class="input-container" data-required-when="risque==3||risque==4" data-bases="A" data-types="DECLARATION">
        <label for="dateDebPerJustifiee">Date début période justifiée <span class="sybris-conditional-mark hidden">*</span></label>
        <input type="date" id="dateDebPerJustifiee" name="dateDebPerJustifiee">
    </div>
    <div class="input-container" data-required-when="risque==1||risque==4" data-bases="B C" data-types="DECLARATION">
        <label for="dateDebPerJustifiee">Date début période justifiée <span class="sybris-conditional-mark hidden">*</span></label>
        <input type="date" id="dateDebPerJustifiee" name="dateDebPerJustifiee">
    </div>
    <div class="input-container" data-required-when="risque==3||risque==4" data-bases="A" data-types="DECLARATION">
        <label for="dateFinPeriodeJustifiee">Date fin période justifiée <span class="sybris-conditional-mark hidden">*</span></label>
        <input type="date" id="dateFinPeriodeJustifiee" name="dateFinPeriodeJustifiee">
    </div>
    <div class="input-container" data-required-when="risque==1||risque==4" data-bases="B C" data-types="DECLARATION">
        <label for="dateFinPeriodeJustifiee">Date fin période justifiée <span class="sybris-conditional-mark hidden">*</span></label>
        <input type="date" id="dateFinPeriodeJustifiee" name="dateFinPeriodeJustifiee">
    </div>
    <jsp:include page="/WEB-INF/pages/sybris/formulaires/Commun aux bases/commun/field-select.jsp">
        <jsp:param name="fieldId" value="codeAssureSocial"/>
        <jsp:param name="label" value="Code assuré social"/>
        <jsp:param name="itemsAttribute" value="ouiNonList"/>
        <jsp:param name="showCode" value="false"/>
        <jsp:param name="requiredType" value="conditional"/>
        <jsp:param name="conditionalExpr" value="[1,2,3,5].includes(risque)"/>
        <jsp:param name="bases" value="A"/>
        <jsp:param name="types" value="DECLARATION"/>
    </jsp:include>
    <jsp:include page="/WEB-INF/pages/sybris/formulaires/Commun aux bases/commun/field-select.jsp">
        <jsp:param name="fieldId" value="codeAssureSocial"/>
        <jsp:param name="label" value="Code assuré social"/>
        <jsp:param name="itemsAttribute" value="ouiNonList"/>
        <jsp:param name="showCode" value="false"/>
        <jsp:param name="requiredType" value="conditional"/>
        <jsp:param name="conditionalExpr" value="[1,3,4,5].includes(risque)"/>
        <jsp:param name="bases" value="B"/>
        <jsp:param name="types" value="DECLARATION"/>
    </jsp:include>
    <jsp:include page="/WEB-INF/pages/sybris/formulaires/Commun aux bases/commun/field-select.jsp">
        <jsp:param name="fieldId" value="codeAssureSocial"/>
        <jsp:param name="label" value="Code assuré social"/>
        <jsp:param name="itemsAttribute" value="ouiNonList"/>
        <jsp:param name="showCode" value="false"/>
        <jsp:param name="requiredType" value="conditional"/>
        <jsp:param name="conditionalExpr" value="[1,3,4].includes(risque)"/>
        <jsp:param name="bases" value="C"/>
        <jsp:param name="types" value="DECLARATION"/>
    </jsp:include>
    <jsp:include page="/WEB-INF/pages/sybris/formulaires/Commun aux bases/commun/field-select.jsp">
        <jsp:param name="fieldId" value="codePrestationsEspece"/>
        <jsp:param name="label" value="Code prestations espèces"/>
        <jsp:param name="itemsAttribute" value="ouiNonList"/>
        <jsp:param name="showCode" value="false"/>
        <jsp:param name="requiredType" value="conditional"/>
        <jsp:param name="conditionalExpr" value="[1,2,3,5].includes(risque)"/>
        <jsp:param name="bases" value="A"/>
        <jsp:param name="types" value="DECLARATION"/>
    </jsp:include>
    <jsp:include page="/WEB-INF/pages/sybris/formulaires/Commun aux bases/commun/field-select.jsp">
        <jsp:param name="fieldId" value="codePrestationsEspece"/>
        <jsp:param name="label" value="Code prestations espèces"/>
        <jsp:param name="itemsAttribute" value="ouiNonList"/>
        <jsp:param name="showCode" value="false"/>
        <jsp:param name="requiredType" value="conditional"/>
        <jsp:param name="conditionalExpr" value="[1,3,4,5].includes(risque)"/>
        <jsp:param name="bases" value="B"/>
        <jsp:param name="types" value="DECLARATION"/>
    </jsp:include>
    <jsp:include page="/WEB-INF/pages/sybris/formulaires/Commun aux bases/commun/field-select.jsp">
        <jsp:param name="fieldId" value="codePrestationsEspece"/>
        <jsp:param name="label" value="Code prestations espèce"/>
        <jsp:param name="itemsAttribute" value="ouiNonList"/>
        <jsp:param name="showCode" value="false"/>
        <jsp:param name="requiredType" value="conditional"/>
        <jsp:param name="conditionalExpr" value="[1,3,4].includes(risque)"/>
        <jsp:param name="bases" value="C"/>
        <jsp:param name="types" value="DECLARATION"/>
    </jsp:include>
    <jsp:include page="/WEB-INF/pages/sybris/formulaires/Commun aux bases/commun/field-select.jsp">
        <jsp:param name="fieldId" value="codeRepriseTravail"/>
        <jsp:param name="label" value="Demande reprise travail"/>
        <jsp:param name="itemsAttribute" value="ouiNonList"/>
        <jsp:param name="showCode" value="false"/>
        <jsp:param name="requiredType" value="fixed"/>
        <jsp:param name="bases" value="A"/>
        <jsp:param name="types" value="DECLARATION"/>
    </jsp:include>
    <jsp:include page="/WEB-INF/pages/sybris/formulaires/Commun aux bases/commun/field-select.jsp">
        <jsp:param name="fieldId" value="codeRepriseTravail"/>
        <jsp:param name="label" value="Code reprise travail"/>
        <jsp:param name="itemsAttribute" value="ouiNonList"/>
        <jsp:param name="showCode" value="false"/>
        <jsp:param name="requiredType" value="conditional"/>
        <jsp:param name="conditionalExpr" value="risque==1||risque==4"/>
        <jsp:param name="bases" value="B C"/>
        <jsp:param name="types" value="DECLARATION"/>
    </jsp:include>
    <jsp:include page="/WEB-INF/pages/sybris/formulaires/Commun aux bases/commun/field-select.jsp">
        <jsp:param name="fieldId" value="typePieceJustificative"/>
        <jsp:param name="label" value="Type pièce justificative"/>
        <jsp:param name="itemsAttribute" value="typesJustificatifBaseA"/>
        <jsp:param name="showCode" value="true"/>
        <jsp:param name="requiredType" value="fixed"/>
        <jsp:param name="bases" value="A"/>
    </jsp:include>
    <jsp:include page="/WEB-INF/pages/sybris/formulaires/Commun aux bases/commun/field-select.jsp">
        <jsp:param name="fieldId" value="typePieceJustificative"/>
        <jsp:param name="label" value="Type pièce justificative"/>
        <jsp:param name="itemsAttribute" value="typesJustificatifBaseB"/>
        <jsp:param name="showCode" value="true"/>
        <jsp:param name="requiredType" value="fixed"/>
        <jsp:param name="bases" value="B"/>
    </jsp:include>
    <jsp:include page="/WEB-INF/pages/sybris/formulaires/Commun aux bases/commun/field-select.jsp">
        <jsp:param name="fieldId" value="typePieceJustificative"/>
        <jsp:param name="label" value="Type pièce justificative"/>
        <jsp:param name="itemsAttribute" value="typesPieceBaseC"/>
        <jsp:param name="showCode" value="true"/>
        <jsp:param name="requiredType" value="fixed"/>
        <jsp:param name="bases" value="C"/>
    </jsp:include>
    <jsp:include page="/WEB-INF/pages/sybris/formulaires/Commun aux bases/commun/field-select.jsp">
        <jsp:param name="fieldId" value="demandeControleMedical"/>
        <jsp:param name="label" value="Demande contrôle médical CNP"/>
        <jsp:param name="itemsAttribute" value="ouiNonList"/>
        <jsp:param name="showCode" value="false"/>
        <jsp:param name="requiredType" value="fixed"/>
        <jsp:param name="bases" value="A"/>
        <jsp:param name="types" value="DECLARATION"/>
    </jsp:include>
    <jsp:include page="/WEB-INF/pages/sybris/formulaires/Commun aux bases/commun/field-select.jsp">
        <jsp:param name="fieldId" value="demandeControleMedical"/>
        <jsp:param name="label" value="Demande contrôle médical"/>
        <jsp:param name="itemsAttribute" value="ouiNonList"/>
        <jsp:param name="showCode" value="false"/>
        <jsp:param name="requiredType" value="conditional"/>
        <jsp:param name="conditionalExpr" value="[1,2,4].includes(risque)"/>
        <jsp:param name="bases" value="B"/>
        <jsp:param name="types" value="DECLARATION"/>
    </jsp:include>
    <jsp:include page="/WEB-INF/pages/sybris/formulaires/Commun aux bases/commun/field-select.jsp">
        <jsp:param name="fieldId" value="demandeControleMedical"/>
        <jsp:param name="label" value="Demande contrôle médical"/>
        <jsp:param name="itemsAttribute" value="ouiNonList"/>
        <jsp:param name="showCode" value="false"/>
        <jsp:param name="requiredType" value="conditional"/>
        <jsp:param name="conditionalExpr" value="risque==1||risque==4"/>
        <jsp:param name="bases" value="C"/>
        <jsp:param name="types" value="DECLARATION"/>
    </jsp:include>
    <jsp:include page="/WEB-INF/pages/sybris/formulaires/Commun aux bases/commun/field-text.jsp">
        <jsp:param name="fieldId" value="numeroContratCA"/>
        <jsp:param name="label" value="Numéro contrat CA"/>
        <jsp:param name="placeholder" value="Numéro contrat CA"/>
        <jsp:param name="maxLength" value="1"/>
        <jsp:param name="requiredType" value=""/>
        <jsp:param name="bases" value="A"/>
        <jsp:param name="types" value="DECLARATION"/>
    </jsp:include>
    <div class="input-container" data-required-when="risque==4" data-bases="A" data-types="DECLARATION">
        <label for="dateNotificationChomage">Date notification chômage <span class="sybris-conditional-mark hidden">*</span></label>
        <input type="date" id="dateNotificationChomage" name="dateNotificationChomage">
    </div>
    <jsp:include page="/WEB-INF/pages/sybris/formulaires/Commun aux bases/commun/field-text.jsp">
        <jsp:param name="fieldId" value="dateNotificationChomage"/>
        <jsp:param name="label" value="Date notification chômage"/>
        <jsp:param name="placeholder" value="Date notification chômage"/>
        <jsp:param name="maxLength" value="8"/>
        <jsp:param name="requiredType" value=""/>
        <jsp:param name="bases" value="C"/>
        <jsp:param name="types" value="DECLARATION"/>
    </jsp:include>
    <jsp:include page="/WEB-INF/pages/sybris/formulaires/Commun aux bases/commun/field-text.jsp">
        <jsp:param name="fieldId" value="codePostalCommuneNaissance"/>
        <jsp:param name="label" value="Code postal commune de naissance"/>
        <jsp:param name="placeholder" value="Code postal commune de naissance"/>
        <jsp:param name="maxLength" value="5"/>
        <jsp:param name="requiredType" value=""/>
        <jsp:param name="types" value="DECLARATION"/>
    </jsp:include>
    <jsp:include page="/WEB-INF/pages/sybris/formulaires/Commun aux bases/commun/field-text.jsp">
        <jsp:param name="fieldId" value="communeNaissanceAssure"/>
        <jsp:param name="label" value="Commune de naissance de l'assuré"/>
        <jsp:param name="placeholder" value="Commune de naissance de l'assuré"/>
        <jsp:param name="maxLength" value="26"/>
        <jsp:param name="requiredType" value=""/>
        <jsp:param name="types" value="DECLARATION"/>
    </jsp:include>
    <jsp:include page="/WEB-INF/pages/sybris/formulaires/Commun aux bases/commun/field-select.jsp">
        <jsp:param name="fieldId" value="codeDeviseDossier"/>
        <jsp:param name="label" value="Code devise"/>
        <jsp:param name="itemsAttribute" value="devisesAbregees"/>
        <jsp:param name="showCode" value="true"/>
        <jsp:param name="requiredType" value="fixed"/>
        <jsp:param name="bases" value="A"/>
    </jsp:include>
    <jsp:include page="/WEB-INF/pages/sybris/formulaires/Commun aux bases/commun/field-select.jsp">
        <jsp:param name="fieldId" value="codeSecretMedical"/>
        <jsp:param name="label" value="Code secret médical"/>
        <jsp:param name="itemsAttribute" value="ouiNonList"/>
        <jsp:param name="showCode" value="false"/>
        <jsp:param name="requiredType" value=""/>
        <jsp:param name="bases" value="A"/>
        <jsp:param name="types" value="DECLARATION"/>
    </jsp:include>
    <jsp:include page="/WEB-INF/pages/sybris/formulaires/Commun aux bases/commun/field-text.jsp">
        <jsp:param name="fieldId" value="delegation"/>
        <jsp:param name="label" value="Délégation"/>
        <jsp:param name="placeholder" value="Délégation"/>
        <jsp:param name="maxLength" value="1"/>
        <jsp:param name="requiredType" value=""/>
        <jsp:param name="bases" value="B"/>
        <jsp:param name="types" value="DECLARATION"/>
    </jsp:include>
    <jsp:include page="/WEB-INF/pages/sybris/formulaires/Commun aux bases/commun/field-select.jsp">
        <jsp:param name="fieldId" value="codeSalarie"/>
        <jsp:param name="label" value="Code salarié"/>
        <jsp:param name="itemsAttribute" value="codesSalarieBaseB"/>
        <jsp:param name="showCode" value="false"/>
        <jsp:param name="requiredType" value="conditional"/>
        <jsp:param name="conditionalExpr" value="risque==1 (contrat perte de revenus)"/>
        <jsp:param name="bases" value="B"/>
        <jsp:param name="types" value="DECLARATION"/>
    </jsp:include>
    <jsp:include page="/WEB-INF/pages/sybris/formulaires/Commun aux bases/commun/field-text.jsp">
        <jsp:param name="fieldId" value="codeSalarie"/>
        <jsp:param name="label" value="Code salarié"/>
        <jsp:param name="placeholder" value="Code salarié"/>
        <jsp:param name="maxLength" value="1"/>
        <jsp:param name="requiredType" value="conditional"/>
        <jsp:param name="conditionalExpr" value="risque==1"/>
        <jsp:param name="bases" value="C"/>
        <jsp:param name="types" value="DECLARATION"/>
    </jsp:include>
    <jsp:include page="/WEB-INF/pages/sybris/formulaires/Commun aux bases/commun/field-text.jsp">
        <jsp:param name="fieldId" value="codeDelegation"/>
        <jsp:param name="label" value="Code délégation"/>
        <jsp:param name="placeholder" value="Code délégation"/>
        <jsp:param name="maxLength" value="1"/>
        <jsp:param name="requiredType" value=""/>
        <jsp:param name="bases" value="C"/>
        <jsp:param name="types" value="DECLARATION"/>
    </jsp:include>
    <jsp:include page="/WEB-INF/pages/sybris/formulaires/Commun aux bases/commun/field-text.jsp">
        <jsp:param name="fieldId" value="numeroDossier"/>
        <jsp:param name="label" value="Numéro dossier"/>
        <jsp:param name="placeholder" value="Numéro dossier"/>
        <jsp:param name="maxLength" value="8"/>
        <jsp:param name="requiredType" value="fixed"/>
        <jsp:param name="types" value="PROLONGATION"/>
    </jsp:include>
    <div class="input-container" data-types="PROLONGATION">
        <label for="dateDebPerJustifiee">Date début période justifiée <span class="sybris-required-mark">*</span></label>
        <input type="date" id="dateDebPerJustifiee" name="dateDebPerJustifiee" required>
    </div>
    <div class="input-container" data-types="PROLONGATION">
        <label for="dateFinPeriodeJustifiee">Date fin période justifiée <span class="sybris-required-mark">*</span></label>
        <input type="date" id="dateFinPeriodeJustifiee" name="dateFinPeriodeJustifiee" required>
    </div>
    <jsp:include page="/WEB-INF/pages/sybris/formulaires/Commun aux bases/commun/field-select.jsp">
        <jsp:param name="fieldId" value="codeRepriseTravail"/>
        <jsp:param name="label" value="Code reprise travail"/>
        <jsp:param name="itemsAttribute" value="ouiNonList"/>
        <jsp:param name="showCode" value="false"/>
        <jsp:param name="requiredType" value="fixed"/>
        <jsp:param name="types" value="PROLONGATION"/>
    </jsp:include>
    <jsp:include page="/WEB-INF/pages/sybris/formulaires/Commun aux bases/commun/field-select.jsp">
        <jsp:param name="fieldId" value="demandeControleMedical"/>
        <jsp:param name="label" value="Demande contrôle médical"/>
        <jsp:param name="itemsAttribute" value="ouiNonList"/>
        <jsp:param name="showCode" value="false"/>
        <jsp:param name="requiredType" value="fixed"/>
        <jsp:param name="types" value="PROLONGATION"/>
    </jsp:include>
    <jsp:include page="/WEB-INF/pages/sybris/formulaires/Commun aux bases/commun/field-select.jsp">
        <jsp:param name="fieldId" value="motifSuspension"/>
        <jsp:param name="label" value="Motif de suspension"/>
        <jsp:param name="itemsAttribute" value="motifsSuspensionBaseA"/>
        <jsp:param name="showCode" value="true"/>
        <jsp:param name="requiredType" value="conditional"/>
        <jsp:param name="conditionalExpr" value="demandeControleMedical=='O'"/>
        <jsp:param name="types" value="PROLONGATION"/>
    </jsp:include>
    <jsp:include page="/WEB-INF/pages/sybris/formulaires/Commun aux bases/commun/field-select.jsp">
        <jsp:param name="fieldId" value="categorieSocioProf"/>
        <jsp:param name="label" value="Catégorie socio-professionnelle"/>
        <jsp:param name="itemsAttribute" value="categoriesSocioProf"/>
        <jsp:param name="showCode" value="true"/>
        <jsp:param name="requiredType" value=""/>
        <jsp:param name="bases" value="A"/>
        <jsp:param name="types" value="PROLONGATION"/>
    </jsp:include>
    <jsp:include page="/WEB-INF/pages/sybris/formulaires/Commun aux bases/commun/field-select.jsp">
        <jsp:param name="fieldId" value="categorieSocioProf"/>
        <jsp:param name="label" value="Catégorie socio-professionnelle"/>
        <jsp:param name="itemsAttribute" value="categoriesSocioProf"/>
        <jsp:param name="showCode" value="true"/>
        <jsp:param name="requiredType" value="fixed"/>
        <jsp:param name="bases" value="B C"/>
        <jsp:param name="types" value="PROLONGATION"/>
    </jsp:include>
    <jsp:include page="/WEB-INF/pages/sybris/formulaires/Commun aux bases/commun/field-select.jsp">
        <jsp:param name="fieldId" value="codeAssureSocial"/>
        <jsp:param name="label" value="Code assuré social"/>
        <jsp:param name="itemsAttribute" value="ouiNonList"/>
        <jsp:param name="showCode" value="false"/>
        <jsp:param name="requiredType" value=""/>
        <jsp:param name="bases" value="A"/>
        <jsp:param name="types" value="PROLONGATION"/>
    </jsp:include>
    <jsp:include page="/WEB-INF/pages/sybris/formulaires/Commun aux bases/commun/field-select.jsp">
        <jsp:param name="fieldId" value="codePrestationsEspece"/>
        <jsp:param name="label" value="Prestations espèces"/>
        <jsp:param name="itemsAttribute" value="ouiNonList"/>
        <jsp:param name="showCode" value="false"/>
        <jsp:param name="requiredType" value=""/>
        <jsp:param name="bases" value="A"/>
        <jsp:param name="types" value="PROLONGATION"/>
    </jsp:include>
    <jsp:include page="/WEB-INF/pages/sybris/formulaires/Commun aux bases/commun/field-text.jsp">
        <jsp:param name="fieldId" value="categorieIT"/>
        <jsp:param name="label" value="Catégorie IT (1 = IT partielle)"/>
        <jsp:param name="placeholder" value="Catégorie IT (1 = IT partielle)"/>
        <jsp:param name="maxLength" value="1"/>
        <jsp:param name="requiredType" value=""/>
        <jsp:param name="bases" value="B"/>
        <jsp:param name="types" value="PROLONGATION"/>
    </jsp:include>
    <jsp:include page="/WEB-INF/pages/sybris/formulaires/Commun aux bases/commun/field-text.jsp">
        <jsp:param name="fieldId" value="codePostalCommuneNaissance"/>
        <jsp:param name="label" value="Code postal commune de naissance"/>
        <jsp:param name="placeholder" value="Code postal commune de naissance"/>
        <jsp:param name="maxLength" value="5"/>
        <jsp:param name="requiredType" value=""/>
        <jsp:param name="bases" value="B"/>
        <jsp:param name="types" value="PROLONGATION"/>
    </jsp:include>
    <jsp:include page="/WEB-INF/pages/sybris/formulaires/Commun aux bases/commun/field-text.jsp">
        <jsp:param name="fieldId" value="communeNaissanceAssure"/>
        <jsp:param name="label" value="Commune de naissance de l'assuré"/>
        <jsp:param name="placeholder" value="Commune de naissance de l'assuré"/>
        <jsp:param name="maxLength" value="26"/>
        <jsp:param name="requiredType" value=""/>
        <jsp:param name="bases" value="B"/>
        <jsp:param name="types" value="PROLONGATION"/>
    </jsp:include>
    <jsp:include page="/WEB-INF/pages/sybris/formulaires/Commun aux bases/commun/field-text.jsp">
        <jsp:param name="fieldId" value="numeroDemandePrestation"/>
        <jsp:param name="label" value="Numéro de la demande de prestation"/>
        <jsp:param name="placeholder" value="Numéro de la demande de prestation"/>
        <jsp:param name="maxLength" value="8"/>
        <jsp:param name="requiredType" value=""/>
        <jsp:param name="bases" value="C"/>
        <jsp:param name="types" value="PROLONGATION"/>
    </jsp:include>
</div>
<div class="form-subsection" data-bases="A" data-types="DECLARATION">
    <div class="form-subsection-header collapsed" onclick="toggleSubsection(this)">
        <span class="form-subsection-icon">▸</span>
        <h6>Fillers / champs non utilisés — Base A, Declaration</h6>
    </div>
    <div class="form-subsection-body">
        <div class="form-container">
            <jsp:include page="/WEB-INF/pages/sybris/formulaires/Commun aux bases/commun/field-filler.jsp">
                <jsp:param name="fieldID" value="Filler (225)"/>
                <jsp:param name="name" value="filler225_dossier_DECLARATION_A"/>
                <jsp:param name="fillerPosition" value="225"/>
                <jsp:param name="fillerLength" value="10"/>
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
                <jsp:param name="fieldID" value="Filler (222)"/>
                <jsp:param name="name" value="filler222_dossier_DECLARATION_B"/>
                <jsp:param name="fillerPosition" value="222"/>
                <jsp:param name="fillerLength" value="19"/>
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
                <jsp:param name="fieldID" value="Filler (222)"/>
                <jsp:param name="name" value="filler222_dossier_DECLARATION_C"/>
                <jsp:param name="fillerPosition" value="222"/>
                <jsp:param name="fillerLength" value="24"/>
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
                <jsp:param name="fieldID" value="Filler (88)"/>
                <jsp:param name="name" value="filler88_dossier_PROLONGATION_A"/>
                <jsp:param name="fillerPosition" value="88"/>
                <jsp:param name="fillerLength" value="1"/>
                <jsp:param name="bases" value="A"/>
                <jsp:param name="types" value="PROLONGATION"/>
            </jsp:include>
            <jsp:include page="/WEB-INF/pages/sybris/formulaires/Commun aux bases/commun/field-filler.jsp">
                <jsp:param name="fieldID" value="Filler (97)"/>
                <jsp:param name="name" value="filler97_dossier_PROLONGATION_A"/>
                <jsp:param name="fillerPosition" value="97"/>
                <jsp:param name="fillerLength" value="138"/>
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
                <jsp:param name="fieldID" value="Filler (123)"/>
                <jsp:param name="name" value="filler123_dossier_PROLONGATION_B"/>
                <jsp:param name="fillerPosition" value="123"/>
                <jsp:param name="fillerLength" value="118"/>
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
                <jsp:param name="fieldID" value="Filler (92)"/>
                <jsp:param name="name" value="filler92_dossier_PROLONGATION_C"/>
                <jsp:param name="fillerPosition" value="92"/>
                <jsp:param name="fillerLength" value="146"/>
                <jsp:param name="bases" value="C"/>
                <jsp:param name="types" value="PROLONGATION"/>
            </jsp:include>
        </div>
    </div>
</div>
