/**
 * Module UI - Gestion de l'affichage et de l'interface utilisateur.
 */
const SybrisUI = {
    // État global
    selectedBase: null,
    selectedTypeDonnee: null,
    fluxIsEmpty: true,

    // ============ GESTION DE L'ÉTAT ============

    setBase(base) {
        this.selectedBase = base;
        const element = document.getElementById('selectedBase');
        if (element) element.value = base;
    },

    getBase() {
        return this.selectedBase;
    },

    setTypeDonnee(type) {
        this.selectedTypeDonnee = type;
        const element = document.getElementById('selectedTypeDonnee');
        if (element) element.value = type;
    },

    getTypeDonnee() {
        return this.selectedTypeDonnee;
    },

    // ============ TOGGLE MODE MANUEL/IMPORT ============

    toggleMode(mode) {
        const manualZone = document.getElementById('manualZone');
        const importZone = document.getElementById('importZone');
        const isManual = mode === 'manual';

        if (manualZone) {
            manualZone.classList.toggle('hidden', !isManual);
        }
        if (importZone) {
            importZone.classList.toggle('hidden', isManual);
        }
    },

    // ============ TOGGLE SECTIONS ============

    toggleSection(sectionId) {
        const section = document.getElementById(sectionId);
        if (section) {
            section.classList.toggle('collapsed');
        }
    },

    /** Replie/déplie une sous-section nommée (ex: "Identification du prêt"). */
    toggleSubsection(headerEl) {
        const subsection = headerEl.closest('.form-subsection');
        if (subsection) {
            subsection.classList.toggle('collapsed');
        }
    },

    // ============ NOUVEAU : VISIBILITÉ PAR CHAMP (dossier.jsp/adresse.jsp/detail.jsp) ============

    /**
     * Un conteneur "tagué" (data-bases/data-types, posés par field-text.jsp,
     * field-select.jsp, field-hidden-readonly.jsp, field-filler.jsp, ou
     * directement sur les .form-subsection de fillers) est actif pour la
     * sélection courante si :
     * - data-bases est vide OU contient la base sélectionnée, ET
     * - data-types est vide OU contient le type sélectionné.
     * Un champ sans aucun des deux attributs (jamais tagué) est toujours actif.
     */
    _matchesCurrentSelection(basesAttr, typesAttr) {
        const base = this.getBase();
        const type = this.getTypeDonnee();
        const bases = (basesAttr || '').trim();
        const types = (typesAttr || '').trim();
        const basesOk = !bases || bases.split(/\s+/).includes(base);
        const typesOk = !types || types.split(/\s+/).includes(type);
        return basesOk && typesOk;
    },

    /**
     * Bascule individuellement chaque conteneur data-bases/data-types du
     * document (champs, ET sous-sections fillers qui portent les mêmes
     * attributs) selon la base/le type actuellement sélectionnés. Ne
     * touche PAS aux .base-block/.base-type-block de l'ancien système
     * (en-tête, final, modèles de prêt clonés) : ceux-ci restent gérés par
     * selectBase()/selectTypeDossier() comme avant.
     * Appelée à chaque changement de base ou de type.
     */
    refreshFieldVisibility() {
        this.refreshFieldVisibilityWithin(document);
    },

    /**
     * Comme refreshFieldVisibility(), mais scopée à un sous-arbre donné.
     * Utilisée par SybrisPayload.addPret() juste après avoir cloné le
     * modèle de prêt unifié (pret.jsp), pour appliquer une fois la
     * visibilité bases/types courante à l'intérieur de cette instance
     * clonée. Pas besoin de la garder "live" ensuite : changer de base ou
     * de type vide tous les prêts existants (clearPrets()).
     */
    refreshFieldVisibilityWithin(root) {
        root.querySelectorAll('[data-bases], [data-types]').forEach(el => {
            const active = this._matchesCurrentSelection(el.dataset.bases, el.dataset.types);
            el.style.display = active ? '' : 'none';
        });
    },

    /**
     * Trouve, parmi tous les éléments portant name="fieldName" dans
     * #dossier-form, celui qui est actuellement actif pour la base/le type
     * sélectionnés — que ce soit via le nouveau système (data-bases/
     * data-types, dossier.jsp/adresse.jsp/detail.jsp) ou l'ancien
     * (.base-type-block/.base-block, encore utilisé dans les modèles de
     * prêt clonés). Remplace l'ancien getActiveBaseTypeBlock() +
     * querySelector ciblé, devenu impossible depuis que les champs ne sont
     * plus regroupés dans un unique bloc par combo.
     */
    getActiveField(name) {
        const form = document.getElementById('dossier-form');
        if (!form) return null;
        const base = this.getBase();
        const type = this.getTypeDonnee();

        const candidates = form.querySelectorAll(`[name="${name}"]`);
        for (const el of candidates) {
            const tagged = el.closest('[data-bases], [data-types]');
            if (tagged && (tagged.dataset.bases || tagged.dataset.types)) {
                if (this._matchesCurrentSelection(tagged.dataset.bases, tagged.dataset.types)) {
                    return el;
                }
                continue;
            }
            const baseTypeBlock = el.closest('.base-type-block');
            if (baseTypeBlock) {
                if (baseTypeBlock.dataset.base === base && baseTypeBlock.dataset.type === type) return el;
                continue;
            }
            const baseBlock = el.closest('.base-block');
            if (baseBlock) {
                if (baseBlock.dataset.base === base) return el;
                continue;
            }
            return el; // jamais restreint : le premier suffit
        }
        return null;
    },

    /** Sélecteur de risque actif (dossier.jsp — nouveau système taggé). */
    getRisqueSelect() {
        return this.getActiveField('risque');
    },

    /**
     * Bascule l'étoile conditionnelle sur le SEUL champ name="fieldName"
     * actuellement actif (remplace l'ancien toggleConditionalStar(root,...)
     * scopé à un "activeBlock" qui n'existe plus).
     */
    toggleConditionalStarByName(fieldName, enabled) {
        const input = this.getActiveField(fieldName);
        if (!input) return;
        const container = input.closest('.input-container, .form-select');
        const star = container?.querySelector('.sybris-conditional-mark');
        if (star) star.classList.toggle('hidden', !enabled);
        if (container) container.classList.toggle('is-conditionally-required', enabled);
    },

    /** Idem, mais scopé à un sous-arbre donné (utilisé pour les champs à l'intérieur d'un prêt cloné, où name="..." est sans ambiguïté). */
    toggleConditionalStarWithin(root, fieldName, enabled) {
        if (!root) return;
        root.querySelectorAll(`[name="${fieldName}"]`).forEach(input => {
            const container = input.closest('.input-container, .form-select');
            const star = container?.querySelector('.sybris-conditional-mark');
            if (star) star.classList.toggle('hidden', !enabled);
            if (container) container.classList.toggle('is-conditionally-required', enabled);
        });
    },

    refreshConditionalStars() {
        const base = this.getBase();
        const type = this.getTypeDonnee();
        const risque = this.getActiveField('risque')?.value || '';
        const etatCivil = this.getActiveField('etatCivil')?.value || '';
        const demandeControleMedical = this.getActiveField('demandeControleMedical')?.value || '';

        const isBaseA = base === 'A';
        const isDeclaration = type === 'DECLARATION';
        const isProlongation = type === 'PROLONGATION';
        const periodicRisk = isBaseA ? ['3', '4'] : ['1', '4'];
        const socialRisk = isBaseA ? ['1', '2', '3', '5'] : ['1', '3', '4', '5'];
        const dureePretRisk = ['1', '2', '5'];

        this.toggleConditionalStarByName('nomJeuneFille', etatCivil === '2');
        this.toggleConditionalStarByName('dateDebPerJustifiee', isProlongation || periodicRisk.includes(risque));
        this.toggleConditionalStarByName('dateFinPeriodeJustifiee', isProlongation || periodicRisk.includes(risque));
        this.toggleConditionalStarByName('codeAssureSocial', isDeclaration && socialRisk.includes(risque));
        this.toggleConditionalStarByName('codePrestationsEspece', isDeclaration && socialRisk.includes(risque));
        this.toggleConditionalStarByName('dateNotificationChomage', isBaseA && isDeclaration && risque === '4');
        this.toggleConditionalStarByName('codeSalarie', !isBaseA && isDeclaration && risque === '1');
        this.toggleConditionalStarByName('motifSuspension', demandeControleMedical === 'O');

        // Prêts clonés (modèle par-combo inchangé) : les champs y sont sans
        // ambiguïté (un seul name="..." par instance clonée), donc on
        // scope directement à chaque .pret-instance, comme avant.
        document.querySelectorAll('#prets-container .pret-instance').forEach(pret => {
            const modaliteEntree = pret.querySelector('[name="modaliteEntree"]')?.value || '';
            this.toggleConditionalStarWithin(pret, 'referenceLiasse', modaliteEntree === 'QSC');
            this.toggleConditionalStarWithin(pret, 'dateSignature', modaliteEntree === 'QSC');
            this.toggleConditionalStarWithin(pret, 'dateAcceptation', modaliteEntree === 'QSC');
            this.toggleConditionalStarWithin(pret, 'dureePret', isBaseA && isDeclaration && dureePretRisk.includes(risque));
            this.toggleConditionalStarWithin(pret, 'optionPersonneAgee', !isBaseA && isDeclaration && risque !== '4' && risque !== '');
            this.toggleConditionalStarWithin(pret, 'dateOrigine', !isBaseA && isDeclaration && risque === '4');
        });
    },

    initConditionalStars() {
        if (!document.body.dataset.sybrisConditionalStarsBound) {
            document.body.dataset.sybrisConditionalStarsBound = 'true';
            document.addEventListener('change', event => {
                const fieldName = event.target?.name;
                if (['risque', 'etatCivil', 'demandeControleMedical', 'modaliteEntree'].includes(fieldName)) {
                    this.refreshConditionalStars();
                }
            });
        }
        this.refreshConditionalStars();
    },

    // ============ SÉLECTION DE LA BASE ============

    selectBase(base) {
        const changed = this.getBase() !== base;
        this.setBase(base);

        // Ancien système : encore utilisé par en-tête/final (inchangés)
        // et par les modèles de prêt clonés (#pret-templates).
        document.querySelectorAll('.base-block').forEach(block => {
            block.style.display = block.dataset.base === base ? 'block' : 'none';
        });

        // Nouveau système : dossier.jsp/adresse.jsp/detail.jsp, champ par champ.
        this.refreshFieldVisibility();

        // Passe à l'étape 2 (type de dossier)
        const typeSelection = document.getElementById('type-selection');
        if (typeSelection) {
            typeSelection.classList.remove('hidden');
        }

        this.updateEnteteFormVisibility(this.fluxIsEmpty);

        if (changed) {
            // On repart d'un type de dossier non sélectionné et d'un formulaire vide
            this.setTypeDonnee(null);
            document.querySelectorAll('input[name="typeDonnee"]').forEach(r => r.checked = false);
            document.getElementById('dossier-form')?.classList.add('hidden');
            SybrisPayload.clearPrets();
            SybrisPayload.clearItems('echeance');
            SybrisPayload.clearItems('capital');
        }
    },

    // ============ SÉLECTION TYPE DOSSIER ============

    selectTypeDossier(type) {
        this.setTypeDonnee(type);

        const form = document.getElementById('dossier-form');
        if (!form) return;

        form.classList.remove('hidden');

        // Ancien système (modèles de prêt clonés, s'il en existe déjà -
        // normalement clearPrets() vient de tout vider, mais on garde par
        // cohérence/robustesse) :
        form.querySelectorAll('.base-type-block').forEach(block => {
            const matches = block.dataset.base === this.getBase() && block.dataset.type === type;
            block.style.display = matches ? 'block' : 'none';
        });

        // Nouveau système : dossier.jsp/adresse.jsp/detail.jsp, champ par champ.
        this.refreshFieldVisibility();

        // Titre / icône
        const title = document.getElementById('dossier-title');
        const icon = document.getElementById('dossier-icon');
        const base = this.getBase();
        if (title) {
            title.textContent = type === 'DECLARATION'
                ? `Dossier Déclaration (Base ${base})`
                : `Dossier Prolongation (Base ${base})`;
        }
        if (icon) {
            icon.textContent = type === 'DECLARATION' ? '📄' : '⏳';
        }

        SybrisPayload.clearPrets();
        SybrisPayload.clearItems('echeance');
        SybrisPayload.clearItems('capital');

        SybrisPayload.init();
        this.initRiskConstraints();
        this.initConditionalStars();
    },

    // ============ CONTRAINTES MÉTIER SELON LE RISQUE ============

    // Risques autorisant l'ajout de sous-items (capital / échéance).
    // ATTENTION : les codes de risque diffèrent selon la base (cf. enums Java
    // BaseARisqueEnum / BaseBRisqueEnum / BaseCRisqueEnum) :
    //   - Base A : 1=Décès, 2=IPA, 3=ITT, 4=Chômage, 5=ITD
    //   - Base B/C : 1=Incapacité travail, 2=Décès, 3=IPA, 4=Chômage, 5=ITD
    RISK_RULES: {
        A: { capital: ['1', '2', '5'], echeance: ['3', '4'] }, // Décès, IPA, ITD / ITT, Chômage
        B: { capital: ['2', '3'], echeance: ['1', '4'] },      // Décès, IPA / Incapacité travail, Chômage
        C: { capital: ['2', '3'], echeance: ['1', '4'] }
    },

    /**
     * Affiche/masque les blocs « Saisie des échéances » et « Saisie des
     * capitaux » de CHAQUE prêt ajouté, selon le risque du dossier (champ
     * partagé, unique pour tout le dossier — lu via getRisqueSelect(),
     * nouveau système taggé).
     */
    updateRiskConstraints() {
        const risque = this.getRisqueSelect()?.value || '';
        const isDeclaration = this.getTypeDonnee() === 'DECLARATION';
        const rules = this.RISK_RULES[this.getBase()] || this.RISK_RULES.B;

        document.querySelectorAll('#prets-container .pret-subitems-block[data-subtype="echeance"]')
            .forEach(el => {
                el.style.display = rules.echeance.includes(risque) ? '' : 'none';
            });
        document.querySelectorAll('#prets-container .pret-subitems-block[data-subtype="capital"]')
            .forEach(el => {
                el.style.display = (isDeclaration && rules.capital.includes(risque)) ? '' : 'none';
            });
    },

    /** Branche l'écouteur sur le sélecteur de risque et applique l'état initial. */
    initRiskConstraints() {
        const risqueSelect = this.getRisqueSelect();
        if (risqueSelect && !risqueSelect.dataset.riskBound) {
            risqueSelect.dataset.riskBound = 'true';
            risqueSelect.dataset.previousRisk = risqueSelect.value || '';
            risqueSelect.addEventListener('change', () => {
                const current = risqueSelect.value || '';
                if (current !== (risqueSelect.dataset.previousRisk || '')) {
                    // Le risque change : les sous-items précédents ne sont plus valides
                    SybrisPayload.clearItems('echeance');
                    SybrisPayload.clearItems('capital');
                }
                risqueSelect.dataset.previousRisk = current;
                this.updateRiskConstraints();
            });
        }
        this.updateRiskConstraints();
    },

    // ============ AFFICHAGE PREVIEW ============

    displayPreview(previewData) {
        const previewSection = document.getElementById('preview-section');
        const previewContent = document.getElementById('preview-content');
        const previewActions = document.getElementById('preview-actions');

        if (!previewSection || !previewContent) return;

        if (previewData && previewData.success && previewData.trames) {
            let html = '<div class="trame-container-success">';

            // trames est un String - on split par ligne pour l'affichage
            const lignes = previewData.trames.split(/\/n|\r?\n/).filter(l => l.trim() !== '');
            lignes.forEach(ligne => {
                html += `<div class="trame-line">${ligne}</div>`;
            });

            html += '</div>';
            previewContent.innerHTML = html;
            previewSection.classList.remove('hidden');
            previewSection.style.display = 'block';
            if (previewActions) {
                previewActions.classList.remove('hidden');
                previewActions.style.display = 'flex';
            }
        } else {
            const errorMsg = previewData?.errorMessage || 'Erreur inconnue';
            previewContent.innerHTML = `
                <div class="trame-container-error">
                    <p>${errorMsg}</p>
                </div>`;
            previewSection.classList.remove('hidden');
            previewSection.style.display = 'block';
            if (previewActions) {
                previewActions.classList.add('hidden');
                previewActions.style.display = 'none';
            }
        }
    },

    clearPreview() {
        const previewSection = document.getElementById('preview-section');
        const previewActions = document.getElementById('preview-actions');
        if (previewSection) {
            previewSection.classList.add('hidden');
            previewSection.style.display = 'none';
        }
        if (previewActions) {
            previewActions.classList.add('hidden');
            previewActions.style.display = 'none';
        }
    },

    // ============ AFFICHAGE FLUX ============

    displayFlux(fluxData) {
        const fluxView = document.getElementById('flux-content');
        const fluxActions = document.getElementById('flux-actions');

        const dossiers = fluxData || [];
        const fluxIsEmpty = dossiers.length === 0;
        this.fluxIsEmpty = fluxIsEmpty;

        this.updateSequenceFieldVisibility(fluxIsEmpty);
        this.updateEnteteFormVisibility(fluxIsEmpty);

        if (!fluxView) return;

        if (fluxIsEmpty) {
            fluxView.innerHTML = '<p class="empty-flux-message">Aucune trame dans le flux</p>';
            if (fluxActions) {
                fluxActions.classList.add('hidden');
                fluxActions.style.display = 'none';
            }
        } else {
            let html = '';
            dossiers.forEach((dossier, index) => {
                if (dossier.frame) {
                    const lignes = dossier.frame.split(/\/n|\r?\n/).filter(l => l.trim() !== '');
                    lignes.forEach(ligne => {
                        html += `<div class="trame-line">${ligne}</div>`;
                    });
                }
                if (index < dossiers.length - 1) {
                    html += '<hr class="trame-separator">';
                }
            });
            fluxView.innerHTML = html || '<p class="empty-flux-message">Aucune trame dans le flux</p>';
            if (fluxActions && html) {
                fluxActions.classList.remove('hidden');
                fluxActions.style.display = 'block';
            }
        }
    },

    updateSequenceFieldVisibility(fluxIsEmpty) {
        const wrapper = document.getElementById('sequence-field-wrapper');
        if (wrapper) {
            wrapper.style.display = fluxIsEmpty ? '' : 'none';
        }
    },

    /**
     * Révèle #enteteForm seulement si flux vide ET une base est
     * sélectionnée. Le JSP part de style="display:none" (évite le flash
     * avant que le fetch initial /sybris/flux ait résolu).
     */
    updateEnteteFormVisibility(fluxIsEmpty) {
        const enteteForm = document.getElementById('enteteForm');
        if (!enteteForm) return;
        const hasBase = !!this.getBase();
        enteteForm.style.display = (fluxIsEmpty && hasBase) ? '' : 'none';
    },

    // ============ RESET DOSSIER ============

    resetDossierForm() {
        const form = document.getElementById('dossier-form');
        if (!form) return;

        SybrisPayload.clearPrets();
        SybrisPayload.clearItems('echeance');
        SybrisPayload.clearItems('capital');

        form.querySelectorAll('input, select, textarea').forEach(input => {
            if (input.readOnly || input.classList.contains('readonly-field')) return;
            if (input.type === 'checkbox' || input.type === 'radio') {
                input.checked = false;
            } else {
                input.value = '';
            }
        });

        this.updateRiskConstraints();
    }
};
