const SybrisUI = {
    // État global
    selectedBase: null,
    selectedTypeDonnee: null,

    /**
     * Vrai tant que le fetch /sybris/flux (déclenché par index.js au
     * chargement) n'a pas encore résolu, ET tant que le flux reste vide
     * ensuite. Sert à updateEnteteFormVisibility pour recalculer la
     * visibilité à chaque changement de base (pas seulement à chaque
     * changement du flux) : les deux conditions doivent être vraies en
     * même temps pour révéler #enteteForm.
     */
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

    getActiveBaseTypeBlock() {
        const form = document.getElementById('dossier-form');
        if (!form) return null;
        const type = this.getTypeDonnee();
        const base = this.getBase();
        return form.querySelector(`.base-type-block[data-base="${base}"][data-type="${type}"]`);
    },

    getActiveField(name) {
        return this.getActiveBaseTypeBlock()?.querySelector(`[name="${name}"]`) || null;
    },

    toggleConditionalStar(root, fieldName, enabled) {
        if (!root) return;
        root.querySelectorAll(`[name="${fieldName}"]`).forEach(input => {
            const container = input.closest('.input-container, .form-select');
            const star = container?.querySelector('.sybris-conditional-mark');
            if (star) {
                star.classList.toggle('hidden', !enabled);
            }
            if (container) {
                container.classList.toggle('is-conditionally-required', enabled);
            }
        });
    },

    refreshConditionalStars() {
        const base = this.getBase();
        const type = this.getTypeDonnee();
        const risque = this.getRisqueSelect()?.value || '';
        const etatCivil = this.getActiveField('etatCivil')?.value || '';
        const demandeControleMedical = this.getActiveField('demandeControleMedical')?.value || '';

        const activeBlock = this.getActiveBaseTypeBlock();
        const isBaseA = base === 'A';
        const isDeclaration = type === 'DECLARATION';
        const isProlongation = type === 'PROLONGATION';
        const periodicRisk = isBaseA ? ['3', '4'] : ['1', '4'];
        const socialRisk = isBaseA ? ['1', '2', '3', '5'] : ['1', '3', '4', '5'];
        const dureePretRisk = ['1', '2', '5'];

        this.toggleConditionalStar(activeBlock, 'nomJeuneFille', etatCivil === '2');
        this.toggleConditionalStar(activeBlock, 'dateDebPerJustifiee', isProlongation || periodicRisk.includes(risque));
        this.toggleConditionalStar(activeBlock, 'dateFinPeriodeJustifiee', isProlongation || periodicRisk.includes(risque));
        this.toggleConditionalStar(activeBlock, 'codeAssureSocial', isDeclaration && socialRisk.includes(risque));
        this.toggleConditionalStar(activeBlock, 'codePrestationsEspece', isDeclaration && socialRisk.includes(risque));
        this.toggleConditionalStar(activeBlock, 'dateNotificationChomage', isBaseA && isDeclaration && risque === '4');
        this.toggleConditionalStar(activeBlock, 'codeSalarie', !isBaseA && isDeclaration && risque === '1');
        this.toggleConditionalStar(activeBlock, 'motifSuspension', demandeControleMedical === 'O');

        document.querySelectorAll('#prets-container .pret-instance').forEach(pret => {
            const modaliteEntree = pret.querySelector('[name="modaliteEntree"]')?.value || '';
            this.toggleConditionalStar(pret, 'referenceLiasse', modaliteEntree === 'QSC');
            this.toggleConditionalStar(pret, 'dateSignature', modaliteEntree === 'QSC');
            this.toggleConditionalStar(pret, 'dateAcceptation', modaliteEntree === 'QSC');
            this.toggleConditionalStar(pret, 'dureePret', isBaseA && isDeclaration && dureePretRisk.includes(risque));
            this.toggleConditionalStar(pret, 'optionPersonneAgee', !isBaseA && isDeclaration && risque !== '4' && risque !== '');
            this.toggleConditionalStar(pret, 'dateOrigine', !isBaseA && isDeclaration && risque === '4');
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

        document.querySelectorAll('.base-block').forEach(block => {
            block.style.display = block.dataset.base === base ? 'block' : 'none';
        });

        // Passe à l'étape 2 (type de dossier)
        const typeSelection = document.getElementById('type-selection');
        if (typeSelection) {
            typeSelection.classList.remove('hidden');
        }

        // La base vient de changer : recalcule la visibilité de l'en-tête
        // (elle dépend aussi de "une base est sélectionnée", pas seulement
        // du flux). Nécessaire aussi bien au tout premier clic sur une base
        // qu'à un changement de base ultérieur.
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

        const base = this.getBase();

        // Affiche uniquement les blocs correspondant à la base ET au type sélectionnés
        form.querySelectorAll('.base-type-block').forEach(block => {
            const matches = block.dataset.base === base && block.dataset.type === type;
            block.style.display = matches ? 'block' : 'none';
        });

        // Titre / icône
        const title = document.getElementById('dossier-title');
        const icon = document.getElementById('dossier-icon');
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

    /** Sélecteur de risque du bloc actuellement visible. */
    getRisqueSelect() {
        const form = document.getElementById('dossier-form');
        if (!form) return null;
        const type = this.getTypeDonnee();
        const base = this.getBase();
        return form.querySelector(
            `.base-type-block[data-base="${base}"][data-type="${type}"] select[name="risque"]`);
    },

    /**
     * Affiche/masque les blocs « Saisie des échéances » et « Saisie des
     * capitaux » de CHAQUE prêt ajouté, selon le risque du dossier (champ
     * partagé, unique pour tout le dossier). Ces blocs sont générés
     * dynamiquement par SybrisPayload (un bloc échéance + un bloc capital
     * par prêt), on les cible via l'attribut data-subtype.
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

        // Le champ "N° Séquence" et le formulaire En-tête ne doivent être
        // visibles que tant que le flux est totalement vide (et, pour
        // l'en-tête, qu'une base a été sélectionnée — voir
        // updateEnteteFormVisibility).
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
                // frame est un String côté Java (la trame générée)
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

    /**
     * Affiche ou masque le champ #sequence-field-wrapper (N° Séquence
     * d'enregistrement) selon que le flux est vide ou non. Le rendu JSP ne
     * s'exécute qu'au premier chargement de page ; comme toutes les actions
     * suivantes se font en AJAX sans rechargement, c'est ce toggle qui tient
     * l'affichage à jour ensuite.
     */
    updateSequenceFieldVisibility(fluxIsEmpty) {
        const wrapper = document.getElementById('sequence-field-wrapper');
        if (wrapper) {
            wrapper.style.display = fluxIsEmpty ? '' : 'none';
        }
    },

    /**
     * Révèle #enteteForm seulement si les DEUX conditions sont vraies :
     * flux vide ET une base est sélectionnée. Le JSP part de
     * style="display:none" (évite le flash visible avant que le fetch
     * initial /sybris/flux ait résolu) ; on ne l'enlève ("") que si les
     * deux conditions tiennent, sinon on le repose explicitement à "none"
     * (utile si le flux redevient vide après un clearFlux() alors qu'aucune
     * base n'est encore sélectionnée : il ne doit pas apparaître tout seul).
     * Appelée depuis displayFlux() (le flux change) ET selectBase() (la
     * base change) : les deux évènements peuvent faire basculer le résultat.
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

        // 1. Vider les éléments répétables (échéances / capitaux)
        SybrisPayload.clearPrets();
        SybrisPayload.clearItems('echeance');
        SybrisPayload.clearItems('capital');

        // 2. Vider les champs saisissables (les champs readonly gardent leur valeur)
        form.querySelectorAll('input, select, textarea').forEach(input => {
            if (input.readOnly || input.classList.contains('readonly-field')) return;
            if (input.type === 'checkbox' || input.type === 'radio') {
                input.checked = false;
            } else {
                input.value = '';
            }
        });

        // 3. Réappliquer les contraintes de risque (risque désormais vidé)
        this.updateRiskConstraints();
    }
};
