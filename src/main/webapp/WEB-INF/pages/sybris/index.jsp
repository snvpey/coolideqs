<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://struts.apache.org/tags-html" prefix="html" %>
<%@ taglib uri="http://struts.apache.org/tags-bean" prefix="bean" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <title>Edition Sybris</title>
    <content tag="favicon">edition</content>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
</head>
<body>
<div class="container">
    <div class="jumbotron">
        <h1>Edition Sybris</h1>
        <p>Génération de Flux Sybris (240 caractères) - Déclarations et Prolongations</p>
    </div>

    <!-- Sélection Mode : Saisie manuelle OU Import -->
    <div class="mode-selector">
        <div class="mode-selector-options">
            <div>
                <input type="radio" id="manual" name="mode" value="manual" checked onchange="toggleMode(this.value)">
                <label for="manual"> Saisie manuelle</label>
            </div>
            <div>
                <input type="radio" id="import" name="mode" value="import" onchange="toggleMode(this.value)">
                <label for="import"> Importer un fichier</label>
            </div>
        </div>
    </div>

    <!-- SECTION SAISIE MANUELLE -->
    <div id="manualZone">
        <input type="hidden" id="selectedBase" name="selectedBase" value="">
        <input type="hidden" id="selectedTypeDonnee" name="selectedTypeDonnee" value="">

        <!-- Champs partagés -->
        <div id="shared-fields" class="shared-fields-section">
            <h4>Paramètres du document</h4>
            <div class="shared-fields-content">
                <jsp:include page="/WEB-INF/pages/sybris/enTetes/shared-fields/date-remise.jsp" />
                <jsp:include page="/WEB-INF/pages/sybris/enTetes/shared-fields/chefs-file.jsp" />
            </div>
        </div>

        <!-- Étape 1 : sélection de la base -->
        <div id="base-selection" class="wizard-step">
            <h2 class="wizard-step-title">1. Sélectionnez la base</h2>
            <div class="type-selection-options">
                <c:forEach items="${baseEnum}" var="base">
                    <div class="option-card" onclick="selectBase('${base.code}')">
                        <input type="radio" id="base${base.code}" name="base" value="${base.code}">
                        <label for="base${base.code}">${base.code} - ${base.label}</label>
                    </div>
                </c:forEach>
            </div>
        </div>

        <!-- Étape 2 : Type de données (déclaration / prolongation) -->
        <div id="type-selection" class="wizard-step hidden">
            <h2 class="wizard-step-title">2. Sélectionnez le type de dossier</h2>
            <div class="type-selection-options">
                <c:forEach items="${typesDonnee}" var="typeDonnee">
                    <div class="option-card" onclick="selectTypeDossier('${typeDonnee}')">
                        <input type="radio" id="typeDonnee${typeDonnee}" name="typeDonnee" value="${typeDonnee}">
                        <label for="typeDonnee${typeDonnee}">${typeDonnee.getLabel()}</label>
                    </div>
                </c:forEach>
            </div>
        </div>

        <!-- ============================================================ -->
        <!-- ENREGISTREMENT EN-TÊTE (type 01) : inchangé par rapport à     -->
        <!-- avant — visible seulement si le flux est vide ET qu'une base  -->
        <!-- est sélectionnée (voir SybrisUI.updateEnteteFormVisibility).  -->
        <!-- ============================================================ -->
        <c:if test="${empty dossiersValides}">
            <form id="enteteForm" onsubmit="return false;" style="display:none">
                <div class="collapsible-section optional-section collapsed" id="section-entete">
                    <div class="collapsible-header">
                        <h4 onclick="toggleSection('section-entete')" class="collapsible-header-clickable">
                            <span class="collapse-icon">▼</span>
                            Enregistrement En-tête
                            <span class="optional-badge">(facultatif)</span>
                        </h4>
                    </div>
                    <div class="collapsible-content">
                        <div class="base-block" data-base="A" style="display:none">
                            <jsp:include page="/WEB-INF/pages/sybris/enTetes/enTeteA.jsp" />
                        </div>
                        <div class="base-block" data-base="B" style="display:none">
                            <jsp:include page="/WEB-INF/pages/sybris/enTetes/enTete.jsp" />
                        </div>
                        <div class="base-block" data-base="C" style="display:none">
                            <jsp:include page="/WEB-INF/pages/sybris/enTetes/enTete.jsp" />
                        </div>

                        <button type="button" class="btn btn-primary" onclick="validerEntete()">
                            Ajouter l'en-tête
                        </button>
                    </div>
                </div>
            </form>
        </c:if>

        <!-- ============================================================ -->
        <!-- FORMULAIRE UNIQUE : remplit un Declaration/ProlongationBaseX  -->
        <!-- selon la base et le type sélectionnés à l'étape précédente.   -->
        <!--                                                                -->
        <!-- NOUVEAU (architecture consolidée) : chaque section n'inclut   -->
        <!-- plus qu'UN SEUL fichier JSP (au lieu de 3 ou 6 avant), qui     -->
        <!-- contient lui-même tous les .base-block / .base-type-block     -->
        <!-- nécessaires en interne (cache/visibilise via SybrisUI,        -->
        <!-- inchangé). Les name="..." des champs restent identiques aux   -->
        <!-- getters Java existants — seule l'organisation des fichiers    -->
        <!-- change, pas le contrat JSON envoyé au backend.                -->
        <!-- ============================================================ -->
        <form id="dossier-form" class="dossier-container hidden">
            <div class="dossier-type-header">
                <h2><span id="dossier-icon">&#128196;</span> <span id="dossier-title">Dossier</span></h2>
                <button type="button" class="btn btn-secondary" onclick="resetDossier()">Réinitialiser</button>
            </div>

            <!-- 1. Enregistrement Détail (clé "04", spécifique à la base — identique décla/prolongation) -->
            <div class="collapsible-section" id="section-details">
                <div class="collapsible-header" onclick="toggleSection('section-details')">
                    <h4>
                        <span class="collapse-icon">▼</span>
                        Enregistrement Détails
                    </h4>
                </div>
                <div class="collapsible-content">
                    <jsp:include page="formulaires/unifie/detail.jsp"/>
                </div>
            </div>

            <!-- 2. Dossier (fichier unique, 6 base-type-blocks internes) -->
            <div class="collapsible-section" id="section-dossier">
                <div class="collapsible-header" onclick="toggleSection('section-dossier')">
                    <h4>
                        <span class="collapse-icon">▼</span>
                        Enregistrement Dossier
                    </h4>
                </div>
                <div class="collapsible-content">
                    <jsp:include page="formulaires/unifie/dossier.jsp"/>
                </div>
            </div>

            <!-- 3. Adresse (fichier unique, 3 base-blocks internes : identique décla/prolongation) -->
            <div class="collapsible-section" id="section-adresse">
                <div class="collapsible-header" onclick="toggleSection('section-adresse')">
                    <h4>
                        <span class="collapse-icon">▼</span>
                        Enregistrement Adresse
                    </h4>
                </div>
                <div class="collapsible-content">
                    <jsp:include page="formulaires/unifie/adresse.jsp"/>
                </div>
            </div>

            <!-- 4. Prêt : chaque clic sur "Ajouter un prêt" clone le modèle correspondant
                 à la base/au type courants (voir #pret-templates ci-dessous), et lui
                 adjoint des tableaux d'échéances / capitaux vides et éditables, dans
                 une nouvelle section repliable. -->
            <div class="collapsible-section" id="section-pret">
                <div class="collapsible-header" onclick="toggleSection('section-pret')">
                    <h4>
                        <span class="collapse-icon">▼</span>
                        Enregistrement Prêt
                        <span class="item-badge" id="prets-count">0</span>
                    </h4>
                </div>
                <div class="collapsible-content">
                    <button type="button" class="add-item-btn" onclick="addPret()">
                        <span>+</span> Ajouter un prêt
                    </button>

                    <div id="prets-container">
                        <p class="empty-flux-message" id="prets-empty-message">Aucun prêt ajouté. Cliquez sur « Ajouter un prêt ».</p>
                    </div>
                </div>
            </div>

            <!-- Validation globale -->
            <div class="validation-section">
                <div>
                    <strong>Prévisualiser le dossier</strong>
                    <p class="validation-section-description">
                        Cliquez pour générer les trames du dossier.
                    </p>
                </div>
                <button type="button" class="btn btn-primary" onclick="previewDossier()">
                    Générer les trames
                </button>
            </div>
        </form><!-- /#dossier-form -->

        <!-- ============================================================ -->
        <!-- ENREGISTREMENT FINAL (type 09) : inchangé.                    -->
        <!-- ============================================================ -->
        <form id="final-form" onsubmit="return false;">
            <div class="collapsible-section optional-section collapsed" id="section-final">
                <div class="collapsible-header">
                    <h4 onclick="toggleSection('section-final')" class="collapsible-header-clickable">
                        <span class="collapse-icon">▼</span>
                        Enregistrement Final
                        <span class="optional-badge">(facultatif)</span>
                    </h4>
                </div>
                <div class="collapsible-content">
                    <div class="base-block" data-base="A" style="display:none">
                        <jsp:include page="/WEB-INF/pages/sybris/enTetes/finalA.jsp" />
                    </div>
                    <div class="base-block" data-base="B" style="display:none">
                        <jsp:include page="/WEB-INF/pages/sybris/enTetes/final.jsp" />
                    </div>
                    <div class="base-block" data-base="C" style="display:none">
                        <jsp:include page="/WEB-INF/pages/sybris/enTetes/final.jsp" />
                    </div>

                    <button type="button" class="btn btn-primary" onclick="validerFinal()">
                        Valider le final
                    </button>
                </div>
            </div>
        </form>

        <!-- ============================================================ -->
        <!-- TEMPLATES (jamais soumis : hors de tout <form>)               -->
        <!-- Prêt : fichier unique unifié.jsp/pret.jsp, 6 base-type-blocks -->
        <!-- internes. Échéance/Capital : fichier unique templates.jsp,    -->
        <!-- 6 <div id="template-{echeance|capital}-{A|B|C}"> internes     -->
        <!-- (indexés par base seulement, comme avant).                   -->
        <!-- ============================================================ -->
        <div id="pret-templates" style="display:none">
            <jsp:include page="formulaires/unifie/pret.jsp"/>
        </div>
        <div id="templates" style="display:none">
            <jsp:include page="formulaires/unifie/templates.jsp"/>
        </div>

        <!-- Preview -->
        <div id="preview-section" class="preview-section">
            <h3>Prévisualisation du dossier</h3>
            <div id="preview-content">
                <p class="empty-flux-message">Aucune trame à afficher</p>
            </div>
            <div id="preview-actions" class="preview-actions">
                <button type="button" class="btn btn-success" onclick="addToFlux()">
                    <span class="glyphicon glyphicon-plus"></span> Ajouter au flux
                </button>
                <button type="button" class="btn btn-danger" onclick="clearPreview()">
                    <span class="glyphicon glyphicon-trash"></span> Effacer
                </button>
            </div>
        </div>

        <!-- Flux -->
        <div class="flux-section">
            <h3>Flux</h3>
            <div id="flux-content" class="flux-content">
                <p class="empty-flux-message">Aucune trame dans le flux</p>
            </div>
            <div id="flux-actions" class="flux-actions">
                <button type="button" id="clearFluxBtn" onclick="clearFlux()" class="btn btn-warning">
                    <span class="glyphicon glyphicon-trash"></span> Vider le flux
                </button>
                <button type="button" id="telechargerDossiersBtn" onclick="telechargerDossiers()" class="btn btn-success">
                    <span class="glyphicon glyphicon-download"></span> Télécharger
                </button>
            </div>
        </div>

    </div><!-- /#manualZone -->

    <!-- SECTION IMPORT -->
    <div id="importZone" class="import-zone hidden">
        <div class="alert alert-info">
            <h3>Importer un fichier Sybris</h3>
            <p>Cette fonctionnalité sera disponible prochainement.</p>
            <form id="importForm" method="POST"
                  action="${pageContext.request.contextPath}/sybris/import"
                  enctype="multipart/form-data" class="hidden">
                <div class="form-group">
                    <label for="fichier">Sélectionnez un fichier :</label>
                    <input type="file" id="fichier" name="fichier" accept=".txt,.csv">
                </div>
                <button type="submit" class="btn btn-primary">Importer</button>
            </form>
        </div>
    </div>

</div><!-- /.container -->
<br><br><br>
<script>
    window.contextPath = '${pageContext.request.contextPath}';
</script>
<script src="${pageContext.request.contextPath}/resources/js/sybris/api.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/sybris/payload.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/sybris/ui.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/sybris/handlers.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/sybris/index.js"></script>
</body>
</html>
