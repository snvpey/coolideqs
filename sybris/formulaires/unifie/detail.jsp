<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!--
  "Enregistrement Détails" (clé 04 en tête de chaque trame). Le n°
  de séquence est TOUJOURS auto-généré par le backend
  (HeaderService.resolveSequence()) — jamais un champ ici.
  Identique décla/prolongation -> pas de tag types.
-->
<div class="form-container">
    <jsp:include page="/WEB-INF/pages/sybris/formulaires/Commun aux bases/commun/field-select.jsp">
        <jsp:param name="fieldId" value="codeDevise"/>
        <jsp:param name="label" value="Code devise"/>
        <jsp:param name="itemsAttribute" value="devises"/>
        <jsp:param name="showCode" value="true"/>
        <jsp:param name="requiredType" value="fixed"/>
        <jsp:param name="bases" value="A"/>
    </jsp:include>
    <jsp:include page="/WEB-INF/pages/sybris/formulaires/Commun aux bases/commun/field-text.jsp">
        <jsp:param name="fieldId" value="codeOperation"/>
        <jsp:param name="label" value="Code opération"/>
        <jsp:param name="placeholder" value="DI"/>
        <jsp:param name="maxLength" value="2"/>
        <jsp:param name="requiredType" value="fixed"/>
        <jsp:param name="bases" value="A"/>
    </jsp:include>
    <jsp:include page="/WEB-INF/pages/sybris/formulaires/Commun aux bases/commun/field-text.jsp">
        <jsp:param name="fieldId" value="codeEmetteur"/>
        <jsp:param name="label" value="Code émetteur"/>
        <jsp:param name="placeholder" value="10006"/>
        <jsp:param name="maxLength" value="5"/>
        <jsp:param name="requiredType" value="fixed"/>
        <jsp:param name="bases" value="A"/>
    </jsp:include>
    <jsp:include page="/WEB-INF/pages/sybris/formulaires/Commun aux bases/commun/field-text.jsp">
        <jsp:param name="fieldId" value="codeDestinataire"/>
        <jsp:param name="label" value="Code destinataire"/>
        <jsp:param name="placeholder" value="22106"/>
        <jsp:param name="maxLength" value="5"/>
        <jsp:param name="requiredType" value="fixed"/>
        <jsp:param name="bases" value="A"/>
    </jsp:include>
    <jsp:include page="/WEB-INF/pages/sybris/formulaires/Commun aux bases/commun/field-text.jsp">
        <jsp:param name="fieldId" value="collectivite"/>
        <jsp:param name="label" value="Collectivité"/>
        <jsp:param name="placeholder" value="N° collectivité CNP"/>
        <jsp:param name="maxLength" value="6"/>
        <jsp:param name="requiredType" value="fixed"/>
        <jsp:param name="bases" value="A"/>
    </jsp:include>
    <jsp:include page="/WEB-INF/pages/sybris/formulaires/Commun aux bases/commun/field-text.jsp">
        <jsp:param name="fieldId" value="collectivite"/>
        <jsp:param name="label" value="Collectivité"/>
        <jsp:param name="placeholder" value="N° collectivité (n°coll + n° interlocuteur)"/>
        <jsp:param name="maxLength" value="6"/>
        <jsp:param name="requiredType" value="fixed"/>
        <jsp:param name="bases" value="B C"/>
    </jsp:include>
    <jsp:include page="/WEB-INF/pages/sybris/formulaires/Commun aux bases/commun/field-text.jsp">
        <jsp:param name="fieldId" value="sequenceDP"/>
        <jsp:param name="label" value="N° Séquence DP"/>
        <jsp:param name="placeholder" value="N° Séquence DP"/>
        <jsp:param name="maxLength" value="6"/>
        <jsp:param name="requiredType" value=""/>
    </jsp:include>
    <jsp:include page="/WEB-INF/pages/sybris/formulaires/Commun aux bases/commun/field-text.jsp">
        <jsp:param name="fieldId" value="codeApplication"/>
        <jsp:param name="label" value="Code application"/>
        <jsp:param name="placeholder" value="CA"/>
        <jsp:param name="maxLength" value="6"/>
        <jsp:param name="requiredType" value="fixed"/>
        <jsp:param name="bases" value="A"/>
    </jsp:include>
    <jsp:include page="/WEB-INF/pages/sybris/formulaires/Commun aux bases/commun/field-text.jsp">
        <jsp:param name="fieldId" value="codeApplication"/>
        <jsp:param name="label" value="Code application"/>
        <jsp:param name="placeholder" value="CE"/>
        <jsp:param name="maxLength" value="6"/>
        <jsp:param name="requiredType" value="fixed"/>
        <jsp:param name="bases" value="B"/>
    </jsp:include>
    <jsp:include page="/WEB-INF/pages/sybris/formulaires/Commun aux bases/commun/field-text.jsp">
        <jsp:param name="fieldId" value="codeApplication"/>
        <jsp:param name="label" value="Code application"/>
        <jsp:param name="placeholder" value="CH"/>
        <jsp:param name="maxLength" value="6"/>
        <jsp:param name="requiredType" value="fixed"/>
        <jsp:param name="bases" value="C"/>
    </jsp:include>
    <jsp:include page="/WEB-INF/pages/sybris/formulaires/Commun aux bases/commun/field-text.jsp">
        <jsp:param name="fieldId" value="codeUP"/>
        <jsp:param name="label" value="Code UP"/>
        <jsp:param name="placeholder" value="CASY"/>
        <jsp:param name="maxLength" value="4"/>
        <jsp:param name="requiredType" value="fixed"/>
        <jsp:param name="bases" value="A"/>
    </jsp:include>
    <jsp:include page="/WEB-INF/pages/sybris/formulaires/Commun aux bases/commun/field-text.jsp">
        <jsp:param name="fieldId" value="codeUP"/>
        <jsp:param name="label" value="Code UP"/>
        <jsp:param name="placeholder" value="CESY"/>
        <jsp:param name="maxLength" value="4"/>
        <jsp:param name="requiredType" value="fixed"/>
        <jsp:param name="bases" value="B"/>
    </jsp:include>
    <jsp:include page="/WEB-INF/pages/sybris/formulaires/Commun aux bases/commun/field-text.jsp">
        <jsp:param name="fieldId" value="codeUP"/>
        <jsp:param name="label" value="Code UP"/>
        <jsp:param name="placeholder" value="CHSY"/>
        <jsp:param name="maxLength" value="4"/>
        <jsp:param name="requiredType" value="fixed"/>
        <jsp:param name="bases" value="C"/>
    </jsp:include>
    <jsp:include page="/WEB-INF/pages/sybris/formulaires/Commun aux bases/commun/field-text.jsp">
        <jsp:param name="fieldId" value="typeFichier"/>
        <jsp:param name="label" value="Type fichier"/>
        <jsp:param name="placeholder" value="Type fichier"/>
        <jsp:param name="maxLength" value="1"/>
        <jsp:param name="requiredType" value=""/>
    </jsp:include>
</div>
