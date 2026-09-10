/**
 * Handlers globaux - Orchestration des actions utilisateur.
 * Appelle les modules API, UI et Payload selon les besoins.
 */

// ============ HANDLERS MODE & SECTIONS ============

function toggleMode(mode) {
    SybrisUI.toggleMode(mode);
}

function toggleSection(sectionId) {
    SybrisUI.toggleSection(sectionId);
}

/** Replie/déplie une sous-section nommée (ex: "Identification du prêt"). */
function toggleSubsection(headerEl) {
    SybrisUI.toggleSubsection(headerEl);
}

function selectBase(base) {
    SybrisUI.selectBase(base);
}

function selectTypeDossier(type) {
    SybrisUI.selectTypeDossier(type);
}

// ============ HANDLERS PRÊTS (clonage du formulaire) ============

/** Clone le formulaire prêt (vide) et crée une nouvelle section "Informations prêt n°N". */
function addPret() {
    SybrisPayload.addPret();
}

/** Supprime intégralement une section de prêt (formulaire + échéances + capitaux). */
function removePret(pretId) {
    SybrisPayload.removePret(pretId);
}

/**
 * Ajoute une ligne éditable (échéance ou capital) dans le tableau du prêt donné.
 * @param {'echeance'|'capital'} type
 * @param {number} pretId
 */
function addSubItemRow(type, pretId) {
    SybrisPayload.addSubItemRow(type, pretId);
}

/**
 * Supprime une ligne (échéance ou capital) du tableau du prêt donné.
 * @param {'echeance'|'capital'} type
 * @param {number} pretId
 * @param {number} rowId
 */
function removeSubItemRow(type, pretId, rowId) {
    SybrisPayload.removeSubItemRow(type, pretId, rowId);
}

// ============ VALIDATION NATIVE (HTML5 required, sans submit réel) ============

/**
 * Valide tous les champs (input/select/textarea) "required" à l'intérieur
 * d'un conteneur — form OU simple div, peu importe — en réutilisant la
 * validation native du navigateur (bulle d'erreur + focus inclus), sans
 * déclencher de vraie soumission de formulaire.
 *
 * Les champs "barred from constraint validation" (dans un ancêtre en
 * display:none, disabled, etc.) sont automatiquement ignorés par le
 * navigateur : reportValidity() renvoie true pour eux sans rien afficher.
 * C'est exactement ce qu'il faut pour ignorer les .base-block /
 * .base-type-block des bases/types non sélectionnés.
 *
 * @param {HTMLElement|null} container
 * @returns {boolean} true si tout est valide (ou container absent)
 */
function _reportContainerValidity(container) {
    if (!container) return true;

    const controls = container.querySelectorAll('input, select, textarea');
    for (const control of controls) {
        if (!control.reportValidity()) {
            return false; // le navigateur a déjà affiché la bulle et mis le focus
        }
    }
    return true;
}

// ============ HANDLERS PREVIEW ============

async function previewDossier() {
    const sharedFields = document.getElementById('shared-fields');
    const dossierForm = document.getElementById('dossier-form');

    //if (!_reportContainerValidity(sharedFields) || !_reportContainerValidity(dossierForm)) {
    //    return; // bulle déjà affichée par le navigateur, on s'arrête là
    //}

    const payload = SybrisPayload.build();

    if (!payload.base || !payload.typeDeclaration) {
        SybrisUI.displayPreview({
            success: false,
            errorMessage: 'Veuillez sélectionner une base et un type de dossier avant la prévisualisation.'
        });
        return;
    }


    try {
        const result = await SybrisApi.preview(payload.typeDeclaration, payload.base, payload);
        SybrisUI.displayPreview(result);
    } catch (error) {
        console.error('Erreur prévisualisation:', error);
        SybrisUI.displayPreview({ success: false, errorMessage: error.message });
    }
}

/**
 * Valide l'enregistrement En-tête (type 01). L'en-tête est postée
 * directement dans le flux côté back (fluxService.setHeader) dès que la
 * réponse est positive : pas de bouton "Ajouter au flux" à cliquer en plus,
 * on rafraîchit directement l'affichage du flux et on réinitialise le
 * formulaire. clearPreview() (et pas seulement hidePreviewActions) masque
 * toute la zone de preview : sinon la trame restait affichée deux fois
 * (dans #preview-content ET dans #flux-content).
 */
async function validerEntete() {
    const sharedFields = document.getElementById('shared-fields');
    const enteteForm = document.getElementById('enteteForm');

    if (!_reportContainerValidity(sharedFields) || !_reportContainerValidity(enteteForm)) {
        return;
    }

    const base = SybrisPayload.getBase();
    if (!base) {
        SybrisUI.displayPreview({
            success: false,
            errorMessage: 'Sélectionnez une base avant de valider l\'en-tête.'
        });
        return;
    }

    const payload = SybrisPayload.buildEntete();

    try {
        const result = await SybrisApi.previewEntete(base, payload);

        if (result.success) {
            // Postée directement en flux côté back : on n'affiche PAS de
            // preview séparée, on rafraîchit juste le flux.
            SybrisUI.clearPreview();
            SybrisUI.displayFlux(result.fluxDossiers);
            if (enteteForm) enteteForm.reset();
            SybrisPayload.lastKind = null;
        } else {
            SybrisUI.displayPreview(result);
        }
    } catch (error) {
        console.error('Erreur validation en-tête:', error);
        SybrisUI.displayPreview({ success: false, errorMessage: error.message });
    }
}

/**
 * Valide l'enregistrement Final (type 09). Même principe que l'en-tête :
 * posé directement dans le flux côté back dès validation.
 */
async function validerFinal() {
    const sharedFields = document.getElementById('shared-fields');
    const finalForm = document.getElementById('final-form');

    if (!_reportContainerValidity(sharedFields) || !_reportContainerValidity(finalForm)) {
        return;
    }

    const base = SybrisPayload.getBase();
    if (!base) {
        SybrisUI.displayPreview({
            success: false,
            errorMessage: 'Sélectionnez une base avant de valider le final.'
        });
        return;
    }

    const payload = SybrisPayload.buildFinal();

    try {
        const result = await SybrisApi.previewFinal(base, payload);

        if (result.success) {
            SybrisUI.clearPreview();
            SybrisUI.displayFlux(result.fluxDossiers);
            if (finalForm) finalForm.reset();
            SybrisPayload.lastKind = null;
        } else {
            SybrisUI.displayPreview(result);
        }
    } catch (error) {
        console.error('Erreur validation final:', error);
        SybrisUI.displayPreview({ success: false, errorMessage: error.message });
    }
}

async function clearPreview() {
    SybrisUI.clearPreview();
    try {
        await SybrisApi.clearPreview();
    } catch (error) {
        console.error('Erreur clear preview:', error);
    }
}

// ============ HANDLERS FLUX ============

/**
 * Ajoute au flux le dossier (déclaration/prolongation) qui vient d'être
 * prévisualisé. L'en-tête et le final ne passent plus par ce chemin : ils
 * sont ajoutés automatiquement dès leur validation (voir validerEntete /
 * validerFinal), donc ce bouton ne concerne plus que le formulaire dossier.
 */
async function addToFlux() {
    try {
        const result = await SybrisApi.addToFlux();
        if (result.success) {
            SybrisUI.displayFlux(result.fluxDossiers);
            SybrisUI.resetDossierForm();
            SybrisUI.clearPreview();
            SybrisPayload.lastKind = null;
        } else {
            alert(result.errorMessage || 'Erreur lors de l\'ajout au flux');
        }
    } catch (error) {
        console.error('Erreur addToFlux:', error);
        alert('Erreur lors de l\'ajout au flux');
    }
}

async function clearFlux() {
    if (!confirm('Êtes-vous sûr de vouloir vider le flux ?')) {
        return;
    }

    try {
        await SybrisApi.clearFlux();
        SybrisUI.displayFlux([]);
    } catch (error) {
        console.error('Erreur clearFlux:', error);
        alert('Erreur lors du vidage du flux');
    }
}

function telechargerDossiers() {
    SybrisApi.telecharger();
}

// ============ HANDLERS RESET ============

function resetDossier() {
    if (!confirm('Êtes-vous sûr de vouloir réinitialiser le dossier ?')) {
        return;
    }
    SybrisUI.resetDossierForm();
    clearPreview();
}
