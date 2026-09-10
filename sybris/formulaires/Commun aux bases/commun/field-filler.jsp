<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%--
    Champ "filler" : documente une plage d'octets non utilisés de la
    trame (bourrage, généré côté back par
    textFormatService.addFiller(N) — ce champ est purement cosmétique,
    aucun setter Java ne le lit). fieldID (majuscule, comme dans le
    fragment d'origine) est le libellé affiché ; name est le nom du champ
    HTML (jamais mappé à un DTO) ; fillerPosition/fillerLength documentent
    la position/longueur exacte dans la trame de 240 caractères.
    Params : fieldID, name, fillerPosition, fillerLength, bases, types.
--%>
<div class="input-container sybris-filler-field"
     data-bases="${param.bases}"
     data-types="${param.types}">
    <label for="${param.name}">${param.fieldID} <span class="sybris-filler-length">(${param.fillerLength} car.)</span></label>
    <input type="text" id="${param.name}" name="${param.name}" maxlength="${param.fillerLength}"
           placeholder="Non utilisé">
</div>
