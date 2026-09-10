<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%--
    Champ en lecture seule, valeur fixe pré-remplie (ex. le code "1"/"2"/...
    de type d'enregistrement en tête de chaque section — purement indicatif
    à l'écran : ces codes sont écrits en dur côté service Java, pas lus
    depuis ce champ).
    Params : fieldId, fieldName, label, value, maxLength, bases, types.
--%>
<div class="input-container sybris-readonly-field"
     data-bases="${param.bases}"
     data-types="${param.types}">
    <label for="${param.fieldId}">${param.label}</label>
    <input type="text" id="${param.fieldId}" name="${empty param.fieldName ? param.fieldId : param.fieldName}"
           value="${param.value}" maxlength="${param.maxLength}" readonly class="readonly-field">
</div>
