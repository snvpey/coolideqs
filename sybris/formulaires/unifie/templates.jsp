<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!-- Échéance/Capital : indexés par base seulement (identiques décla/prolongation), inchangé. -->
<div id="template-echeance-A">
    <div class="form-container">
        <jsp:include page="/WEB-INF/pages/sybris/formulaires/Commun aux bases/commun/field-hidden-readonly.jsp">
            <jsp:param name="fieldId" value="typeEnregistrement"/>
            <jsp:param name="fieldName" value="typeEnregistrement"/>
            <jsp:param name="label" value="Type d'enregistrement (Échéance)"/>
            <jsp:param name="value" value="4"/>
            <jsp:param name="maxLength" value="1"/>
        </jsp:include>
        <div class="input-container">
            <label for="dateEcheance_ech_A">Date d'échéance <span class="sybris-required-mark">*</span></label>
            <input type="date" id="dateEcheance_ech_A" name="dateEcheance" required>
        </div>
        <jsp:include page="/WEB-INF/pages/sybris/formulaires/Commun aux bases/commun/field-text.jsp">
            <jsp:param name="fieldId" value="montantEcheance"/>
            <jsp:param name="label" value="Montant d'échéance"/>
            <jsp:param name="placeholder" value="Montant d'échéance"/>
            <jsp:param name="maxLength" value="9"/>
            <jsp:param name="requiredType" value="fixed"/>
        </jsp:include>
    </div>
</div>
<div id="template-echeance-B">
    <div class="form-container">
        <jsp:include page="/WEB-INF/pages/sybris/formulaires/Commun aux bases/commun/field-hidden-readonly.jsp">
            <jsp:param name="fieldId" value="typeEnregistrement"/>
            <jsp:param name="fieldName" value="typeEnregistrement"/>
            <jsp:param name="label" value="Type d'enregistrement (Échéance)"/>
            <jsp:param name="value" value="4"/>
            <jsp:param name="maxLength" value="1"/>
        </jsp:include>
        <div class="input-container">
            <label for="dateEcheance_ech_B">Date d'échéance <span class="sybris-required-mark">*</span></label>
            <input type="date" id="dateEcheance_ech_B" name="dateEcheance" required>
        </div>
        <jsp:include page="/WEB-INF/pages/sybris/formulaires/Commun aux bases/commun/field-text.jsp">
            <jsp:param name="fieldId" value="montantEcheance"/>
            <jsp:param name="label" value="Montant d'échéance"/>
            <jsp:param name="placeholder" value="Montant d'échéance"/>
            <jsp:param name="maxLength" value="9"/>
            <jsp:param name="requiredType" value="fixed"/>
        </jsp:include>
    </div>
</div>
<div id="template-echeance-C">
    <div class="form-container">
        <jsp:include page="/WEB-INF/pages/sybris/formulaires/Commun aux bases/commun/field-hidden-readonly.jsp">
            <jsp:param name="fieldId" value="typeEnregistrement"/>
            <jsp:param name="fieldName" value="typeEnregistrement"/>
            <jsp:param name="label" value="Type d'enregistrement (Échéance)"/>
            <jsp:param name="value" value="4"/>
            <jsp:param name="maxLength" value="1"/>
        </jsp:include>
        <div class="input-container">
            <label for="dateEcheance_ech_C">Date d'échéance <span class="sybris-required-mark">*</span></label>
            <input type="date" id="dateEcheance_ech_C" name="dateEcheance" required>
        </div>
        <jsp:include page="/WEB-INF/pages/sybris/formulaires/Commun aux bases/commun/field-text.jsp">
            <jsp:param name="fieldId" value="montantEcheance"/>
            <jsp:param name="label" value="Montant d'échéance"/>
            <jsp:param name="placeholder" value="Montant d'échéance"/>
            <jsp:param name="maxLength" value="9"/>
            <jsp:param name="requiredType" value="fixed"/>
        </jsp:include>
        <jsp:include page="/WEB-INF/pages/sybris/formulaires/Commun aux bases/commun/field-text.jsp">
            <jsp:param name="fieldId" value="montantCotisationChomage"/>
            <jsp:param name="label" value="Montant cotisation chômage"/>
            <jsp:param name="placeholder" value="Montant cotisation chômage"/>
            <jsp:param name="maxLength" value="7"/>
            <jsp:param name="requiredType" value=""/>
        </jsp:include>
        <jsp:include page="/WEB-INF/pages/sybris/formulaires/Commun aux bases/commun/field-text.jsp">
            <jsp:param name="fieldId" value="montantCotisationITDC"/>
            <jsp:param name="label" value="Montant cotisation IT/DC"/>
            <jsp:param name="placeholder" value="Montant cotisation IT/DC"/>
            <jsp:param name="maxLength" value="7"/>
            <jsp:param name="requiredType" value=""/>
        </jsp:include>
    </div>
</div>
<div id="template-capital-A">
    <div class="form-container">
        <jsp:include page="/WEB-INF/pages/sybris/formulaires/Commun aux bases/commun/field-hidden-readonly.jsp">
            <jsp:param name="fieldId" value="typeEnregistrement"/>
            <jsp:param name="fieldName" value="typeEnregistrement"/>
            <jsp:param name="label" value="Type d'enregistrement (Capital)"/>
            <jsp:param name="value" value="5"/>
            <jsp:param name="maxLength" value="1"/>
        </jsp:include>
        <jsp:include page="/WEB-INF/pages/sybris/formulaires/Commun aux bases/commun/field-text.jsp">
            <jsp:param name="fieldId" value="montantCapitalRestantDu"/>
            <jsp:param name="label" value="Montant capital restant dû"/>
            <jsp:param name="placeholder" value="Montant capital restant dû"/>
            <jsp:param name="maxLength" value="10"/>
            <jsp:param name="requiredType" value="fixed"/>
        </jsp:include>
        <jsp:include page="/WEB-INF/pages/sybris/formulaires/Commun aux bases/commun/field-text.jsp">
            <jsp:param name="fieldId" value="montantInteretsMoratoires"/>
            <jsp:param name="label" value="Montant intérêts moratoires"/>
            <jsp:param name="placeholder" value="Montant intérêts moratoires"/>
            <jsp:param name="maxLength" value="9"/>
            <jsp:param name="requiredType" value=""/>
        </jsp:include>
    </div>
</div>
<div id="template-capital-B">
    <div class="form-container">
        <jsp:include page="/WEB-INF/pages/sybris/formulaires/Commun aux bases/commun/field-hidden-readonly.jsp">
            <jsp:param name="fieldId" value="typeEnregistrement"/>
            <jsp:param name="fieldName" value="typeEnregistrement"/>
            <jsp:param name="label" value="Type d'enregistrement (Capital)"/>
            <jsp:param name="value" value="5"/>
            <jsp:param name="maxLength" value="1"/>
        </jsp:include>
        <jsp:include page="/WEB-INF/pages/sybris/formulaires/Commun aux bases/commun/field-text.jsp">
            <jsp:param name="fieldId" value="montantCapitalRestantDu"/>
            <jsp:param name="label" value="Montant capital restant dû"/>
            <jsp:param name="placeholder" value="Montant capital restant dû"/>
            <jsp:param name="maxLength" value="10"/>
            <jsp:param name="requiredType" value="fixed"/>
        </jsp:include>
        <jsp:include page="/WEB-INF/pages/sybris/formulaires/Commun aux bases/commun/field-text.jsp">
            <jsp:param name="fieldId" value="montantInteretsCourus"/>
            <jsp:param name="label" value="Montant intérêts courus"/>
            <jsp:param name="placeholder" value="Montant intérêts courus"/>
            <jsp:param name="maxLength" value="9"/>
            <jsp:param name="requiredType" value=""/>
        </jsp:include>
        <jsp:include page="/WEB-INF/pages/sybris/formulaires/Commun aux bases/commun/field-text.jsp">
            <jsp:param name="fieldId" value="montantInteretCompensateur"/>
            <jsp:param name="label" value="Montant intérêts compensateurs"/>
            <jsp:param name="placeholder" value="Montant intérêts compensateurs"/>
            <jsp:param name="maxLength" value="9"/>
            <jsp:param name="requiredType" value=""/>
        </jsp:include>
        <jsp:include page="/WEB-INF/pages/sybris/formulaires/Commun aux bases/commun/field-text.jsp">
            <jsp:param name="fieldId" value="montantPenalitesRemboursementAnticipe"/>
            <jsp:param name="label" value="Montant pénalités remb. anticipé"/>
            <jsp:param name="placeholder" value="Montant pénalités remb. anticipé"/>
            <jsp:param name="maxLength" value="9"/>
            <jsp:param name="requiredType" value=""/>
        </jsp:include>
    </div>
</div>
<div id="template-capital-C">
    <div class="form-container">
        <jsp:include page="/WEB-INF/pages/sybris/formulaires/Commun aux bases/commun/field-hidden-readonly.jsp">
            <jsp:param name="fieldId" value="typeEnregistrement"/>
            <jsp:param name="fieldName" value="typeEnregistrement"/>
            <jsp:param name="label" value="Type d'enregistrement (Capital)"/>
            <jsp:param name="value" value="5"/>
            <jsp:param name="maxLength" value="1"/>
        </jsp:include>
        <jsp:include page="/WEB-INF/pages/sybris/formulaires/Commun aux bases/commun/field-text.jsp">
            <jsp:param name="fieldId" value="montantCapitalRestantDu"/>
            <jsp:param name="label" value="Montant capital restant dû"/>
            <jsp:param name="placeholder" value="Montant capital restant dû"/>
            <jsp:param name="maxLength" value="10"/>
            <jsp:param name="requiredType" value="fixed"/>
        </jsp:include>
        <jsp:include page="/WEB-INF/pages/sybris/formulaires/Commun aux bases/commun/field-text.jsp">
            <jsp:param name="fieldId" value="montantInteretCompensateur"/>
            <jsp:param name="label" value="Montant intérêt compensateur"/>
            <jsp:param name="placeholder" value="Montant intérêt compensateur"/>
            <jsp:param name="maxLength" value="9"/>
            <jsp:param name="requiredType" value=""/>
        </jsp:include>
    </div>
</div>
