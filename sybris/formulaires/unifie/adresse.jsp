<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!--
  "Enregistrement Adresse" — identique en Déclaration et
  Prolongation (aucun tag types), presque identique entre bases
  (seule Base C a un champ + fillers spécifiques).
-->
<div class="sybris-subform">
    <div class="form-subsection">
        <div class="form-subsection-header" onclick="toggleSubsection(this)">
            <span class="form-subsection-icon">▾</span>
            <h6>Adresse</h6>
        </div>
        <div class="form-subsection-body">
            <div class="form-container">
                <jsp:include page="/WEB-INF/pages/sybris/formulaires/Commun aux bases/commun/field-hidden-readonly.jsp">
                    <jsp:param name="fieldId" value="typeEnregistrement"/>
                    <jsp:param name="fieldName" value="typeEnregistrement"/>
                    <jsp:param name="label" value="Type d'enregistrement (Adresse)"/>
                    <jsp:param name="value" value="2"/>
                    <jsp:param name="maxLength" value="1"/>
                </jsp:include>
                <jsp:include page="/WEB-INF/pages/sybris/formulaires/Commun aux bases/commun/field-text.jsp">
                    <jsp:param name="fieldId" value="residenceBatiment"/>
                    <jsp:param name="label" value="Résidence / bâtiment"/>
                    <jsp:param name="placeholder" value="Résidence / bâtiment"/>
                    <jsp:param name="maxLength" value="32"/>
                    <jsp:param name="requiredType" value=""/>
                </jsp:include>
                <jsp:include page="/WEB-INF/pages/sybris/formulaires/Commun aux bases/commun/field-text.jsp">
                    <jsp:param name="fieldId" value="complement"/>
                    <jsp:param name="label" value="Complément"/>
                    <jsp:param name="placeholder" value="Complément"/>
                    <jsp:param name="maxLength" value="32"/>
                    <jsp:param name="requiredType" value=""/>
                </jsp:include>
                <jsp:include page="/WEB-INF/pages/sybris/formulaires/Commun aux bases/commun/field-text.jsp">
                    <jsp:param name="fieldId" value="noEtRue"/>
                    <jsp:param name="label" value="N° et rue"/>
                    <jsp:param name="placeholder" value="N° et rue"/>
                    <jsp:param name="maxLength" value="32"/>
                    <jsp:param name="requiredType" value=""/>
                    <jsp:param name="bases" value="A C"/>
                </jsp:include>
                <jsp:include page="/WEB-INF/pages/sybris/formulaires/Commun aux bases/commun/field-text.jsp">
                    <jsp:param name="fieldId" value="noEtRue"/>
                    <jsp:param name="label" value="Numéro et rue"/>
                    <jsp:param name="placeholder" value="Numéro et rue"/>
                    <jsp:param name="maxLength" value="32"/>
                    <jsp:param name="requiredType" value=""/>
                    <jsp:param name="bases" value="B"/>
                </jsp:include>
                <jsp:include page="/WEB-INF/pages/sybris/formulaires/Commun aux bases/commun/field-text.jsp">
                    <jsp:param name="fieldId" value="lieuDit"/>
                    <jsp:param name="label" value="Lieu-dit"/>
                    <jsp:param name="placeholder" value="Lieu-dit"/>
                    <jsp:param name="maxLength" value="32"/>
                    <jsp:param name="requiredType" value=""/>
                </jsp:include>
                <jsp:include page="/WEB-INF/pages/sybris/formulaires/Commun aux bases/commun/field-text.jsp">
                    <jsp:param name="fieldId" value="codePostal"/>
                    <jsp:param name="label" value="Code postal"/>
                    <jsp:param name="placeholder" value="Code postal"/>
                    <jsp:param name="maxLength" value="5"/>
                    <jsp:param name="requiredType" value="fixed"/>
                </jsp:include>
                <jsp:include page="/WEB-INF/pages/sybris/formulaires/Commun aux bases/commun/field-text.jsp">
                    <jsp:param name="fieldId" value="commune"/>
                    <jsp:param name="label" value="Commune"/>
                    <jsp:param name="placeholder" value="Doit correspondre au code postal"/>
                    <jsp:param name="maxLength" value="26"/>
                    <jsp:param name="requiredType" value="fixed"/>
                </jsp:include>
                <jsp:include page="/WEB-INF/pages/sybris/formulaires/Commun aux bases/commun/field-text.jsp">
                    <jsp:param name="fieldId" value="profession"/>
                    <jsp:param name="label" value="Profession"/>
                    <jsp:param name="placeholder" value="Profession"/>
                    <jsp:param name="maxLength" value="20"/>
                    <jsp:param name="requiredType" value="fixed"/>
                </jsp:include>
                <jsp:include page="/WEB-INF/pages/sybris/formulaires/Commun aux bases/commun/field-select.jsp">
                    <jsp:param name="fieldId" value="demTransmissionPieceMedicale"/>
                    <jsp:param name="label" value="Transmission de pièce médicale"/>
                    <jsp:param name="itemsAttribute" value="ouiNonList"/>
                    <jsp:param name="showCode" value="false"/>
                    <jsp:param name="requiredType" value="fixed"/>
                </jsp:include>
                <jsp:include page="/WEB-INF/pages/sybris/formulaires/Commun aux bases/commun/field-text.jsp">
                    <jsp:param name="fieldId" value="codeMedecinCaisseRegionale"/>
                    <jsp:param name="label" value="Code médecin caisse régionale"/>
                    <jsp:param name="placeholder" value="Code médecin caisse régionale"/>
                    <jsp:param name="maxLength" value="1"/>
                    <jsp:param name="requiredType" value=""/>
                    <jsp:param name="bases" value="C"/>
                </jsp:include>
            </div>
        </div>
    </div>
    <div class="form-subsection" data-bases="A">
        <div class="form-subsection-header collapsed" onclick="toggleSubsection(this)">
            <span class="form-subsection-icon">▸</span>
            <h6>Fillers / champs non utilisés — Base A</h6>
        </div>
        <div class="form-subsection-body">
            <div class="form-container">
                <jsp:include page="/WEB-INF/pages/sybris/formulaires/Commun aux bases/commun/field-filler.jsp">
                    <jsp:param name="fieldID" value="Filler (230)"/>
                    <jsp:param name="name" value="filler230_adresse_A"/>
                    <jsp:param name="fillerPosition" value="230"/>
                    <jsp:param name="fillerLength" value="5"/>
                    <jsp:param name="bases" value="A"/>
                </jsp:include>
            </div>
        </div>
    </div>
    <div class="form-subsection" data-bases="B">
        <div class="form-subsection-header collapsed" onclick="toggleSubsection(this)">
            <span class="form-subsection-icon">▸</span>
            <h6>Fillers / champs non utilisés — Base B</h6>
        </div>
        <div class="form-subsection-body">
            <div class="form-container">
                <jsp:include page="/WEB-INF/pages/sybris/formulaires/Commun aux bases/commun/field-filler.jsp">
                    <jsp:param name="fieldID" value="Filler (230)"/>
                    <jsp:param name="name" value="filler230_adresse_B"/>
                    <jsp:param name="fillerPosition" value="230"/>
                    <jsp:param name="fillerLength" value="11"/>
                    <jsp:param name="bases" value="B"/>
                </jsp:include>
            </div>
        </div>
    </div>
    <div class="form-subsection" data-bases="C">
        <div class="form-subsection-header collapsed" onclick="toggleSubsection(this)">
            <span class="form-subsection-icon">▸</span>
            <h6>Fillers / champs non utilisés — Base C</h6>
        </div>
        <div class="form-subsection-body">
            <div class="form-container">
                <jsp:include page="/WEB-INF/pages/sybris/formulaires/Commun aux bases/commun/field-filler.jsp">
                    <jsp:param name="fieldID" value="Filler (231)"/>
                    <jsp:param name="name" value="filler231_adresse_C"/>
                    <jsp:param name="fillerPosition" value="231"/>
                    <jsp:param name="fillerLength" value="10"/>
                    <jsp:param name="bases" value="C"/>
                </jsp:include>
            </div>
        </div>
    </div>
</div>
