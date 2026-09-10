<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!--
  Échéance/Capital UNIFIÉS (plus de template-echeance-A/B/C x3) :
  un seul <div id="template-echeance">/"template-capital">, champs
  tagués bases="C" seulement pour les 2 champs spécifiques à la
  base C. _storeTemplates() stocke maintenant UNE entrée par type
  (plus par base) ; _extractFieldElements() filtre les champs par
  bases avant de construire les colonnes du tableau — c'est ce
  filtrage qui fait qu'une base A n'affichera que 2 colonnes même
  si le template en contient 4.
-->
<div id="template-echeance" style="display:none">
    <div class="sybris-subform">
        <div class="form-subsection">
            <div class="form-subsection-header" onclick="toggleSubsection(this)">
                <span class="form-subsection-icon">▾</span>
                <h6>Échéance</h6>
            </div>
            <div class="form-subsection-body">
                <div class="form-container">
                    <jsp:include page="/WEB-INF/pages/sybris/formulaires/Commun aux bases/commun/field-hidden-readonly.jsp">
                        <jsp:param name="fieldId" value="typeEnregistrement"/>
                        <jsp:param name="fieldName" value="typeEnregistrement"/>
                        <jsp:param name="label" value="Type d'enregistrement (Échéance)"/>
                        <jsp:param name="value" value="4"/>
                        <jsp:param name="maxLength" value="1"/>
                    </jsp:include>
                    <div class="input-container">
                        <label for="dateEcheance">Date d'échéance <span class="sybris-required-mark">*</span></label>
                        <input type="date" id="dateEcheance" name="dateEcheance" required>
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
                        <jsp:param name="bases" value="C"/>
                    </jsp:include>
                    <jsp:include page="/WEB-INF/pages/sybris/formulaires/Commun aux bases/commun/field-text.jsp">
                        <jsp:param name="fieldId" value="montantCotisationITDC"/>
                        <jsp:param name="label" value="Montant cotisation IT/DC"/>
                        <jsp:param name="placeholder" value="Montant cotisation IT/DC"/>
                        <jsp:param name="maxLength" value="7"/>
                        <jsp:param name="requiredType" value=""/>
                        <jsp:param name="bases" value="C"/>
                    </jsp:include>
                </div>
            </div>
        </div>
    </div>
</div>
<div id="template-capital" style="display:none">
    <div class="sybris-subform">
        <div class="form-subsection">
            <div class="form-subsection-header" onclick="toggleSubsection(this)">
                <span class="form-subsection-icon">▾</span>
                <h6>Capital</h6>
            </div>
            <div class="form-subsection-body">
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
                        <jsp:param name="bases" value="A"/>
                    </jsp:include>
                    <jsp:include page="/WEB-INF/pages/sybris/formulaires/Commun aux bases/commun/field-text.jsp">
                        <jsp:param name="fieldId" value="montantInteretsCourus"/>
                        <jsp:param name="label" value="Montant intérêts courus"/>
                        <jsp:param name="placeholder" value="Montant intérêts courus"/>
                        <jsp:param name="maxLength" value="9"/>
                        <jsp:param name="requiredType" value=""/>
                        <jsp:param name="bases" value="B"/>
                    </jsp:include>
                    <jsp:include page="/WEB-INF/pages/sybris/formulaires/Commun aux bases/commun/field-text.jsp">
                        <jsp:param name="fieldId" value="montantInteretCompensateur"/>
                        <jsp:param name="label" value="Montant intérêts compensateurs"/>
                        <jsp:param name="placeholder" value="Montant intérêts compensateurs"/>
                        <jsp:param name="maxLength" value="9"/>
                        <jsp:param name="requiredType" value=""/>
                        <jsp:param name="bases" value="B"/>
                    </jsp:include>
                    <jsp:include page="/WEB-INF/pages/sybris/formulaires/Commun aux bases/commun/field-text.jsp">
                        <jsp:param name="fieldId" value="montantInteretCompensateur"/>
                        <jsp:param name="label" value="Montant intérêt compensateur"/>
                        <jsp:param name="placeholder" value="Montant intérêt compensateur"/>
                        <jsp:param name="maxLength" value="9"/>
                        <jsp:param name="requiredType" value=""/>
                        <jsp:param name="bases" value="C"/>
                    </jsp:include>
                    <jsp:include page="/WEB-INF/pages/sybris/formulaires/Commun aux bases/commun/field-text.jsp">
                        <jsp:param name="fieldId" value="montantPenalitesRemboursementAnticipe"/>
                        <jsp:param name="label" value="Montant pénalités remb. anticipé"/>
                        <jsp:param name="placeholder" value="Montant pénalités remb. anticipé"/>
                        <jsp:param name="maxLength" value="9"/>
                        <jsp:param name="requiredType" value=""/>
                        <jsp:param name="bases" value="B"/>
                    </jsp:include>
                </div>
            </div>
        </div>
    </div>
</div>
