<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%--
    Champ liste déroulante générique, alimentée par un attribut de requête
    déjà posé par EditionSybrisController (ex. "risquesBaseA",
    "ouiNonList"...), chaque item exposant .code et .label (enums Java).
    Params : fieldId, fieldName (optionnel), label, itemsAttribute (nom de
    l'attribut de requête contenant la liste), showCode ("true"|"false" —
    préfixe "code - " devant le libellé), requiredType, conditionalExpr,
    helperText (optionnel, petit texte d'aide sous le select), bases,
    types (mêmes conventions que field-text.jsp).
--%>
<c:set var="items" value="${requestScope[param.itemsAttribute]}"/>
<div class="${empty param.wrapperClass ? 'input-container' : param.wrapperClass}"
     <c:if test="${not empty param.conditionalExpr}">data-required-when="${param.conditionalExpr}"</c:if>
     data-bases="${param.bases}"
     data-types="${param.types}">
    <label for="${param.fieldId}">${param.label}<c:if test="${param.requiredType eq 'fixed'}"> <span class="sybris-required-mark">*</span></c:if><c:if test="${param.requiredType eq 'conditional'}"> <span class="sybris-conditional-mark hidden">*</span></c:if></label>
    <div class="form-select">
        <select id="${param.fieldId}" name="${empty param.fieldName ? param.fieldId : param.fieldName}"<c:if test="${param.requiredType eq 'fixed'}"> required</c:if>>
            <option value="">--</option>
            <c:forEach items="${items}" var="item">
                <option value="${item.code}">
                    <c:choose>
                        <c:when test="${param.showCode eq 'true'}">${item.code} - ${item.label}</c:when>
                        <c:otherwise>${item.label}</c:otherwise>
                    </c:choose>
                </option>
            </c:forEach>
        </select>
    </div>
    <c:if test="${not empty param.helperText}"><p class="sybris-field-helper">${param.helperText}</p></c:if>
</div>
