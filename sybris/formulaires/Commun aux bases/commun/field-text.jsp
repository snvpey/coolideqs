<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%--
    Champ texte générique.
    Params : fieldId, fieldName (optionnel, défaut = fieldId), label,
    placeholder, maxLength, requiredType ("fixed"|"conditional"|""),
    conditionalExpr (optionnel, condition JS lisible par
    refreshConditionalStars()), wrapperClass (optionnel),
    bases (optionnel, ex. "A B" — sous-ensemble de bases où ce champ
    s'applique ; absent/vide = toutes les bases), types (optionnel, ex.
    "DECLARATION" — sous-ensemble de types ; absent/vide = les deux types).
    data-bases/data-types sont lus par SybrisUI.refreshFieldVisibility()
    (ui.js) pour afficher/masquer ce conteneur selon la base/le type
    actuellement sélectionnés.
--%>
<div class="${empty param.wrapperClass ? 'input-container' : param.wrapperClass}"
     <c:if test="${not empty param.conditionalExpr}">data-required-when="${param.conditionalExpr}"</c:if>
     data-bases="${param.bases}"
     data-types="${param.types}">
    <label for="${param.fieldId}">${param.label}<c:if test="${param.requiredType eq 'fixed'}"> <span class="sybris-required-mark">*</span></c:if><c:if test="${param.requiredType eq 'conditional'}"> <span class="sybris-conditional-mark hidden">*</span></c:if></label>
    <c:choose>
        <c:when test="${param.requiredType eq 'fixed'}">
            <input type="text" id="${param.fieldId}" name="${empty param.fieldName ? param.fieldId : param.fieldName}" placeholder="${param.placeholder}" maxlength="${param.maxLength}" required>
        </c:when>
        <c:otherwise>
            <input type="text" id="${param.fieldId}" name="${empty param.fieldName ? param.fieldId : param.fieldName}" placeholder="${param.placeholder}" maxlength="${param.maxLength}">
        </c:otherwise>
    </c:choose>
</div>
